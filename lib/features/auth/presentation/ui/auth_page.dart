import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/presentaion/base.dart';
import 'package:haji_market/features/auth/presentation/ui/forgot_password.dart';
import 'package:haji_market/features/auth/presentation/widgets/default_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/features/home/presentation/ui/home_page.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../data/bloc/login_cubit.dart';
import '../../data/bloc/login_state.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isButtonEnabled = false;
  bool _passwordVisible = false;
  bool _visibleIconClear = false;
  bool __visibleIconView = false;

  setIsButtonEnabled(bool value) {
    // log("is button state changed $value");
    isButtonEnabled = value;
    setState(() {});
  }

  TextEditingController phoneControllerAuth =
      MaskedTextController(mask: '+7(000)-000-00-00');
  TextEditingController passwordControllerAuth = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
      if (state is LoadedState) {
        Get.to(() => const Base(index: 0));
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const Base()),
        // );
      }
    }, builder: (context, state) {
      if (state is InitState) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 45),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        ListTile(
                          horizontalTitleGap: 5,
                          leading: SvgPicture.asset(
                            'assets/icons/phone.svg',
                            height: 24,
                            width: 24,
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              _visibleIconClear = false;
                              phoneControllerAuth.clear();
                              setState(() {
                                _visibleIconClear;
                              });
                            },
                            child: _visibleIconClear == true
                                ? SvgPicture.asset(
                                    'assets/icons/delete_circle.svg',
                                  )
                                : const SizedBox(
                                    width: 5,
                                  ),
                          ),
                          title: TextField(
                            keyboardType: TextInputType.phone,
                            // inputFormatters: [maskFormatter],
                            controller: phoneControllerAuth,
                            onChanged: (value) {
                              _visibleIconClear = true;
                              if (phoneControllerAuth.text.length == 17) {
                                setIsButtonEnabled(true);
                              } else {
                                setIsButtonEnabled(false);
                              }
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Номер телефона',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                // borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          horizontalTitleGap: 5,
                          leading: SvgPicture.asset(
                            'assets/icons/password.svg',
                            height: 24,
                            width: 24,
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            child: __visibleIconView == true
                                ? Icon(
                                    _passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color:
                                        const Color.fromRGBO(177, 179, 181, 1),
                                  )
                                : const SizedBox(width: 5),
                          ),
                          title: TextField(
                            keyboardType: TextInputType.text,
                            // inputFormatters: [maskFormatter],
                            controller: passwordControllerAuth,
                            obscureText: !_passwordVisible,
                            onChanged: (value) {
                              passwordControllerAuth.text.length == 0
                                  ? __visibleIconView = false
                                  : __visibleIconView = true;
                              if (passwordControllerAuth.text.isNotEmpty) {
                                setIsButtonEnabled(true);
                              } else {
                                setIsButtonEnabled(false);
                              }
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Введите пароль',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                // borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      // if (phoneControllerAuth.text.length == 17){
                      //   showModalBottomSheet(
                      //       shape: const RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),
                      //             topRight: Radius.circular(10.0)),
                      //       ),
                      //       context: context,
                      //       builder: (context) {
                      //         return ForgotPasswordModalBottom(
                      //           textEditingController: phoneControllerRegister.text,
                      //           register: register,
                      //         );
                      //       });
                      // }else{
                      //   Get.snackbar('Заполните', 'Напишите полный номер' , backgroundColor: Colors.blueAccent);
                      // }
                      Get.to(const ForgotPasswordPage());
                    },
                    child: const Center(
                      child: Text(
                        'Забыли пароль?',
                        style: TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: DefaultButton(
                    backgroundColor: isButtonEnabled
                        ? AppColors.kPrimaryColor
                        : const Color(0xFFD6D8DB),
                    text: 'Войти',
                    press: () {
                      if (phoneControllerAuth.text.length >= 17 ||
                          passwordControllerAuth.text.isEmpty) {
                        final login = BlocProvider.of<LoginCubit>(context);
                        login.login(phoneControllerAuth.text,
                            passwordControllerAuth.text);
                      } else {
                        Get.snackbar('Ошибка запроса', 'Заполните все данныые',
                            backgroundColor: Colors.blueAccent);
                      }
                    },
                    color: Colors.white,
                    width: 343),
              ),
              GestureDetector(
                  onTap: () {
                    final login = BlocProvider.of<LoginCubit>(context);
                    login.lateAuth();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 12),
                    child: const Text(
                      'Авторизоваться позже',
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.kPrimaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ))
            ],
          ),
        );
      }
      if (state is ErrorState) {
        return Center(
          child: Text(
            state.message,
            style: TextStyle(color: Colors.redAccent),
          ),
        );
      } else {
        return const Center(
            child: CircularProgressIndicator(color: Colors.indigoAccent));
      }
    });
  }
}
