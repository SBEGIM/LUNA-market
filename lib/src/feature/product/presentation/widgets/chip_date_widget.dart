import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';

Widget chipDate(
  String label,
  int index,
  int select,
) {
  return Chip(
    labelPadding: const EdgeInsets.all(4.0),
    label: Text(
      label,
      style: const TextStyle(
        color: AppColors.kGray900,
      ),
    ),
    backgroundColor:
        select != index ? const Color(0xFFEBEDF0) : AppColors.kPrimaryColor,
    // elevation: 1.0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(4),
            bottomRight: Radius.circular(4),
            topLeft: Radius.circular(4),
            bottomLeft: Radius.circular(4))),
    // shadowColor: Colors.grey[60],
    padding: const EdgeInsets.all(6.0),
  );
}
