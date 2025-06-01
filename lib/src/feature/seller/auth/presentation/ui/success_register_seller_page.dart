import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';

import '../../../../../core/constant/generated/assets.gen.dart';

@RoutePage()
class SuccessSellerRegisterPage extends StatefulWidget {
  final bool? BackButton;
  const SuccessSellerRegisterPage({this.BackButton, Key? key})
      : super(key: key);

  @override
  State<SuccessSellerRegisterPage> createState() =>
      _SuccessSellerRegisterPageState();
}

class _SuccessSellerRegisterPageState extends State<SuccessSellerRegisterPage> {
  int segmentValue = 0;

  final List<bool> selectedBotton = [true, false];
  int currentIndex = 0;
  String title = 'Войти в кабинет продавца';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            size: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.icons.successRegisterSeller.path),
            Text(
              'Регистрация прошла успешно',
              style: AppTextStyles.defaultButtonTextStyle,
            ),
            Text(
              'Ваша заявка находится на модерации. Обычно это занимает от 1 до 2 рабочих дней',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomSheet: InkWell(
        onTap: () {
          context.router.push(AuthSellerRoute());
        },
        child: Container(
          width: 358,
          height: 52,
          margin: EdgeInsets.only(bottom: 25),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors.mainPurpleColor,
              borderRadius: BorderRadius.circular(12)),
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
