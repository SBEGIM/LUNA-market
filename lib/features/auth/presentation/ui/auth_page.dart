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

  setIsButtonEnabled(bool value) {
    // log("is button state changed $value");
    isButtonEnabled = value;
    setState(() {});
  }

  TextEditingController phoneControllerAuth = MaskedTextController(mask: '+7(000)-000-00-00');
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
                          leading: SvgPicture.asset(
                            'assets/icons/phone.svg',
                            height: 24,
                            width: 24,
                          ),
                          title: TextField(
                            keyboardType: TextInputType.phone,
                            // inputFormatters: [maskFormatter],
                            controller: phoneControllerAuth,
                            onChanged: (value) {
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
                          trailing: SvgPicture.asset(
                            'assets/icons/delete_circle.svg',
                          ),
                        ),
                        ListTile(
                          leading: SvgPicture.asset(
                            'assets/icons/password.svg',
                            height: 24,
                            width: 24,
                          ),
                          title: TextField(
                            keyboardType: TextInputType.text,
                            // inputFormatters: [maskFormatter],
                            controller: passwordControllerAuth,
                            onChanged: (value) {
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
                    child: const  Center(
                      child: Text(
                        'Забыли пароль?',
                        style: TextStyle(
                            color: AppColors.kPrimaryColor ,
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
                      final login = BlocProvider.of<LoginCubit>(context);
                      /*phoneController.text.length >= 17 ||
                            passwordController.text.isEmpty
                        ? Fluttertoast.showToast(
                            msg: "Логин или пароль пустые", // message
                            toastLength: Toast.LENGTH_SHORT, // length
                            gravity: ToastGravity.CENTER, // location
                            timeInSecForIosWeb: 1 // duration
                            )
                        :*/
                      login.login(phoneControllerAuth.text,
                          passwordControllerAuth.text);
                    },
                    color: Colors.white,
                    width: 343),
              ),
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
