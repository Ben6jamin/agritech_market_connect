import 'package:agritech_carket_connect/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  final VoidCallback onLogout;
  final ThemeMode themeMode;
  final Function(bool) toggleTheme;

  const AppDrawer({
    Key? key,
    required this.onLogout,
    required this.toggleTheme,
    required this.themeMode,
  }) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String? username;
  String? email;
  String? profilePictureUrl;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    const apiUrl = "$baseUrl/user"; // Replace with actual API

    try {
      print(apiUrl);
      SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('token');
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
        );
      print(response.body);
      print(response.body);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          username = data["username"];
          email = data["email"];
          profilePictureUrl = data["profile_picture"];
          isLoading = false;
        });
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = widget.themeMode == ThemeMode.dark;

    final primaryColor = isDarkMode ? Colors.green[700] : Colors.green[800];
    final accentColor = isDarkMode ? Colors.lightBlueAccent : Colors.blue;
    final backgroundColor = isDarkMode ? Color(0xFF121212) : Colors.white;
    final surfaceColor = isDarkMode ? Color(0xFF1E1E1E) : Colors.grey[100];
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final secondaryTextColor = isDarkMode ? Colors.white70 : Colors.black54;
    final dividerColor = isDarkMode ? Colors.white24 : Colors.grey[400];
    final dangerColor = Colors.redAccent;

    return Drawer(
      backgroundColor: surfaceColor,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: isLoading
                ? Text("Loading...", style: TextStyle(color: textColor))
                : hasError
                    ? Text("Error loading user", style: TextStyle(color: Colors.red))
                    : Text(username ?? "User", style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
            accountEmail: isLoading
                ? Text("")
                : hasError
                    ? Text("")
                    : Text(email ?? "No Email", style: TextStyle(color: secondaryTextColor)),
            currentAccountPicture: isLoading
                ? CircularProgressIndicator()
                : CircleAvatar(
                    backgroundColor: isDarkMode ? Colors.black45 : Colors.grey[300],
                    backgroundImage: profilePictureUrl != null ? NetworkImage(profilePictureUrl!) : null,
                    child: profilePictureUrl == null ? Icon(Icons.person, size: 40, color: accentColor) : null,
                  ),
            decoration: BoxDecoration(
              color: primaryColor,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primaryColor!, primaryColor.withOpacity(0.7)],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: accentColor),
            title: Text("Home", style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, "/dashboard");
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback, color: accentColor),
            title: Text("Leave feedback", style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/feedback");
            },
          ),
          Divider(color: dividerColor),
          SwitchListTile(
            title: Text(isDarkMode ? "Light Mode" : "Dark Mode", style: TextStyle(color: textColor)),
            secondary: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round, color: accentColor),
            value: isDarkMode,
            onChanged: widget.toggleTheme,
            activeColor: accentColor,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ListTile(
              leading: Icon(Icons.logout, color: dangerColor),
              title: Text("Logout", style: TextStyle(color: dangerColor)),
              onTap: () {
                Navigator.pop(context);
                widget.onLogout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
