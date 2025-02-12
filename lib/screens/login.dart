import 'package:agritech_carket_connect/constants.dart';
import 'package:agritech_carket_connect/screens/dashboard.dart';
import 'package:agritech_carket_connect/screens/seedsScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
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
        final String token = responseData['access']; // Assuming the backend returns a token

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        Navigator.push(context, MaterialPageRoute(builder: (context) => SeedsScreen()));
      } else {
        print(response.body);
        // Login failed
        final Map<String, dynamic> errorData = json.decode(response.body);
        setState(() {
          _errorMessage = errorData['error'] ?? 'Login failed. Please try again.';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 140),
              Text(
                'AgriTech Market Connect',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              SizedBox(height: 40),
          
              // username/Phone Field
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  prefixIcon: Icon(Icons.email, color: Colors.green),
                ),
              ),
              SizedBox(height: 20),
          
              // Password Field
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  prefixIcon: Icon(Icons.lock, color: Colors.green),
                ),
              ),
              SizedBox(height: 20),
          
              // Error Message
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              SizedBox(height: 20),
          
              // Login Button
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[800],
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 10),
          
              // Forgot Password Link
              TextButton(
                onPressed: () {
                  // Navigate to Forgot Password screen
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.green[800]),
                ),
              ),
              SizedBox(height: 10),
          
              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don’t have an account? '),
                  TextButton(
                    onPressed: () {
                      // Navigate to Sign Up screen
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.green[800]),
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