import 'package:flutter/material.dart';

Widget chip(
  String label,
  Color color,
) {
  return Chip(
    labelPadding: const EdgeInsets.all(4.0),
    label: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: color,
    elevation: 1.0,

    // shadowColor: Colors.grey[60],
    padding: const EdgeInsets.all(6.0),
  );
}
