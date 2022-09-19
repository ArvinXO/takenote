// reusable options sheet widget
import 'package:flutter/material.dart';

class OptionsSheet extends StatelessWidget {
  const OptionsSheet({
    Key? key,
    required this.title,
    required this.options,
  }) : super(key: key);

  final String title;
  final List<Widget> options;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        children: [
          Container(
            height: 50,
            color: Colors.grey[200],
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: options,
            ),
          ),
        ],
      ),
    );
  }
}
