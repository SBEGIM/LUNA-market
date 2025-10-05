import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/bloger/profile/presentation/widgets/show_module_profile_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showClientImageOptions(
    BuildContext context, bool isAuth, String title, Function callback) {
  bool? switchValue;
  String lang = GetStorage().read('language') ?? 'Русскийй';

  final _box = GetStorage();

  showMaterialModalBottomSheet(
    context: context,
    backgroundColor: AppColors.kGray1,
    // isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 218,
              maxHeight: (218).toDouble().clamp(218, 218),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Заголовок и крестик
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.size18Weight600,
                      ),
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Image.asset(
                          Assets.icons.defaultCloseIcon.path,
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        buildSettingItem(
                            onTap: () {
                              callback.call('image');
                            },
                            iconPath: Assets.icons.cameraIcon.path,
                            title: 'Выбрать фото',
                            widgetColor: Color(0xff3A3A3C)),
                        buildSettingItem(
                            onTap: () {
                              callback.call('close');
                            },
                            iconPath: Assets.icons.trashIcon.path,
                            title: 'Удалить фото',
                            widgetColor: AppColors.mainRedColor),
                      ],
                    )),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget buildSettingItem({
  required String title,
  String? iconPath,
  required VoidCallback onTap,
  bool? switchWidget,
  String? text,
  Color? widgetColor,
  ValueChanged<bool>? onSwitchChanged,
  bool? switchValue,
}) {
  return InkWell(
    onTap: onTap,
    child: SizedBox(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              iconPath!,
              height: 24,
              width: 24,
              scale: 1.9,
              color: widgetColor,
            ),
            SizedBox(width: 10),
            Text(
              title,
              style: AppTextStyles.size16Weight600.copyWith(
                color: widgetColor ?? AppColors.kGray900,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
