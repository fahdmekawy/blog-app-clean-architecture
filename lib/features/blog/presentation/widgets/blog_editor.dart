import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;

  const BlogEditor({
    super.key,
    required this.textController,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(hintText: hintText),
      maxLines: null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$hintText is missing!';
        }
        return null;
      },
    );
  }
}
