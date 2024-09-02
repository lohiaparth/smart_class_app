import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Quiz(),
      ),
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
  final TextEditingController _textController = TextEditingController();

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
    {
      'question': "What is Kothari's First Name?", // New text input question
      'type': 'text',
      'correctAnswer': 'Ayush', // Added correct answer here
    },
  ];

  void _answerQuestion(int score) {
    setState(() {
      _score += score;
      _questionIndex += 1;
    });
  }

  void _submitTextAnswer(String answer) {
    String correctAnswer = (_questions[_questionIndex]['correctAnswer'] as String).toLowerCase();
    if (answer.toLowerCase() == correctAnswer) {
      _score += 1;
    }
    setState(() {
      _questionIndex += 1;
    });
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return _questionIndex < _questions.length
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _questions[_questionIndex]['question'] as String,
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              if (_questions[_questionIndex].containsKey('answers'))
                ...(_questions[_questionIndex]['answers'] as List<Map<String, Object>>)
                    .map((answer) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                            ),
                            child: Text(answer['text'] as String),
                            onPressed: () => _answerQuestion(answer['score'] as int),
                          ),
                        ))
                    .toList(),
              if (_questions[_questionIndex]['type'] == 'text')
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          labelText: 'Enter your answer',
                          border: OutlineInputBorder(),
                        ),
                        onSubmitted: _submitTextAnswer,
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => _submitTextAnswer(_textController.text),
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ),
            ],
          )
        : Center(
            child: Text(
              'Your score is: $_score',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          );
  }
}
