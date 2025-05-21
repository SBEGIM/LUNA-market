import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/seller/product/bloc/product_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/product/data/models/product_seller_model.dart';
import 'package:haji_market/src/feature/seller/product/presentation/widgets/show_alert_add_seller_widget.dart';
import 'package:haji_market/src/feature/seller/product/presentation/widgets/statistics_seller_page.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showProductOptions(BuildContext context, ProductSellerModel product,
    ProductSellerCubit cubit) {
  showMaterialModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), // Округляем верхний левый угол
          topRight: Radius.circular(20), // Округляем верхний правый угол
        ),
      ),
      builder: (context) {
        return BlocProvider.value(
            value: cubit, // Убедитесь, что создается ProductSellerCubit
            child: SingleChildScrollView(
              controller: ModalScrollController.of(context),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Управление товаром',
                          style: AppTextStyles.defaultButtonTextStyle,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.close_rounded))
                      ],
                    ),
                  ),
                  _buildOptionTile(
                    context: context,
                    icon: Icons.edit,
                    color: AppColors.mainPurpleColor,
                    title: 'Редактировать',
                    onTap: () {
                      Navigator.pop(context, 'edit');
                      context
                          .pushRoute(EditProductSellerRoute(product: product));
                    },
                  ),
                  _buildOptionTile(
                    context: context,
                    icon: Icons.area_chart,
                    color: AppColors.mainPurpleColor,
                    title: 'Статистика',
                    onTap: () {
                      Navigator.pop(context, 'stats');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              StatisticsSellerPage(product: product),
                        ),
                      );
                    },
                  ),
                  _buildOptionTile(
                    context: context,
                    icon: Icons.ads_click,
                    color: AppColors.mainPurpleColor,
                    title: 'Рекламировать товар',
                    onTap: () {
                      Navigator.pop(context, 'ads');
                      showAdsOptions(context, product);
                    },
                  ),
                  _buildOptionTile(
                    context: context,
                    icon: Icons.delete_forever_outlined,
                    color: Colors.red,
                    title: 'Удалить',
                    onTap: () async {
                      await cubit.delete(product.id.toString());
                      cubit
                        ..resetState()
                        ..products('');

                      // AutoRouter.of(context).back();
                      AutoRouter.of(context)
                          .replace(const MyProductsAdminRoute());

                      context.router.popTop();
                    },
                  ),
                  SizedBox(height: 30)
                ],
              ),
            ));
      });
}

Widget _buildOptionTile({
  required BuildContext context,
  required IconData icon,
  required Color color,
  required String title,
  required VoidCallback onTap,
}) {
  return Container(
    height: 52,
    margin: EdgeInsets.only(left: 16, top: 8, right: 16),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: AppColors.kWhite, borderRadius: BorderRadius.circular(12)),
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(
          vertical: 0, horizontal: 12), // Минимальные отступы
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: Colors.black)),
      onTap: onTap,
      tileColor: Colors.transparent, // Убираем фон у Tile, если он есть
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Скругляем угол
      ),
    ),
  );
}
