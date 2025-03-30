import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/feature/seller/product/bloc/ad_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/product/bloc/product_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/product/data/repository/product_seller_repository.dart';
import 'package:haji_market/src/feature/seller/product/presentation/ui/edit_product_seller_page.dart';
import 'package:haji_market/src/feature/seller/product/presentation/widgets/show_alert_add_seller_widget.dart';
import 'package:haji_market/src/feature/seller/product/presentation/widgets/statistics_seller_page.dart';

import '../../../../../core/common/constants.dart';
import '../../data/models/product_seller_model.dart';

Future<dynamic> showAlertStaticticsSellerWidget(
    BuildContext context, ProductSellerModel product) async {
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
                  builder: (context) => EditProductSellerPage(
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
                  builder: (context) => StatisticsSellerPage(product: product)),
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
                    AdSellerCubit(repository: ProductSellerRepository())
                      ..getAdsList(),
                child: ShowAdTypesAlertSellerWidget(product: product),
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
            await BlocProvider.of<ProductSellerCubit>(context)
                .delete(product.id.toString());
            BlocProvider.of<ProductSellerCubit>(context).products('');
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
