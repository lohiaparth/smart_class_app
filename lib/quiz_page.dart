// quiz_page.dart
import 'package:flutter/material.dart';

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
