import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';

@RoutePage()
class SuccessBloggerRegisterPage extends StatefulWidget {
  const SuccessBloggerRegisterPage({super.key});

  @override
  State<SuccessBloggerRegisterPage> createState() =>
      _SuccessBloggerRegisterPageState();
}

class _SuccessBloggerRegisterPageState
    extends State<SuccessBloggerRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Assets.icons.awaitModerationIcon.path,
            height: 90,
            width: 90,
          ),
          SizedBox(height: 16),
          Text(
            'Регистрация прошла успешно',
            style: AppTextStyles.size22Weight700
                .copyWith(color: Color(0xff0B0B0B)),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            'Ваша заявка находится на модерации. Обычно это занимает от 1 до 2 рабочих дней',
            style: AppTextStyles.size16Weight400
                .copyWith(color: Color(0xff0B0B0B)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: InkWell(
            onTap: () {
              final router =
                  AutoRouter.of(context).root; // гарантированно корень

              // router.replaceAll([const LauncherRoute()]);

              context.read<AppBloc>().add(
                    const AppEvent.chageState(
                        state: AppState.inAppBlogerState(index: 1)),
                  );

              router.replaceAll([const LauncherRoute()]);
            },
            child: SizedBox(
                height: 100,
                child: Column(
                  children: [
                    Container(
                        height: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.mainPurpleColor,
                        ),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: Text(
                          'Перейти на главную',
                          style: AppTextStyles.defaultButtonTextStyle
                              .copyWith(color: AppColors.kWhite),
                          textAlign: TextAlign.center,
                        )),
                    SizedBox(height: 12)
                  ],
                ))),
      ),
    );
  }
}
