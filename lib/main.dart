import 'package:agritech_carket_connect/screens/MarketPricesScreen.dart';
import 'package:agritech_carket_connect/screens/WeatherUpdateScreen.dart';
import 'package:agritech_carket_connect/screens/farmingTipsScreen.dart';
import 'package:agritech_carket_connect/screens/feedbackScreen.dart';
import 'package:agritech_carket_connect/screens/fertilizersScreen.dart';
import 'package:agritech_carket_connect/screens/seedsScreen.dart';
import 'package:agritech_carket_connect/screens/signupScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/dashboard.dart';
import 'screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light; 

  @override
  void initState() {
    super.initState();
    _loadTheme(); // Load saved theme on startup
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    setState(() {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _toggleTheme(bool isDark) async {
    print("Dark mode: $isDark");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  // Define the light theme
  ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green[800] ?? Colors.green,
      brightness: Brightness.light,
    ),
    cardTheme: CardTheme(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 2,
      centerTitle: true,
    ),
  );

  // Define the dark theme
  ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.green[800] ?? Colors.green,
      brightness: Brightness.dark,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 3,
      centerTitle: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AgriTech Market Connect',
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: _themeMode,
      initialRoute: '/',
      routes: {
        '/' : (context) => LoginScreen(toggleTheme: _toggleTheme, themeMode: _themeMode),
        '/signup': (context) => SignUpScreen(),
        '/dashboard': (context) => SeedsScreen(toggleTheme: _toggleTheme, themeMode: _themeMode),
        '/seeds': (context) => SeedsScreen(toggleTheme: _toggleTheme, themeMode: _themeMode),
        '/fertilizers': (context) => FertilizersScreen(),
        '/market-prices': (context) => MarketPricesScreen(),
        '/weather-updates': (context) => WeatherUpdatesScreen(),
        '/farming-tips': (context) => FarmingTipsScreen(),
        '/feedback': (context) => FeedbackScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
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
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              child: const Text('Dashboard'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/seeds');
              },
              child: const Text('Seeds'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/fertilizers');
              },
              child: const Text('Fertilizers'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/market-prices');
              },
              child: const Text('Market Prices'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/weather-updates');
              },
              child: const Text('Weather Updates'),
            ),
            SizedBox(height: 10),
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