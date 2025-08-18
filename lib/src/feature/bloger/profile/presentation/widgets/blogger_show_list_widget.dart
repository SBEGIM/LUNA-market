import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:haji_market/src/feature/bloger/profile/presentation/ui/blogger_profile_page.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:haji_market/src/feature/home/data/model/characteristic_model.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showBloggerSettingOptions(
    BuildContext context, String title, Function callback) {
  bool? switchValue;

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
              minHeight: 400,
              maxHeight: (300 + 100).toDouble().clamp(250, 500),
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
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
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
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        buildSettingItem(
                          onTap: () {},
                          switchWidget: true,
                          switchValue: switchValue,
                          onSwitchChanged: (value) {
                            switchValue = value;
                            setState(() {});
                          },
                          title: 'Уведомления',
                        ),
                        SizedBox(height: 17),
                        buildSettingItem(
                          onTap: () {},
                          title: 'Язык',
                          text: 'Рус',
                        ),
                        SizedBox(height: 17),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        SizedBox(height: 17),
                        buildSettingItem(
                          onTap: () {
                            GetStorage().remove('blogger_token');
                            BlocProvider.of<AppBloc>(context).add(
                                const AppEvent.chageState(
                                    state: AppState.inAppUserState(index: 1)));
                          },
                          title: 'Выйти из аккаунта',
                          iconPath: Assets.icons.exitIcon.path,
                        ),
                        SizedBox(height: 17),
                        buildSettingItem(
                          onTap: () {},
                          widgetColor: Colors.red,
                          title: 'Удалить аккаунт',
                        ),
                        SizedBox(height: 17),
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
    child: Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 15, left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: widgetColor ?? AppColors.kGray900,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          switchWidget == true
              ? Transform.scale(
                  scale: 0.9,
                  child: Switch(
                    value: switchValue ?? false,
                    onChanged: onSwitchChanged,
                    inactiveThumbColor: Colors.white,
                    activeTrackColor: AppColors.mainPurpleColor,
                    trackOutlineWidth: MaterialStateProperty.all(0.01),
                  ),
                )
              : (text == null
                  ? (iconPath != null
                      ? Image.asset(
                          iconPath,
                          height: 19,
                          width: 19,
                        )
                      : Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: widgetColor ?? AppColors.kGray300,
                        ))
                  : Row(
                      children: [
                        Text(
                          '$text',
                          style: AppTextStyles.size16Weight400.copyWith(
                              color: widgetColor ?? AppColors.kGray300),
                        ),
                        SizedBox(width: 6),
                        (iconPath != null
                            ? Image.asset(
                                iconPath,
                                height: 19,
                                width: 19,
                              )
                            : Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: widgetColor ?? AppColors.kGray300,
                              ))
                      ],
                    ))
        ],
      ),
    ),
  );
}
