import 'dart:async';
import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../data/bloc/sms_cubit.dart';
import '../../data/bloc/sms_state.dart';

class LoginForgotPasswordModalBottom extends StatefulWidget {
  final String textEditingController;
  const LoginForgotPasswordModalBottom({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  @override
  State<LoginForgotPasswordModalBottom> createState() =>
      _LoginForgotPasswordModalBottom();
}

class _LoginForgotPasswordModalBottom
    extends State<LoginForgotPasswordModalBottom> {
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
    return BlocConsumer<SmsCubit, SmsState>(listener: (context, state) {
      if (state is ErrorState) {}
      if (state is LoadedState) {
        log(widget.textEditingController);
        // Get.to( () => ChangePasswordPage( textEditingController: widget.textEditingController));
        FocusScope.of(context).requestFocus(FocusNode());
        context.router.push(ChangePasswordRoute(
            textEditingController: widget.textEditingController));
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) =>  ChangePasswordPage(textEditingController: widget.textEditingController)),
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Введите код подтверждения,\nкоторый был отправлен по номеру\n${widget.textEditingController}',
                  style: AppTextStyles.appBarTextStyle,
                ),
                SvgPicture.asset(
                  'assets/icons/delete_circle.svg',
                  height: 24,
                  width: 24,
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: PinCodeTextField(
                length: 4,
                obscureText: false,
                keyboardType: TextInputType.phone,
                appContext: context,
                pinTheme: PinTheme(
                  activeColor: Colors.grey,
                  shape: PinCodeFieldShape.box,
                  inactiveColor: Colors.grey,
                  activeFillColor: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  selectedColor: Colors.green,
                  fieldHeight: 48,
                  fieldWidth: 48,
                ),
                onChanged: (value) {
                  // log(value);
                },
                onCompleted: (value) async {
                  if (value.length == 4) {
                    final sms = BlocProvider.of<SmsCubit>(context);
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
            Text(
              'Вы можете заново отправить код через $_start',
              style: AppTextStyles.timerInReRegTextStyle,
            ),
            const Spacer(),
            DefaultButton(
                backgroundColor: (_start == 60)
                    ? AppColors.kPrimaryColor
                    : const Color(0xFFD6D8DB),
                text: 'Переотправить код',
                press: () {
                  if (_start == 60) {
                    final sms = BlocProvider.of<SmsCubit>(context);
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
