import 'package:flutter/material.dart';
import 'package:quiz_advanced/screens/result_screen/result_screen.dart';
import 'package:quiz_advanced/screens/start_screen/start_screen.dart';
import 'package:quiz_advanced/screens/questions_screen/questions_screen.dart';

import 'data/questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  // Widget? screen;
  String screen = 'start-screen';
  List<String> selectedAnswers = [];

  // @override
  // void initState() {
  //   screen = StartScreen(switchScreen);
  //   super.initState();
  // }

  void switchScreen() {
    setState(() {
      //screen = const Questions();
      screen = 'questions';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        screen = 'result-screen';
        //selectedAnswers = [];
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      screen = 'start-screen';
    });
  }

  Widget getScreen() {
    switch (screen) {
      case 'start-screen':
        return StartScreen(switchScreen);
      case 'questions':
        return QuestionsScreen(chooseAnswer);
      case 'result-screen':
        return ResultScreen(
          selectedAnswers: selectedAnswers,
          restartQuiz: restartQuiz,
        );
      default:
        return StartScreen(switchScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple,
                Colors.black,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: getScreen(),
        ),
      ),
    );
  }
}
