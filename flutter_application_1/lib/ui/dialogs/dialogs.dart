import 'dart:ui';

import 'package:flutter/material.dart';

class DialogClass{

void showDeleteConfirmationDialog(BuildContext context, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Удаление'),
        content: const Text('Вы уверены, что хотите удалить?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Отмена'),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Закрыть диалог
            },
          ),
          TextButton(
            child: const Text('Удалить', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Закрыть диалог
              onConfirm(); // Выполнить удаление
            },
          ),
        ],
      );
    },
  );
}

}