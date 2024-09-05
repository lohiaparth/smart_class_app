import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img.jpg'), // Use the local image
                fit: BoxFit.cover, // Ensures the image covers the entire background
              ),
            ),
          ),
          // Foreground - Login Form
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Login Header Text
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text to contrast with the background
                    ),
                  ),
                  Text(
                    'to the student portal',
                    style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  SizedBox(height: 40),
                  
                  // Student ID Field
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                      labelText: 'Student Id',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // Password Field
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  
                  // Login Button with Green Gradient
                  GestureDetector(
                    onTap: () {
                      // Handle login logic here
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [const Color.fromRGBO(53,222,147, 1), const Color.fromRGBO(29,120,79, 1)], // Green gradient
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward, color: Colors.white),
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
