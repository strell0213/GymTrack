import 'package:flutter/material.dart';

class AddViewModel extends ChangeNotifier{

  bool checkControllerText(String text) {
    return text.trim().isNotEmpty;
  }
}