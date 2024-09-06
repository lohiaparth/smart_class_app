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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isProfileVisible = false;

  void _toggleProfile() {
    setState(() {
      _isProfileVisible = !_isProfileVisible;
    });
  }

  final List<Map<String, dynamic>> lectures = [
    {'name': 'Mathematics', 'icon': Icons.calculate},
    {'name': 'Science', 'icon': Icons.science},
    {'name': 'History', 'icon': Icons.history_edu},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Class App'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: _toggleProfile,
          ),
        ],
      ),
      body: Stack(
        children: [
          GridView.builder(
            padding: EdgeInsets.all(16.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 1,
            ),
            itemCount: lectures.length,
            itemBuilder: (context, index) {
              return LectureCard(
                lectureName: lectures[index]['name'],
                lectureIcon: lectures[index]['icon'],
              );
            },
          ),
          if (_isProfileVisible)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: 300,
              child: ProfileOverlay(onClose: _toggleProfile),
            ),
        ],
      ),
    );
  }
}

class LectureCard extends StatelessWidget {
  final String lectureName;
  final IconData lectureIcon;

  LectureCard({required this.lectureName, required this.lectureIcon});

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                lectureIcon,
                size: 48,
                color: Colors.blue,
              ),
              SizedBox(height: 16),
              Text(
                lectureName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
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

class ProfileOverlay extends StatelessWidget {
  final VoidCallback onClose;

  ProfileOverlay({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.9), // Opaque background
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Full-width buttons
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: onClose,
            ),
          ),
          SizedBox(height: 16),
          // Profile Picture
          CircleAvatar(
            radius: 50, 
            backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Replace with your profile picture URL
          ),
          SizedBox(height: 16),
          // Details Section
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // Full-width buttons
                children: [
                  // SAP ID
                  Row(
                    children: [
                      Icon(Icons.badge, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Sap ID: 70322000056',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Roll Number
                  Row(
                    children: [
                      Icon(Icons.numbers, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Roll no: C116',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Email
                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'ayushkothari@gmail.com',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Phone Number
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        '9878565422',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Profile Option
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Profile',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Change Password Option
                  Row(
                    children: [
                      Icon(Icons.lock, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Change password',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Logout Button with Gradient
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.lightGreenAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle logout action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'LOGOUT',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.logout, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


