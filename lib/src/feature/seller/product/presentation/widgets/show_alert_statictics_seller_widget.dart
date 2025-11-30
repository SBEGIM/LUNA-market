import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/show_alert_account_widget.dart';
import 'package:haji_market/src/feature/seller/product/bloc/product_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/product/data/models/product_seller_model.dart';
import 'package:haji_market/src/feature/seller/product/presentation/widgets/show_alert_add_seller_widget.dart';
import 'package:haji_market/src/feature/seller/product/presentation/widgets/statistics_seller_page.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showProductOptions(
  BuildContext parentCtx, // <-- контекст экрана, откуда открыли модалку
  ProductSellerModel product,
  ProductSellerCubit cubit,
) {
  showMaterialModalBottomSheet(
    context: parentCtx,
    backgroundColor: AppColors.kBackgroundColor,
    useRootNavigator: true, // <-- чтобы модалка в корневом навигаторе
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    builder: (sheetCtx) {
      // <-- контекст МОДАЛКИ
      return BlocProvider.value(
        value: cubit,
        child: SingleChildScrollView(
          controller: ModalScrollController.of(sheetCtx),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Управление товаром', style: AppTextStyles.defaultButtonTextStyle),
                    InkWell(
                      onTap: () => Navigator.of(sheetCtx).pop(), // закрываем модалку её контекстом
                      child: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
              ),
              _buildOptionTile(
                context: sheetCtx,
                icon: Assets.icons.editIcon.path,
                color: null,
                title: 'Редактировать',
                onTap: () {
                  Navigator.of(sheetCtx).pop(); // закрыть модалку
                  parentCtx.router.push(
                    EditProductSellerRoute(product: product),
                  ); // пушим из РОДИТЕЛЯ
                },
              ),
              _buildOptionTile(
                context: sheetCtx,
                icon: Assets.icons.addRollsIcon.path,
                color: null,
                title: 'Добавить видеообзор  “Roolls”',
                onTap: () {
                  Navigator.of(sheetCtx).pop();
                },
              ),
              _buildOptionTile(
                context: sheetCtx,
                icon: Assets.icons.promotionIcon.path,
                color: null,
                title: 'Акция на товар',
                onTap: () {
                  Navigator.of(sheetCtx).pop();

                  parentCtx.router.push(ProductPromotionRoute());
                },
              ),
              _buildOptionTile(
                context: sheetCtx,
                icon: Assets.icons.statisticsIcon.path,
                color: null,
                title: 'Статистика',
                onTap: () {
                  Navigator.pop(sheetCtx, 'stats');
                  Navigator.push(
                    parentCtx,
                    MaterialPageRoute(builder: (context) => StatisticsSellerPage(product: product)),
                  );
                },
              ),
              _buildOptionTile(
                context: sheetCtx,
                icon: Assets.icons.addAdIcon.path,
                color: null,
                title: 'Рекламировать товар',
                onTap: () {
                  Navigator.of(sheetCtx).pop();
                  showAdsOptions(parentCtx, product); // вызываем с родительским контекстом
                },
              ),
              _buildOptionTile(
                context: sheetCtx,
                icon: Assets.icons.trashIcon.path,
                color: Colors.red,
                title: 'Удалить',
                onTap: () async {
                  Navigator.of(sheetCtx).pop();

                  final ok = await showAccountAlert(
                    parentCtx,
                    title: 'Удаление товара',
                    message: 'Вы уверены, что хотите удалить этот товар?',
                    mode: AccountAlertMode.confirm,
                    cancelText: 'Нет',
                    primaryText: 'Да',
                    primaryColor: Colors.red,
                  );

                  if (ok == true) {
                    final rootCtx = parentCtx.router.root.navigatorKey.currentContext;

                    if (rootCtx != null) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        AppSnackBar.show(
                          rootCtx,
                          'Товар успешно удален',
                          type: AppSnackType.success,
                        );
                      });
                    }
                    await cubit.delete(product.id.toString());
                    cubit
                      ..resetState()
                      ..products('');

                    // if (parentCtx.mounted) {
                    //   parentCtx.router.pop();
                    // }
                  }
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildOptionTile({
  required BuildContext context,
  required String icon,
  required Color? color,
  required String title,
  required VoidCallback onTap,
}) {
  return Container(
    height: 52,
    margin: EdgeInsets.only(left: 16, top: 8, right: 16),
    alignment: Alignment.center,
    decoration: BoxDecoration(color: AppColors.kWhite, borderRadius: BorderRadius.circular(12)),
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12), // Минимальные отступы
      leading: Image.asset(icon, scale: 1.9),
      title: Text(title, style: AppTextStyles.size16Weight500.copyWith(color: color)),
      onTap: onTap,
      tileColor: Colors.transparent, // Убираем фон у Tile, если он есть
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Скругляем угол
      ),
    ),
  );
}
