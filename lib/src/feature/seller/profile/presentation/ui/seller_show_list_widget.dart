import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:haji_market/src/feature/bloger/profile/presentation/widgets/show_module_profile_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/show_alert_account_widget.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void showSellerSettingOptions(BuildContext context, String title, Function callback) {
  bool? switchValue;
  String lang = GetStorage().read('language') ?? 'Русскийй';

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
              minHeight: 333,
              maxHeight: (333).toDouble().clamp(333, 333),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Заголовок и крестик
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: AppTextStyles.size18Weight600),
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
                    borderRadius: BorderRadius.circular(16),
                  ),
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
                      buildSettingItem(
                        onTap: () {
                          final List<String> options = ['Русский', 'Казахский', 'Английский'];
                          showModuleProfile(context, 'Язык', lang, options, (value) {
                            GetStorage().write('language', value);

                            lang = value;

                            setState(() {});
                          });
                        },
                        title: 'Язык',
                        text: lang,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12, left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      buildSettingItem(
                        onTap: () async {
                          final ok = await showAccountAlert(
                            context,
                            title: 'Выход из аккаунта',
                            message: 'Вы уверены, что хотите выйти из аккаунта?',
                            mode: AccountAlertMode.confirm,
                            cancelText: 'Отмена',
                            primaryText: 'Да',
                            primaryColor: Colors.red,
                          );

                          if (!context.mounted) return;

                          if (ok == true) {
                            Navigator.of(context).pop();
                            GetStorage().remove('seller_token');
                            GetStorage().remove('seller_id');
                            GetStorage().remove('seller_name');
                            GetStorage().remove('seller_image');

                            BlocProvider.of<AppBloc>(context).add(
                              const AppEvent.chageState(state: AppState.inAppUserState(index: 1)),
                            );
                          }
                        },
                        title: 'Выйти из аккаунта',
                        iconPath: Assets.icons.exitIcon.path,
                      ),
                      buildSettingItem(
                        onTap: () async {
                          final ok = await showAccountAlert(
                            context,
                            title: 'Удаление аккаунта',
                            message: 'Вы уверены, что хотите удалить аккаунт?',
                            mode: AccountAlertMode.confirm,
                            cancelText: 'Отмена',
                            primaryText: 'Да',
                            primaryColor: Colors.red,
                          );

                          if (!context.mounted) return;

                          if (ok == true) {
                            Navigator.of(context).pop();
                            GetStorage().remove('seller_token');
                            GetStorage().remove('seller_id');
                            GetStorage().remove('seller_name');
                            GetStorage().remove('seller_image');

                            BlocProvider.of<AppBloc>(context).add(
                              const AppEvent.chageState(state: AppState.inAppUserState(index: 1)),
                            );
                          }
                        },
                        widgetColor: Colors.red,
                        title: 'Удалить аккаунт',
                      ),
                    ],
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppTextStyles.size16Weight600.copyWith(
                color: widgetColor ?? AppColors.kGray900,
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
                      trackOutlineWidth: WidgetStateProperty.all(0.01),
                    ),
                  )
                : (text == null
                      ? (iconPath != null
                            ? Image.asset(iconPath, height: 19, width: 19)
                            : Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: widgetColor ?? AppColors.kGray300,
                              ))
                      : Row(
                          children: [
                            Text(
                              text,
                              style: AppTextStyles.size16Weight400.copyWith(
                                color: widgetColor ?? AppColors.kGray300,
                              ),
                            ),
                            SizedBox(width: 6),
                            (iconPath != null
                                ? Image.asset(iconPath, height: 19, width: 19)
                                : Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: widgetColor ?? AppColors.kGray300,
                                  )),
                          ],
                        )),
          ],
        ),
      ),
    ),
  );
}
