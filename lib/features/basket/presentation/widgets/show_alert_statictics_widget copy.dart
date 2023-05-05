import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/edit_product_page%20copy.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/show_alert_add_widget.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/statistics_page.dart';
import 'package:haji_market/features/basket/presentation/widgets/show_alert_edit_widget.dart';

import '../../../../core/common/constants.dart';

Future<dynamic> showAlertEditDestroyWidget(BuildContext context) async {
  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Row(
            children: [
              Icon(
                Icons.create,
                color: Colors.red,
                size: 24.0,
              ),
              SizedBox(width: 16),
              Container(
                width: 270,
                child: const Text(
                  'Редактировать',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                  maxLines: 1,
                ),
              ),
            ],
          ),
          onPressed: () {
            // GetStorage().write('basket_address_box', 1);
            Navigator.pop(context);
            showAlertEditWidget(context);
          },
        ),
        CupertinoActionSheetAction(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  // GetStorage().write('basket_address_box', 1);
                  Navigator.pop(context);
                  showAlertEditWidget(context);
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 24.0,
                ),
              ),
              SizedBox(width: 16),
              Container(
                width: 270,
                child: const Text(
                  'Удалить',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                  maxLines: 1,
                ),
              ),
            ],
          ),
          onPressed: () {
            // showAlertAddWidget(context, product);
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text(
          'Отмена',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
      ),
    ),
  );
}
