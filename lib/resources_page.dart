// resources_page.dart
import 'package:flutter/material.dart';

class ResourcesPage extends StatelessWidget {
  final List<String> resources = [
    'Mathematics.pdf',
    'Science.pdf',
    'History.pdf',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resources'),
        
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality here
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: resources.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 5.0),
            child: ListTile(
              leading: Icon(Icons.picture_as_pdf, color: Colors.red), // Icon based on file type
              title: Text(
                resources[index],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Tap to download'),
              trailing: Icon(Icons.download),
              onTap: () {
                // Implement the download functionality here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Downloading ${resources[index]}...'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
