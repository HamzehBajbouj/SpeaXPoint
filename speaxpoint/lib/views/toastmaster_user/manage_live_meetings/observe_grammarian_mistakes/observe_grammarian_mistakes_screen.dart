import 'package:flutter/material.dart';

class ObserveGrammarianMistakesScreen extends StatefulWidget {
  const ObserveGrammarianMistakesScreen({super.key});

  @override
  State<ObserveGrammarianMistakesScreen> createState() =>
      _ObserveGrammarianMistakesScreenState();
}

class _ObserveGrammarianMistakesScreenState
    extends State<ObserveGrammarianMistakesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Observe Grammarian Mistakes Screen"),
      ),
    );
  }
}
