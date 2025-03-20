import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/feature/shop/my_products_admin/data/bloc/ads_cubit.dart';
import 'package:haji_market/src/feature/shop/my_products_admin/data/bloc/product_admin_cubit.dart';
import 'package:haji_market/src/feature/shop/my_products_admin/data/repository/ProductAdminRepo.dart';
import 'package:haji_market/src/feature/shop/my_products_admin/presentation/widgets/edit_product_page.dart';
import 'package:haji_market/src/feature/shop/my_products_admin/presentation/widgets/show_alert_add_widget.dart';
import 'package:haji_market/src/feature/shop/my_products_admin/presentation/widgets/statistics_page.dart';

import '../../../../../core/common/constants.dart';
import '../../data/models/admin_products_model.dart';

Future<dynamic> showAlertStaticticsWidget(
    BuildContext context, AdminProductsModel product) async {
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
              MaterialPageRoute(
                  builder: (context) => StatisticsPage(product: product)),
            );
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Рекламировать товар',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
          onPressed: () {
            // Navigator.pop(context, 'Cancel');
            showCupertinoModalPopup<void>(
              context: context,
              builder: (context) => BlocProvider(
                create: (context) =>
                    AdsCubit(repository: ProductAdminRepository())
                      ..getAdsList(),
                child: ShowAdTypesAlert(product: product),
              ),
            );
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Удалить',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
          ),
          onPressed: () async {
            await BlocProvider.of<ProductAdminCubit>(context)
                .delete(product.id.toString());
            BlocProvider.of<ProductAdminCubit>(context).products('');
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
