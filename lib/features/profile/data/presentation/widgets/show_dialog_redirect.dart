import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/common/constants.dart';

Future<dynamic> showDialogRegirect(BuildContext context) async {
  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text(
            'Редактировать',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context, 'One');
          },
        ),
        CupertinoActionSheetAction(
          child: Text(
            'Удалить',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Navigator.pop(context, 'Two');
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          'Отменить',
          style: const TextStyle(
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
