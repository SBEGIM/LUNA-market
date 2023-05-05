import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/statistics_page.dart';
import 'package:haji_market/bloger/my_products_admin/presentation/widgets/edit_product_page%20copy.dart';

import '../../../../core/common/constants.dart';
import '../../data/models/blogger_shop_products_model.dart';

Future<dynamic> showAlertStaticticsWidget(
    BuildContext context, BloggerShopProductModel product) async {
  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text(
            'Редактировать',
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
        CupertinoActionSheetAction(
          child: const Text(
            'Статистика',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
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
            'Удалить',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
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
              color: AppColors.kPrimaryColor, fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
      ),
    ),
  );
}
