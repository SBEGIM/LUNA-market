import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import '../../../core/constant/generated/assets.gen.dart';

class GuestUserPage extends StatefulWidget {
  const GuestUserPage({super.key});

  @override
  State<GuestUserPage> createState() => _GuestUserPageState();
}

class _GuestUserPageState extends State<GuestUserPage> {
  final List<Map<String, dynamic>> countries = [
    {'icon': Assets.icons.ruFlagIcon.path, 'name': 'Россия'},
    {'icon': Assets.icons.belFlagIcon.path, 'name': 'Беларусь'},
    {'icon': Assets.icons.kzFlagIcon.path, 'name': 'Казахстан'},
    {'icon': Assets.icons.krFlagIcon.path, 'name': 'Киргизия'},
    {'icon': Assets.icons.arFlagIcon.path, 'name': 'Армения'},
    {'icon': Assets.icons.uzFlagIcon.path, 'name': 'Узбекстан'},
  ];

  int _select = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 149,
            ),
            Image.asset(
              Assets.images.guestsUser.path,
              height: 390,
            ),
            SizedBox(
              height: 23,
            ),
            Text(
              'Войдите или\nзарегистрируйтесь',
              style: AppTextStyles.defButtonTextStyle.copyWith(
                  color: AppColors.kLightBlackColor,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0,
                  height: 1.2,
                  fontSize: 32),
            ),
            const SizedBox(height: 8),
            Text(
              'Чтобы открыть весь функционал',
              style: AppTextStyles.catalogTextStyle.copyWith(
                  color: AppColors.kLightBlackColor.withOpacity(0.4),
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 32),
            DefaultButton(
                text: 'Продолжить',
                press: () {
                  Get.back();
                  // BlocProvider.of<AppBloc>(context)
                  //     .add(const AppEvent.checkAuth());
                },
                color: AppColors.kWhite,
                backgroundColor: AppColors.mainPurpleColor,
                textStyle: AppTextStyles.aboutTextStyle.copyWith(
                    color: AppColors.kWhite,
                    fontSize: 18,
                    height: 24 / 18,
                    fontWeight: FontWeight.w600),
                width: double.infinity),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Не сейчас',
                style: AppTextStyles.aboutTextStyle.copyWith(
                    color: AppColors.mainPurpleColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
