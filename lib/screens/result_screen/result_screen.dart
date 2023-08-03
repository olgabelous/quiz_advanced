import 'package:flutter/material.dart';
import 'package:quiz_advanced/data/questions.dart';
import 'package:quiz_advanced/screens/result_screen/question_summary.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.selectedAnswers,
    required this.restartQuiz,
  });

  final List<String> selectedAnswers;
  final void Function() restartQuiz;

  List<Map<String, Object>> getSummary() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < selectedAnswers.length; i++) {
      summary.add(
        {
          'index': i,
          'question': questions[i].text,
          'answer': selectedAnswers[i],
          'correctAnswer': questions[i].answers[0],
        },
      );
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummary();
    final totalQuestions = questions.length;
    final correctQuestions = summaryData.where((item) {
      return item['answer'] == item['correctAnswer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $correctQuestions out of $totalQuestions questions correctly!',
              style: const TextStyle(
                color: Color.fromARGB(255, 253, 190, 236),
                fontSize: 20,
                //fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionSummary(summaryData),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: restartQuiz,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
