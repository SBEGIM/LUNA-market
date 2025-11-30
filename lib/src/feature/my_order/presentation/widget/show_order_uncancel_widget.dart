import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showOrderUncancel(
  BuildContext context,
  String title,
  List<String> options,
  Function(String) callback,
) {
  int selectedIndex = -1;

  showMaterialModalBottomSheet(
    context: context,
    expand: false,
    backgroundColor: AppColors.kBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          return SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.appBarTextStyle,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.of(ctx).pop(),
                        child: Image.asset(Assets.icons.defaultCloseIcon.path, scale: 1.9),
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 216,
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 56,
                        width: 56,
                        child: Image.asset(Assets.icons.rejectCancelOrder.path),
                      ),
                      SizedBox(height: 10),
                      Text('Этот заказ нельзя отменить', style: AppTextStyles.size18Weight700),
                      SizedBox(height: 2),

                      Flexible(
                        child: Text(
                          'Он уже в пути или передаётся в доставку. Вы можете не забирать покупки из пункта выдачи или у курьера. Обычно после отмены деньги зачисляются в течение 3 дней',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.size16Weight400.copyWith(color: Color(0xff636366)),
                        ),
                      ),
                    ],
                  ),
                ),

                // Кнопка как в CancelOrderWidget (Отменить заказ)
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 24),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: selectedIndex == -1
                          ? null
                          : () {
                              callback.call(options[selectedIndex]);
                              Navigator.pop(ctx);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainPurpleColor,
                        disabledBackgroundColor: AppColors.mainPurpleColor.withOpacity(0.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Понятно',
                        style: AppTextStyles.size18Weight600.copyWith(color: AppColors.kWhite),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
