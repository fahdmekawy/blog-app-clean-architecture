import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  try {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      return File(file.path);
    }
    return null;
  } catch (e) {
    debugPrint(e.toString());
    return null;
  }
}
