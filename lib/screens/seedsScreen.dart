import 'dart:convert';
import 'package:agritech_carket_connect/screens/appDrawer.dart';
import 'package:http/http.dart' as http;
import 'package:agritech_carket_connect/constants.dart';
import 'package:agritech_carket_connect/screens/seedsDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeedsScreen extends StatefulWidget {
  final Function(bool) toggleTheme;
  final ThemeMode themeMode;

  const SeedsScreen(
      {super.key, required this.toggleTheme, required this.themeMode});

  @override
  State<SeedsScreen> createState() => _SeedsScreenState();
}

class _SeedsScreenState extends State<SeedsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = widget.themeMode == ThemeMode.dark;
    print("Dark mode: $isDarkMode");

    // Define theme-aware colors
    final primaryColor = theme.colorScheme.primary;
    final textColor = theme.textTheme.bodyLarge?.color;
    final cardBackgroundColor = theme.cardColor;
    final backgroundColor = theme.scaffoldBackgroundColor;
    final chipTextColor = isDarkMode ? Colors.black : Colors.white;

    // Define availability status colors that work well in both themes
    final inStockColor = isDarkMode ? Colors.green.shade600 : Colors.green;
    final outOfStockColor = isDarkMode ? Colors.red.shade700 : Colors.red;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(),
      drawer: AppDrawer(
        toggleTheme: widget.toggleTheme,
        themeMode: widget.themeMode,
        onLogout: () {
          logout(context);
        },
      ),
      body: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, Farmer!',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            // Market Trends Section
            Text(
              'Seeds Trends',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                future: fetchSeeds(), // Replace with your API fetch function
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text("Error loading seeds",
                            style: TextStyle(color: textColor)));
                  } else {
                    final seeds = snapshot.data; // Replace with parsed data
                    return ListView.builder(
                      itemCount: seeds?.length,
                      itemBuilder: (context, index) {
                        final seed = seeds?[index];
                        return Card(
                          margin: EdgeInsets.all(8.0),
                          color: cardBackgroundColor,
                          elevation: isDarkMode ? 2 : 1,
                          shadowColor:
                              isDarkMode ? Colors.white24 : Colors.black26,
                          child: ListTile(
                            leading: Container(
                              padding: EdgeInsets.all(2),
                              decoration: isDarkMode
                                  ? BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade700,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(4),
                                    )
                                  : null,
                              child: seed['image'] != null
                                  ? Image.network(seed['image'],
                                      width: 50, height: 50)
                                  : Icon(Icons.eco, color: primaryColor),
                            ),
                            title: Text(seed['name'],
                                style: TextStyle(color: textColor)),
                            subtitle: Text(
                              "Price: ${seed['price_per_kg']} RWF/kg",
                              style:
                                  TextStyle(color: textColor?.withOpacity(0.7)),
                            ),
                            trailing: Chip(
                              label: Text(
                                seed['availability_status']
                                    ? "In Stock"
                                    : "Out of Stock",
                                style: TextStyle(color: chipTextColor),
                              ),
                              backgroundColor: seed['availability_status']
                                  ? inStockColor
                                  : outOfStockColor,
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
                _buildNavigationButton(
                  context: context,
                  label: 'Fertilizers',
                  route: '/fertilizers',
                  theme: theme,
                ),
                _buildNavigationButton(
                  context: context,
                  label: 'Market Prices',
                  route: '/market-prices',
                  theme: theme,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavigationButton(
                  context: context,
                  label: 'Weather Updates',
                  route: '/weather-updates',
                  theme: theme,
                ),
                _buildNavigationButton(
                  context: context,
                  label: 'Farming Tips',
                  route: '/farming-tips',
                  theme: theme,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton({
    required BuildContext context,
    required String label,
    required String route,
    required ThemeData theme,
  }) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: Text(
        label,
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        fixedSize: Size(170, 50),
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

  void logout(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('token');
      Navigator.pushReplacementNamed(context, '/');
    });
  }
}
