import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:agritech_carket_connect/constants.dart';
import 'package:flutter/material.dart';

class WeatherUpdatesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather Updates"),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchWeatherUpdates(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No weather updates available"));
          }

          final weatherUpdates = snapshot.data!;
          return ListView.builder(
            itemCount: weatherUpdates.length,
            itemBuilder: (context, index) {
              final weather = weatherUpdates[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(
                    weather['condition'] == 'Sunny'
                        ? Icons.wb_sunny
                        : Icons.cloud,
                    color: Colors.orange,
                    size: 40,
                  ),
                  title: Text("Date: ${weather['date']}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Temp: ${weather['min_temp']}°C - ${weather['max_temp']}°C"),
                      Text("Humidity: ${weather['humidity']}%"),
                      Text("Wind Speed: ${weather['wind_speed']} km/h"),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<dynamic>> fetchWeatherUpdates() async {
    const url = '$baseUrl/weather-updates';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load seeds');
    }
  }
}
