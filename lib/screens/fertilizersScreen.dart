import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:agritech_carket_connect/constants.dart';
import 'package:flutter/material.dart';

class FertilizersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fertilizers"),
      ),
      body: FutureBuilder(
        future: fetchFertilizers(), // Add your API fetch function here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading fertilizers"));
          } else {
            final fertilizers = snapshot.data;
            return ListView.builder(
              itemCount: fertilizers?.length,
              itemBuilder: (context, index) {
                final fertilizer = fertilizers?[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: fertilizer['image'] != null
                        ? Image.network(fertilizer['image'], width: 50, height: 50)
                        : Icon(Icons.local_florist),
                    title: Text(fertilizer['name']),
                    subtitle: Text("Price: ${fertilizer['price_per_bag']} RWF/bag"),
                    trailing: Chip(
                      label: Text(
                        fertilizer['availability_status']
                            ? "In Stock"
                            : "Out of Stock",
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: fertilizer['availability_status']
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List> fetchFertilizers() async {
    const url = '$baseUrl/fertilizers';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load seeds');
    }
  }
}
