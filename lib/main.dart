import 'package:agritech_carket_connect/screens/MarketPricesScreen.dart';
import 'package:agritech_carket_connect/screens/WeatherUpdateScreen.dart';
import 'package:agritech_carket_connect/screens/farmingTipsScreen.dart';
import 'package:agritech_carket_connect/screens/fertilizersScreen.dart';
import 'package:agritech_carket_connect/screens/seedsScreen.dart';
import 'package:flutter/material.dart';

import 'screens/dashboard.dart';
import 'screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AgriTech Market Connect',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green[800] ?? Colors.greenAccent),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/' : (context) => MyHomePage(title: 'AgriTech Market Connect'),
        '/dashboard': (context) => SeedsScreen(),
        '/seeds': (context) => SeedsScreen(),
        '/fertilizers': (context) => FertilizersScreen(),
        '/market-prices': (context) => MarketPricesScreen(),
        '/weather-updates': (context) => WeatherUpdatesScreen(),
        '/farming-tips': (context) => FarmingTipsScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              child: const Text('Dashboard'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/seeds');
              },
              child: const Text('Seeds'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/fertilizers');
              },
              child: const Text('Fertilizers'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/market-prices');
              },
              child: const Text('Market Prices'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/weather-updates');
              },
              child: const Text('Weather Updates'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/farming-tips');
              },
              child: const Text('Farming Tips'),
            ),
          ],
        ),
      ),
    );
  }
}
