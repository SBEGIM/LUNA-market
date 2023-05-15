import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/edit_product_page.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/statistics_page.dart';
import 'dart:io';
import '../../../../core/common/constants.dart';
import '../../data/models/admin_products_model.dart';

Future<dynamic> showAlertAddWidget(
    BuildContext context, AdminProductsModel product) async {
  int ad = 0;

  GetStorage().listenKey('add_box', (value) {
    ad = value;
    // setState(() => selectedRadio = value);
  });

  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text(
            'Выберите формат рекламы',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditProductPage(
                        product: product,
                      )),
            );
          },
        ),
        Container(
          height: 30,
          margin: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '1000 просмотров / 556 900 руб',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
              GestureDetector(
                onTap: () {
                  GetStorage().write('add_box', 1);
                  Navigator.pop(context);
                  showAlertAddWidget(context, product);
                },
                child: Icon(
                  GetStorage().read('add_box') == 1
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: AppColors.kPrimaryColor,
                  size: 24.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 30,
          margin: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '3000 просмотров / 1000 900 руб',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
              GestureDetector(
                onTap: () {
                  GetStorage().write('add_box', 2);
                  Navigator.pop(context);
                  showAlertAddWidget(context, product);
                },
                child: Icon(
                  GetStorage().read('add_box') == 2
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: AppColors.kPrimaryColor,
                  size: 24.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 30,
          margin: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '5000 просмотров / 1500 900 руб',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
              GestureDetector(
                onTap: () {
                  GetStorage().write('add_box', 3);
                  Navigator.pop(context);
                  showAlertAddWidget(context, product);
                },
                child: Icon(
                  GetStorage().read('add_box') == 3
                      ? Icons.check_box
                      : Icons.check_box_outline_blank,
                  color: AppColors.kPrimaryColor,
                  size: 24.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
              ),
            ],
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text(
          'Отмена',
          style: TextStyle(
              color: AppColors.kPrimaryColor, fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
      ),
    ),
  );
}
