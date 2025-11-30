import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/src/feature/app/widgets/custom_back_button.dart';
import 'package:haji_market/src/feature/bloger/auth/bloc/sms_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/auth/bloc/sms_blogger_state.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'change_blogger_password.dart';

@RoutePage()
class LoginForgotBloggerPasswordPage extends StatefulWidget {
  final String countryCode;

  final String textEditingController;

  const LoginForgotBloggerPasswordPage({
    Key? key,
    required this.textEditingController,
    required this.countryCode,
  }) : super(key: key);

  @override
  State<LoginForgotBloggerPasswordPage> createState() => _LoginForgotBloggerPasswordModalBottom();
}

class _LoginForgotBloggerPasswordModalBottom extends State<LoginForgotBloggerPasswordPage> {
  late Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
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
    });
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
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: CustomBackButton(
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocConsumer<SmsBloggerCubit, SmsBloggerState>(
        listener: (context, state) {
          if (state is ErrorState) {}
          if (state is LoadedState) {
            FocusScope.of(context).requestFocus(FocusNode());
            context.router.push(
              ChangePasswordBloggerRoute(textEditingController: widget.textEditingController),
            );
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Восстановление доступа', style: AppTextStyles.size28Weight700),
                const SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Введите код из SMS, отправленный на номер',
                      style: AppTextStyles.size16Weight400.copyWith(color: Color(0xFF636366)),
                    ),
                    Text(
                      '${widget.countryCode} ${widget.textEditingController}',
                      style: AppTextStyles.size18Weight500,
                    ),
                  ],
                ),
                const SizedBox(height: 36),
                Center(
                  child: SizedBox(
                    width: 324,
                    child: PinCodeTextField(
                      appContext: context,
                      length: 4,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.none,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      cursorColor: Colors.black,
                      cursorWidth: 2,
                      cursorHeight: 24,
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      enableActiveFill: true, // включаем заливку
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        fieldHeight: 64,
                        fieldWidth: 64,
                        borderRadius: BorderRadius.circular(20), // побольше скругление
                        borderWidth: 2,

                        // Рамки
                        selectedColor: AppColors.mainPurpleColor, // фокус (фиолетовая)
                        inactiveColor: const Color(0xFFB6BBC1), // пустая (серая)
                        activeColor: Colors.transparent, // введённые без рамки
                        // Заливки
                        selectedFillColor: const Color(0xFFEAECED), // фокус (светло-серая)
                        inactiveFillColor: Colors.white, // пустая (белая)
                        activeFillColor: const Color(0xFFEAECED), // введённые (светло-серая)
                      ),
                      onChanged: (_) {},
                      onCompleted: (value) async {
                        if (value.length == 4) {
                          final sms = BlocProvider.of<SmsBloggerCubit>(context);
                          sms.resetCheck(widget.textEditingController, value.toString());
                        }
                      },
                    ),
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
                      final sms = BlocProvider.of<SmsBloggerCubit>(context);
                      sms.smsResend(widget.textEditingController);
                      startTimer();
                      _start = 59;
                    }
                  },
                  color: AppColors.floatingActionButton,
                  width: MediaQuery.of(context).size.width,
                ),
                const SizedBox(height: 16),
                if (_start != 60)
                  Center(
                    child: Text(
                      'Отправить повторно через $_start c',
                      style: AppTextStyles.timerInReRegTextStyle.copyWith(
                        color: AppColors.mainPurpleColor.withOpacity(0.5),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 50),
              ],
            ),
          );
        },
      ),
    );
  }
}
