import 'package:flutter/material.dart';

class BasketWidget extends StatelessWidget {
  const BasketWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:
          100, // Roughly 25% of screen depending on width, we handle precise catch logic in domain
      height: 20,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.5),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );
  }
}
