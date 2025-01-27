import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo/Name
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

            // Email/Phone Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Email/Phone',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                prefixIcon: Icon(Icons.email, color: Colors.green),
              ),
            ),
            SizedBox(height: 20),

            // Password Field
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                prefixIcon: Icon(Icons.lock, color: Colors.green),
              ),
            ),
            SizedBox(height: 40),

            // Login Button
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/dashboard');
                },
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
    );
  }
}