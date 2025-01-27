import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  // Dummy Data for Market Trends
  final List<Map<String, String>> marketTrends = [
    {'crop': 'Maize', 'price': '\$200/ton', 'change': '+5%'},
    {'crop': 'Tomatoes', 'price': '\$1.50/kg', 'change': '-2%'},
    {'crop': 'Wheat', 'price': '\$150/ton', 'change': '+3%'},
    {'crop': 'Beans', 'price': '\$2.00/kg', 'change': '+1%'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.green[800],
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Navigate to Notifications screen
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Message
            Text(
              'Hello, Farmer!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Market Trends Section
            Text(
              'Market Trends',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // List of Market Trends
            Expanded(
              child: ListView.builder(
                itemCount: marketTrends.length,
                itemBuilder: (context, index) {
                  final trend = marketTrends[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(trend['crop']!),
                      subtitle: Text(trend['price']!),
                      trailing: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: trend['change']!.startsWith('+')
                              ? Colors.green[100]
                              : Colors.red[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          trend['change']!,
                          style: TextStyle(
                            color: trend['change']!.startsWith('+')
                                ? Colors.green[800]
                                : Colors.red[800],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Market'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}