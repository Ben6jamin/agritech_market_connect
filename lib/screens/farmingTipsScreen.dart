import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:agritech_carket_connect/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FarmingTipsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Farming Tips"),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchFarmingTips(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No farming tips available"));
          }

          final tips = snapshot.data!;
          return ListView.builder(
            itemCount: tips.length,
            itemBuilder: (context, index) {
              final tip = tips[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  leading: tip['image'] != null
                      ? Image.network(tip['image'], width: 50, height: 50)
                      : Icon(Icons.lightbulb_outline, color: Colors.green),
                  title: Text(tip['title']),
                  subtitle: Text(tip['description']),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<dynamic>> fetchFarmingTips() async {
    const url = '$baseUrl/farming-tips';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('token');
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $accessToken',
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.body);
      throw Exception('Failed to load farming tips');
    }
  }
}
