import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final String username;
  final String email;
  final VoidCallback onLogout;

  const AppDrawer({
    Key? key,
    required this.username,
    required this.email,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(username, style: TextStyle(fontWeight: FontWeight.bold)),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.green[800]),
            ),
            decoration: BoxDecoration(
              color: Colors.green[800],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.green[800]),
            title: Text("Home", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, "/dashboard");
            },
          ),
          ListTile(
            leading: Icon(Icons.feedback, color: Colors.green[800]),
            title: Text("Leave feedback", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/feedback");
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              onLogout();
            },
          ),
        ],
      ),
    );
  }
}
