import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/edit_product_page%20copy.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/show_alert_add_widget.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/statistics_page.dart';
import 'package:haji_market/features/basket/presentation/widgets/show_alert_statictics_widget%20copy.dart';

import '../../../../core/common/constants.dart';

Future<dynamic> showAlertAddressWidget(BuildContext context) async {
  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text(
            'Выберите адрес доставки',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
          onPressed: () {},
        ),
        CupertinoActionSheetAction(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  GetStorage().write('basket_address_box', 1);
                  Navigator.pop(context);
                  showAlertAddressWidget(context);
                },
                child: Icon(
                  GetStorage().read('basket_address_box') == 1
                      ? Icons.check_circle
                      : Icons.check_box_outline_blank,
                  color: AppColors.kPrimaryColor,
                  size: 24.0,
                ),
              ),
              SizedBox(width: 16),
              Container(
                width: 270,
                child: const Text(
                  'г. Алматы , Шевченко 90 (БЦ Каратал)',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                  maxLines: 1,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);

                  showAlertEditDestroyWidget(context);
                },
                child: const Icon(
                  Icons.more_horiz,
                  color: AppColors.kPrimaryColor,
                  size: 24.0,
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StatisticsPage()),
            );
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Добавить новый адрес',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
          ),
          onPressed: () {
            // showAlertAddWidget(context, product);
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text(
          'Выбрать',
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
