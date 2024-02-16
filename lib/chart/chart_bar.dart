import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({super.key, required this.fill});

  final double fill;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: FractionallySizedBox(
            heightFactor: fill,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
                color: Colors.black
              ),
            ),
          ),
        ),
    );
  }
}
