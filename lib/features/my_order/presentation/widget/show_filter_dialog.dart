import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/common/constants.dart';

Future<dynamic> showFilterDialog(BuildContext context) async {
  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      title: const Text(
        'Фильтровать',
        style:  TextStyle(
            fontSize: 14,
            color: AppColors.kGray300,
            fontWeight: FontWeight.w400),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text(
            'Новые заказы',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context, 'One');
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Старые заказы',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context, 'Two');
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text(
          'Отменить',
          style: TextStyle(
            color: AppColors.kPrimaryColor,
          ),
        ),
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
      ),
    ),
  );
}
