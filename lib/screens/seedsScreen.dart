import 'dart:convert';
import 'package:agritech_carket_connect/screens/appDrawer.dart';
import 'package:http/http.dart' as http;
import 'package:agritech_carket_connect/constants.dart';
import 'package:agritech_carket_connect/screens/seedsDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.green[800],
      ),
      drawer: AppDrawer(
        username: "John Doe",
        email: "johndoe@example.com",
        onLogout: () {
          // Handle logout logic (e.g., clear session, navigate to login)
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, Farmer!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Market Trends Section
            Text(
              'Seeds Trends',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                future: fetchSeeds(), // Replace with your API fetch function
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error loading seeds"));
                  } else {
                    final seeds = snapshot.data; // Replace with parsed data
                    return ListView.builder(
                      itemCount: seeds?.length,
                      itemBuilder: (context, index) {
                        final seed = seeds?[index];
                        return Card(
                          margin: EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: seed['image'] != null
                                ? Image.network(seed['image'],
                                    width: 50, height: 50)
                                : Icon(Icons.eco),
                            title: Text(seed['name']),
                            subtitle:
                                Text("Price: ${seed['price_per_kg']} RWF/kg"),
                            trailing: Chip(
                              label: Text(
                                seed['availability_status']
                                    ? "In Stock"
                                    : "Out of Stock",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: seed['availability_status']
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SeedDetailScreen(seed: seed),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/fertilizers');
                  },
                  child: Text('Fertilizers',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      fixedSize: Size(170, 50)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/market-prices');
                  },
                  child: Text('Market Prices',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      fixedSize: Size(170, 50)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/weather-updates');
                  },
                  child: Text('Weather Updates',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      fixedSize: Size(170, 50)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/farming-tips');
                  },
                  child: Text('Farming Tips',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      fixedSize: Size(170, 50)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<List> fetchSeeds() async {
    const url = '$baseUrl/seeds';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('token');
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $accessToken',
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load seeds');
    }
  }
}
