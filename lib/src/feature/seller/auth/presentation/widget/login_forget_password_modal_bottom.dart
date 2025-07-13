import 'dart:async';
import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/src/feature/seller/auth/bloc/sms_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/auth/bloc/sms_seller_state.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginForgotSellerPasswordModalBottom extends StatefulWidget {
  final String textEditingController;
  const LoginForgotSellerPasswordModalBottom({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  @override
  State<LoginForgotSellerPasswordModalBottom> createState() =>
      _LoginForgotSellerPasswordModalBottom();
}

class _LoginForgotSellerPasswordModalBottom
    extends State<LoginForgotSellerPasswordModalBottom> {
  late Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        }
        if (_start == 0) {
          setState(() {
            _start = 60;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    _start = 59;
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SmsSellerCubit, SmsSellerState>(
        listener: (context, state) {
      if (state is ErrorState) {}
      if (state is LoadedState) {
        log(widget.textEditingController);
        // Get.to( () => ChangePasswordPage( textEditingController: widget.textEditingController));
        FocusScope.of(context).requestFocus(FocusNode());
        context.router.push(ChangePasswordSellerRoute(
            textEditingController: widget.textEditingController));
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => ChangePasswordAdminPage(
        //           textEditingController: widget.textEditingController)),
        // );
      }
    }, builder: (context, state) {
      if (state is LoadingState) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.indigoAccent),
        );
      }
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                'Восстановление доступа',
                style: AppTextStyles.defaultAppBarTextStyle,
              ),
              SvgPicture.asset(
                'assets/icons/delete_circle.svg',
                height: 24,
                width: 24,
              ),
            ]),
            const SizedBox(
              height: 16,
            ),
            Flexible(
              child: Text(
                'Введите код из SMS, отправленный на номер ${widget.textEditingController}',
                style: AppTextStyles.catalogTextStyle,
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            Center(
              child: SizedBox(
                width: 324,
                child: PinCodeTextField(
                  length: 4,
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                  appContext: context,
                  pinTheme: PinTheme(
                    activeColor: AppColors.kGray1000,
                    shape: PinCodeFieldShape.box,
                    inactiveColor: Colors.grey,
                    activeFillColor: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                    selectedColor: AppColors.mainPurpleColor,
                    fieldHeight: 64,
                    fieldWidth: 64,
                  ),
                  onChanged: (value) {
                    // log(value);
                  },
                  onCompleted: (value) async {
                    if (value.length == 4) {
                      final sms = BlocProvider.of<SmsSellerCubit>(context);
                      sms.resetCheck(
                          widget.textEditingController, value.toString());
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const ChangePasswordPage()),
                      // );
                      // final String phoneRep = widget.phoneNumber
                      //     .replaceAll(RegExp(r"[^0-9]+"), '');
                      //  BlocProvider.of<RegisterCheckSmsCubit>(
                      //   context,
                      // ).send(value, phoneRep);
                    }
                  },
                ),
              ),
            ),
            Center(
              child: Text(
                'Отправить повторно через $_start c',
                style: AppTextStyles.timerInReRegTextStyle
                    .copyWith(color: AppColors.mainPurpleColor),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            DefaultButton(
                backgroundColor: (_start == 60)
                    ? AppColors.mainPurpleColor
                    : const Color(0xFFD6D8DB),
                text: 'Переотправить код',
                press: () {
                  if (_start == 60) {
                    final sms = BlocProvider.of<SmsSellerCubit>(context);
                    sms.smsResend(widget.textEditingController);
                    startTimer();
                    _start = 59;
                  }
                },
                color: AppColors.floatingActionButton,
                width: MediaQuery.of(context).size.width),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      );
    });
  }
}
