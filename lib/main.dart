import 'package:flutter/material.dart';

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
              child: Text('Whiteboard1'),
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

class WhiteboardPage extends StatefulWidget {
  @override
  _WhiteboardPageState createState() => _WhiteboardPageState();
}

class _WhiteboardPageState extends State<WhiteboardPage> {
  List<Offset> _points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Whiteboard'),
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            _points.add(renderBox.globalToLocal(details.globalPosition));
          });
        },
        onPanEnd: (details) {
          _points.add(Offset.zero);
        },
        child: CustomPaint(
          painter: WhiteboardPainter(_points),
          size: Size.infinite,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.clear),
        onPressed: () {
          setState(() {
            _points.clear();
          });
        },
      ),
    );
  }
}

class WhiteboardPainter extends CustomPainter {
  final List<Offset> points;
  WhiteboardPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != Offset.zero && points[i + 1] != Offset.zero) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(WhiteboardPainter oldDelegate) => oldDelegate.points != points;
}

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Quiz(),
    );
  }
}

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int _questionIndex = 0;
  int _score = 0;

  final List<Map<String, Object>> _questions = [
    {
      'question': 'What is the capital of France?',
      'answers': [
        {'text': 'Berlin', 'score': 0},
        {'text': 'Paris', 'score': 1},
        {'text': 'Madrid', 'score': 0},
        {'text': 'Rome', 'score': 0},
      ]
    },
    {
      'question': 'What is 2 + 2?',
      'answers': [
        {'text': '3', 'score': 0},
        {'text': '4', 'score': 1},
        {'text': '5', 'score': 0},
        {'text': '6', 'score': 0},
      ]
    },
    {
      'question': 'What is the color of the sky?',
      'answers': [
        {'text': 'Blue', 'score': 1},
        {'text': 'Green', 'score': 0},
        {'text': 'Yellow', 'score': 0},
        {'text': 'Red', 'score': 0},
      ]
    },
  ];

  void _answerQuestion(int score) {
    setState(() {
      _score += score;
      _questionIndex += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _questionIndex < _questions.length
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _questions[_questionIndex]['question'] as String,
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              ...(_questions[_questionIndex]['answers'] as List<Map<String, Object>>)
                  .map((answer) => ElevatedButton(
                        child: Text(answer['text'] as String),
                        onPressed: () => _answerQuestion(answer['score'] as int),
                      ))
                  .toList(),
            ],
          )
        : Center(
            child: Text(
              'Your score is: $_score',
              style: TextStyle(fontSize: 24),
            ),
          );
  }
}

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
              // Here you would normally download the file
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
