import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/custom_back_button.dart';
import 'package:haji_market/src/feature/auth/data/bloc/sms_state.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import '../../data/bloc/sms_cubit.dart';

@RoutePage()
class ChangePasswordPage extends StatefulWidget {
  final String textEditingController;
  const ChangePasswordPage({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController passwordNew = TextEditingController();
  TextEditingController passwordRepeat = TextEditingController();

  bool _visibleIconView = false;
  bool _visibleIconViewRepeat = false;
  bool _passwordVisible = false;

  void test() {
    log("11 ${widget.textEditingController}");
  }

  @override
  void initState() {
    test();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Изменить пароль',
          style: AppTextStyles.appBarTextStyle,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            Navigator.pop(context);
          }),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 22.0),
        //     child: CustomDropButton(
        //       onTap: () {},
        //     ),
        //   ),
        // ],
      ),
      body: BlocConsumer<SmsCubit, SmsState>(listener: (context, state) {
        if (state is ResetSuccessState) {
          context.router.popUntil(
              (route) => route.settings.name == ForgotPasswordRoute.name);
          context.router.pop();
          // Get.offAll(() => const ViewAuthRegisterPage());
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Base()),
          // );
        }
      }, builder: (context, state) {
        if (state is InitState) {
          return Container(
            color: AppColors.kBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, top: 16, bottom: 45),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        ListTile(
                          horizontalTitleGap: 0,
                          leading: SvgPicture.asset(
                            'assets/icons/password.svg',
                            height: 24,
                            width: 24,
                          ),
                          title: TextField(
                            // inputFormatters: [maskFormatter],
                            controller: passwordNew,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Новый пароль',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                // borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            onChanged: (value) {
                              passwordNew.text.length.toInt() == 0
                                  ? _visibleIconView = false
                                  : _visibleIconView = true;
                              setState(() {});
                            },
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            child: _visibleIconView == true
                                ? Icon(
                                    _passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color:
                                        const Color.fromRGBO(177, 179, 181, 1),
                                  )
                                : const SizedBox(width: 5),
                          ),
                        ),
                        ListTile(
                          horizontalTitleGap: 0,
                          leading: SvgPicture.asset(
                            'assets/icons/password.svg',
                            height: 24,
                            width: 24,
                          ),
                          title: TextField(
                            // inputFormatters: [maskFormatter],
                            controller: passwordRepeat,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Подтвердите пароль',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                // borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            onChanged: (value) {
                              passwordRepeat.text.length.toInt() == 0
                                  ? _visibleIconViewRepeat = false
                                  : _visibleIconViewRepeat = true;
                              setState(() {});
                            },
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            child: _visibleIconViewRepeat == true
                                ? Icon(
                                    _passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color:
                                        const Color.fromRGBO(177, 179, 181, 1),
                                  )
                                : const SizedBox(width: 5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Center(
                    child: SizedBox(
                      width: 300,
                      child: Text(
                        textAlign: TextAlign.center,
                        'Для смены пароля введите новый пароль, а затем подтвердите',
                        style: TextStyle(
                            color: AppColors.kGray900,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom * 0.001,
                    ),
                    child: DefaultButton(
                        backgroundColor: AppColors.kPrimaryColor,
                        text: 'Изменить пароль',
                        press: () {
                          log(widget.textEditingController);
                          log('1111');
                          final sms = BlocProvider.of<SmsCubit>(context);
                          sms.passwordReset(widget.textEditingController,
                              passwordRepeat.text);
                        },
                        color: Colors.white,
                        width: 343),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is ErrorState) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.redAccent),
            ),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(color: Colors.indigoAccent));
        }
      }),
    );
  }
}
