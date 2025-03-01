import 'package:agritech_carket_connect/constants.dart';
import 'package:agritech_carket_connect/screens/dashboard.dart';
import 'package:agritech_carket_connect/screens/seedsScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final Function(bool) toggleTheme;
  final ThemeMode themeMode;

  LoginScreen({required this.toggleTheme, required this.themeMode});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for username/phone and password fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Error message to display
  String _errorMessage = '';

  // Function to handle login
  Future<void> _login() async {
    // Get username/phone and password from controllers
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    // Validate fields
    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Please fill in all fields.';
      });
      return;
    }

    // Send POST request to the Django backend
    try {
      print("username: $username");
      print("Password: $password");
      final response = await http.post(
        Uri.parse('$baseUrl/login/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );
      print(response.body);
      print("Response: ${response.statusCode}");

      // Handle response
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String token =
            responseData['access']; // Assuming the backend returns a token

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SeedsScreen(
                    toggleTheme: widget.toggleTheme,
                    themeMode: widget.themeMode
                    )));
      } else {
        print(response.body);
        // Login failed
        final Map<String, dynamic> errorData = json.decode(response.body);
        setState(() {
          _errorMessage =
              errorData['error'] ?? 'Login failed. Please try again.';
        });
      }
    } catch (e) {
      print('An error occurred: $e');
      print(e);
      setState(() {
        _errorMessage = 'An error occurred. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Theme-based colors
    final bool isDarkMode = widget.themeMode == ThemeMode.dark;
    final Color primaryColor = isDarkMode ? Colors.green[700]! : Colors.green[800]!;
    final Color textColor = isDarkMode ? Colors.white : Colors.black87;
    final Color backgroundColor = isDarkMode ? Color(0xFF121212) : Colors.white;
    final Color cardColor = isDarkMode ? Color(0xFF1E1E1E) : Colors.white;
    final Color accentColor = isDarkMode ? Colors.green : Colors.green;
    final Color inputBorderColor = isDarkMode ? Colors.white38 : Colors.grey;
    final Color inputFillColor = isDarkMode ? Colors.black12 : Colors.white;
    final Color errorColor = Colors.red;
    
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
              color: primaryColor,
            ),
            onPressed: () => widget.toggleTheme(!isDarkMode),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80),
              Text(
                'AgriTech Market Connect',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.green[800],
                ),
              ),
              SizedBox(height: 40),

              // username/Phone Field
              TextField(
                controller: _usernameController,
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: inputBorderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: inputBorderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: accentColor),
                  ),
                  filled: true,
                  fillColor: inputFillColor,
                  prefixIcon: Icon(Icons.person, color: accentColor),
                ),
              ),
              SizedBox(height: 20),

              // Password Field
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: textColor.withOpacity(0.7)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: inputBorderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: inputBorderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: accentColor),
                  ),
                  filled: true,
                  fillColor: inputFillColor,
                  prefixIcon: Icon(Icons.lock, color: accentColor),
                ),
              ),
              SizedBox(height: 20),

              // Error Message
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(color: errorColor),
                ),
              SizedBox(height: 20),

              // Login Button
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: isDarkMode ? 8 : 2,
                    shadowColor: isDarkMode ? accentColor.withOpacity(0.5) : null,
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(color: textColor),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: accentColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}