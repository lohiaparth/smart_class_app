import 'package:flutter/material.dart';
import 'whiteboard_page.dart';
import 'quiz_page.dart';
import 'resources_page.dart';

void main() => runApp(SmartClassApp());

class SmartClassApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Class',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<String> lectureNames = [
    'Lecture 1: Mathematics',
    'Lecture 2: Science',
    'Lecture 3: History',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Class App'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1,
        ),
        itemCount: lectureNames.length,
        itemBuilder: (context, index) {
          return LectureCard(
            lectureName: lectureNames[index],
          );
        },
      ),
    );
  }
}

class LectureCard extends StatelessWidget {
  final String lectureName;

  LectureCard({required this.lectureName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LectureDetailPage(lectureName: lectureName),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            lectureName,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class LectureDetailPage extends StatelessWidget {
  final String lectureName;

  LectureDetailPage({required this.lectureName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lectureName),
      ),
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: Colors.black87,
            selectedIndex: 0,
            onDestinationSelected: (int index) {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WhiteboardPage()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage()),
                );
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResourcesPage()),
                );
              }
            },
            labelType: NavigationRailLabelType.all,
            selectedLabelTextStyle: TextStyle(color: Colors.white),
            unselectedLabelTextStyle: TextStyle(color: Colors.white70),
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard, color: Colors.white70),
                selectedIcon: Icon(Icons.dashboard, color: Colors.white),
                label: Text('Whiteboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.quiz, color: Colors.white70),
                selectedIcon: Icon(Icons.quiz, color: Colors.white),
                label: Text('Quiz'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.book, color: Colors.white70),
                selectedIcon: Icon(Icons.book, color: Colors.white),
                label: Text('Resources'),
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Text(
                'Select an option from the sidebar',
                style: TextStyle(fontSize: 24, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
