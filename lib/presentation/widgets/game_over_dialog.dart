import 'package:flutter/material.dart';

class GameOverDialog extends StatelessWidget {
  final int score;
  final VoidCallback onRestart;

  const GameOverDialog({
    super.key,
    required this.score,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text(
        'Game Over',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      content: Text(
        'Final Score: $score',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: onRestart,
          child: const Text('Restart'),
        ),
      ],
    );
  }
}
