import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:agritech_carket_connect/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarketPricesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Market Prices"),
      ),
      body: FutureBuilder(
        future: fetchMarketPrices(), // Add your API fetch function here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading market prices"));
          } else {
            final prices = snapshot.data;
            return ListView.builder(
              itemCount: prices?.length,
              itemBuilder: (context, index) {
                final price = prices?[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text("${price['crop']}"),
                    subtitle: Text("Market: ${price['market_location']}"),
                    trailing: Text("${price['price_per_kg']} RWF/kg"),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List> fetchMarketPrices() async {
    const url = '$baseUrl/market-prices';
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
