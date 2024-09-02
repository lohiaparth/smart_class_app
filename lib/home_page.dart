// home_page.dart
import 'package:flutter/material.dart';
import 'whiteboard_page.dart';
import 'quiz_page.dart';
import 'resources_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Class App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Whiteboard'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WhiteboardPage()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Quiz'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Resources'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResourcesPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
