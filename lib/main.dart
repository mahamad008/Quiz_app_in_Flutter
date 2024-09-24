import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Question {
  final String questionText;
  final bool questionAnswer;

  Question({required this.questionText, required this.questionAnswer});
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Question> questions = [
    Question(questionText: 'Flutter is the best framework', questionAnswer: true),
    Question(questionText: 'Flutter is not the best framework', questionAnswer: false),
    Question(questionText: 'I am learning Flutter now', questionAnswer: true),
  ];

  int questionIndex = 0;
  int score = 0;

  void answerQuestion(bool userAnswer) {
    if (userAnswer == questions[questionIndex].questionAnswer) {
      score++;
      print('Correct!');
    } else {
      print('Incorrect!');
    }

    setState(() {
      if (questionIndex < questions.length - 1) {
        questionIndex++;
      } else {
        // Show score or restart the quiz
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Quiz Finished!'),
              content: Text('Your score: $score/${questions.length}'),
              actions: [
                TextButton(
                  child: Text('Restart'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      questionIndex = 0;
                      score = 0;
                    });
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Center(
              child: Text(
                questions[questionIndex].questionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 22),
                    height: 65,
                    child: ElevatedButton(
                      // style: ElevatedButton.styleFrom(Color: Colors.green),
                      onPressed: () => answerQuestion(true),
                      child: Text(
                        'True',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 22),
                    height: 65,
                    child: ElevatedButton(
                      // style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () => answerQuestion(false),
                      child: Text(
                        'False',
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}