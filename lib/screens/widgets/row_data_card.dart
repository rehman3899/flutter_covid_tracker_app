// StatelessWidget to display a row of data in a card
import 'package:flutter/material.dart';

class CardDataRow extends StatelessWidget {
  const CardDataRow({
    super.key,
    required this.title,
    required this.value,
  });

  final String title; // Title of the row
  final String value; // Value to be displayed

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0), // Padding around the row
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between title and value
            children: [
              Text(title), // Display title
              Text(value), // Display value
            ],
          ),
          const SizedBox(
            height: 3, // Spacing between rows
          ),
          const Divider(), // Divider between rows
        ],
      ),
    );
  }
}