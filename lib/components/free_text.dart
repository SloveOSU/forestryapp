import "package:flutter/material.dart";

/// Widget for entering free text, can be reused in different pages.

class FreeTextBox extends StatelessWidget {
  final TextEditingController controller;
  // final String header;
  final String hintText;
  final String labelText;
  final void Function(String) onChanged;

  const FreeTextBox({
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200, // Constrain the width of the FreeTextBox
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* Text(
            header,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ), */
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: labelText,
              hintText: hintText,
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
