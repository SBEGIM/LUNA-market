import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/statistics_page.dart';

import '../../../../core/common/constants.dart';

Future<dynamic> showAlertStaticticsWidget(BuildContext context) async {
  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text(
            'Редактировать',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context, 'One');
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Статистика',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StatisticsPage()),
                  );
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Удалить',
            style: TextStyle(color: Colors.red),
          ),
          onPressed: () {
            Navigator.pop(context, 'Two');
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text(
          'Отмена',
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
