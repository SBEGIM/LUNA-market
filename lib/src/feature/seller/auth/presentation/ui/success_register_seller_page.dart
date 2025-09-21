import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';

import '../../../../../core/constant/generated/assets.gen.dart';

@RoutePage()
class SuccessSellerRegisterPage extends StatefulWidget {
  const SuccessSellerRegisterPage({Key? key}) : super(key: key);

  @override
  State<SuccessSellerRegisterPage> createState() =>
      _SuccessSellerRegisterPageState();
}

class _SuccessSellerRegisterPageState extends State<SuccessSellerRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.icons.successRegisterSeller.path),
            SizedBox(height: 16),
            Text(
              'Регистрация прошла успешно',
              style: AppTextStyles.size22Weight700,
            ),
            SizedBox(height: 16),
            Text(
              'Ваша заявка находится на модерации. Обычно это занимает от 1 до 2 рабочих дней',
              style: AppTextStyles.size16Weight400,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomSheet: InkWell(
        onTap: () {
          // context.router.push(AuthSellerRoute());

          BlocProvider.of<AppBloc>(context).add(
              const AppEvent.chageState(state: AppState.inAppAdminState()));
          context.router
              .popUntil((route) => route.settings.name == LauncherRoute.name);
        },
        child: Container(
          width: 358,
          height: 52,
          margin: EdgeInsets.only(bottom: 50),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.mainPurpleColor,
              borderRadius: BorderRadius.circular(16)),
          child: Text(
            'Перейти на главную',
            style: AppTextStyles.defaultButtonTextStyle
                .copyWith(color: AppColors.kWhite),
          ),
        ),
      ),
    );
  }
}
