import 'package:flutter/material.dart';

class SeedDetailScreen extends StatelessWidget {
  final Map seed;

  SeedDetailScreen({required this.seed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(seed['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (seed['image'] != null)
              Center(
                child: Image.network(
                  seed['image'],
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: 16),
            Text(
              seed['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Price: ${seed['price_per_kg']} RWF/kg",
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 8),
            Text(
              seed['availability_status'] ? "Available" : "Out of Stock",
              style: TextStyle(
                fontSize: 16,
                color: seed['availability_status'] ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Description:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              seed['description'],
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
