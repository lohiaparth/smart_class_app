import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// This widget represents the Whiteboard page, where users can draw
/// and the coordinates are sent to a WebSocket server.
class WhiteboardPage extends StatefulWidget {
  @override
  _WhiteboardPageState createState() => _WhiteboardPageState();
}

class _WhiteboardPageState extends State<WhiteboardPage> {
  // List to hold all the strokes (each stroke is a list of points)
  List<List<Offset>> strokes = [];
  List<Offset> currentStroke = [];

  // WebSocket channel to communicate with the server
  final WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse('ws://10.0.2.2:8080'), // Replace with your WebSocket server address
  );

  @override
  void initState() {
    super.initState();

    // Listening to incoming messages from the WebSocket
    channel.stream.listen((message) {
      print('Message received from server: $message');
      _processIncomingStrokeData(message); // Process and draw the incoming stroke
    });
  }

  // Function to send stroke data to the server
  void sendStrokeData(List<Offset> points) {
    for (int i = 0; i < points.length - 1; i++) {
      final message = 'DRAW ${points[i].dx},${points[i].dy},${points[i + 1].dx},${points[i + 1].dy}';
      channel.sink.add(message); // Send the message via WebSocket
    }
  }

  // Process the incoming stroke data
  void _processIncomingStrokeData(String message) {
    if (message.startsWith('DRAW')) {
      // Example: "DRAW x1,y1,x2,y2"
      final parts = message.split(' ');
      if (parts.length == 2) {
        final coordinates = parts[1].split(',');
        if (coordinates.length == 4) {
          final x1 = double.tryParse(coordinates[0]) ?? 0;
          final y1 = double.tryParse(coordinates[1]) ?? 0;
          final x2 = double.tryParse(coordinates[2]) ?? 0;
          final y2 = double.tryParse(coordinates[3]) ?? 0;

          // Create two points based on the coordinates
          final point1 = Offset(x1, y1);
          final point2 = Offset(x2, y2);

          // Add these points as a stroke and update the state to trigger a repaint
          setState(() {
            strokes.add([point1, point2]);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Whiteboard with WebSocket'),
      ),
      body: GestureDetector(
        // Detect when the user starts drawing
        onPanStart: (details) {
          setState(() {
            currentStroke = [details.localPosition]; // Start a new stroke
          });
        },
        // Detect when the user moves their finger
        onPanUpdate: (details) {
          setState(() {
            currentStroke.add(details.localPosition); // Add new points to the current stroke
          });
        },
        // Detect when the user lifts their finger
        onPanEnd: (details) {
          setState(() {
            strokes.add(currentStroke); // Save the completed stroke
            sendStrokeData(currentStroke); // Send stroke data to the WebSocket server
            currentStroke = []; // Clear the current stroke for the next one
          });
        },
        child: CustomPaint(
          painter: WhiteboardPainter(strokes, currentStroke),
          size: Size.infinite, // Make the canvas fill the screen
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.clear),
        onPressed: () {
          setState(() {
            strokes.clear(); // Clear all strokes
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close(); // Close the WebSocket connection when the widget is disposed
    super.dispose();
  }
}

/// Custom painter class that draws the strokes on the canvas
class WhiteboardPainter extends CustomPainter {
  final List<List<Offset>> strokes; // List of all completed strokes
  final List<Offset> currentStroke; // Current stroke being drawn by the user

  WhiteboardPainter(this.strokes, this.currentStroke);

  @override
  void paint(Canvas canvas, Size size) {
    // Define the paint style for the strokes
    Paint paint = Paint()
      ..color = Colors.black // Set the stroke color to black
      ..strokeCap = StrokeCap.round // Set the stroke cap to rounded
      ..strokeWidth = 5.0; // Set the stroke width to 5

    // Draw all completed strokes
    for (var stroke in strokes) {
      for (int i = 0; i < stroke.length - 1; i++) {
        canvas.drawLine(stroke[i], stroke[i + 1], paint);
      }
    }

    // Draw the current stroke being drawn by the user
    for (int i = 0; i < currentStroke.length - 1; i++) {
      canvas.drawLine(currentStroke[i], currentStroke[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always repaint when there are changes
  }
}
