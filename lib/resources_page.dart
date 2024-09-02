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
      ),
      body: ListView.builder(
        itemCount: resources.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(resources[index]),
            trailing: Icon(Icons.download),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Downloading ${resources[index]}...')),
              );
            },
          );
        },
      ),
    );
  }
}
