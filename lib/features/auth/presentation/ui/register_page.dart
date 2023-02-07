import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/presentaion/base.dart';
import 'package:haji_market/features/auth/presentation/ui/register_check_sms_modal_bottom.dart';
import 'package:haji_market/features/auth/presentation/widgets/default_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/features/home/presentation/ui/home_page.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../app/widgets/scroll_wrapper.dart';
import '../../data/DTO/register.dart';
import '../../data/bloc/sms_cubit.dart';
import '../../data/bloc/sms_state.dart';
import '../widgets/forget_password_modal_bottom.dart';
import '../widgets/login_forget_password_modal_bottom.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterDTO register =
      RegisterDTO(name: 'null', phone: 'null', password: 'null');
  final maskFormatter = MaskTextInputFormatter(mask: '+#(###)-###-##-##');
  bool isChecked = false;
  bool isButtonEnabled = false;
  TextEditingController nameControllerRegister = TextEditingController();
  TextEditingController phoneControllerRegister =
      MaskedTextController(mask: '+7(000)-000-00-00');
  TextEditingController passwordControllerRegister = TextEditingController();
  TextEditingController repePasswordControllerRegister =
      TextEditingController();

  bool _passwordVisible = true;

  bool _visibleIconClearName = false;
  bool _visibleIconClearPhone = false;

  bool _visibleIconView = false;
  bool _visibleIconViewRepeat = false;

  setIsButtonEnabled(bool value) {
    // log("is button state changed $value");
    isButtonEnabled = value;
    setState(() {});
  }

  FocusNode myFocusNodePhone = FocusNode();
  FocusNode myFocusNodeName = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SmsCubit, SmsState>(listener: (context, state) {
      if (state is LoadedState) {
        showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)),
            ),
            context: context,
            builder: (context) {
              return RegisterSmsCheckModalBottom(
                  textEditingController: phoneControllerRegister.text,
                  registerDTO: RegisterDTO(
                      name: nameControllerRegister.text,
                      phone: phoneControllerRegister.text,
                      password: passwordControllerRegister.text));
            });
      }
    }, builder: (context, state) {
      if (state is LoadingState) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.indigoAccent),
        );
      }
      return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 45),
        child: ScrollWrapper(
          child: Column(
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
                        'assets/icons/user.svg',
                        height: 24,
                        width: 24,
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          _visibleIconClearName = false;
                          nameControllerRegister.clear();
                          setState(() {});
                        },
                        child: _visibleIconClearName == true
                            ? SvgPicture.asset(
                                'assets/icons/delete_circle.svg',
                              )
                            : const SizedBox(width: 5),
                      ),
                      title: TextField(
                        focusNode: myFocusNodeName,
                        controller: nameControllerRegister,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Имя и фамилия',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            // borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        onChanged: (value) {
                          _visibleIconClearName = true;
                          if (nameControllerRegister.text.isNotEmpty) {
                            setIsButtonEnabled(true);
                          } else {
                            setIsButtonEnabled(false);
                          }
                        },
                      ),
                      // trailing: SvgPicture.asset(
                      //   'assets/icons/delete_circle.svg',
                      //   height: 24,
                      //   width: 24,
                      // ),
                    ),
                    ListTile(
                      horizontalTitleGap: 5,
                      leading: SvgPicture.asset(
                        'assets/icons/phone.svg',
                        height: 24,
                        width: 24,
                      ),
                      title: TextField(
                        focusNode: myFocusNodePhone,
                        keyboardType: TextInputType.phone,
                        // inputFormatters: [maskFormatter],
                        controller: phoneControllerRegister,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Номер телефона',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            // borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        onChanged: (value) {
                          _visibleIconClearPhone = true;

                          if (phoneControllerRegister.text.length == 17) {
                            setIsButtonEnabled(true);
                          } else {
                            setIsButtonEnabled(false);
                          }
                        },
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          _visibleIconClearPhone = false;
                          phoneControllerRegister.clear();
                          setState(() {});
                        },
                        child: _visibleIconClearPhone == true
                            ? SvgPicture.asset(
                                'assets/icons/delete_circle.svg',
                              )
                            : const SizedBox(width: 5),
                      ),
                    ),
                    ListTile(
                      horizontalTitleGap: 5,
                      leading: SvgPicture.asset(
                        'assets/icons/password.svg',
                        height: 24,
                        width: 24,
                      ),
                      title: TextField(
                        // inputFormatters: [maskFormatter],
                        controller: passwordControllerRegister,
                        obscureText: !_passwordVisible,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Пароль',
                        ),
                        onChanged: (value) {
                          passwordControllerRegister.text.length.toInt() == 0
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
                                color: const Color.fromRGBO(177, 179, 181, 1),
                              )
                            : const SizedBox(width: 5),
                      ),
                    ),
                    ListTile(
                      horizontalTitleGap: 5,
                      leading: SvgPicture.asset(
                        'assets/icons/password.svg',
                        height: 24,
                        width: 24,
                      ),
                      title: TextField(
                        // inputFormatters: [maskFormatter],
                        controller: repePasswordControllerRegister,
                        obscureText: !_passwordVisible,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Подтвердите пароль',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            // borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        onChanged: (value) {
                          repePasswordControllerRegister.text.length == 0
                              ? _visibleIconViewRepeat = false
                              : _visibleIconViewRepeat = true;
                          if (passwordControllerRegister.text ==
                              repePasswordControllerRegister.text) {
                            setIsButtonEnabled(true);
                          } else {
                            setIsButtonEnabled(false);
                          }
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
                                color: const Color.fromRGBO(177, 179, 181, 1),
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
              Center(
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                        child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        children: <TextSpan>[
                          TextSpan(text: 'Нажимая «Зарегистрироваться», Вы '),
                          TextSpan(text: 'принимаете '),
                          TextSpan(
                            text: 'Пользовательское \n соглашение',
                            style: TextStyle(
                                color: AppColors.kPrimaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          TextSpan(
                              text:
                                  ' и даете согласие на \n обработку персональных данных'),
                          TextSpan(text: 'в соответствии с Политикой'),
                          TextSpan(
                            text: ' Политикой',
                            style: TextStyle(
                                color: AppColors.kPrimaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ))

                    // Text(
                    //   textAlign: TextAlign.center,
                    //   'Нажимая «Зарегистрироваться», Вы принимаете Пользовательское \n соглашение и даете согласие на \n обработку персональных данных в соответствии с Политикой',
                    //   style: TextStyle(
                    //       color: AppColors.kGray900,
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w400),
                    // ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: DefaultButton(
                    backgroundColor: (nameControllerRegister.text.isNotEmpty &&
                            phoneControllerRegister.text.length >= 17 &&
                            passwordControllerRegister.text.isNotEmpty)
                        ? AppColors.kPrimaryColor
                        : const Color(0xFFD6D8DB),
                    text: 'Зарегистрироваться',
                    press: () {
                      if (nameControllerRegister.text.isNotEmpty &&
                          phoneControllerRegister.text.length >= 17 &&
                          passwordControllerRegister.text.isNotEmpty) {
                        if (passwordControllerRegister.text ==
                            repePasswordControllerRegister.text) {
                          register = RegisterDTO(
                            name: nameControllerRegister.text,
                            phone: phoneControllerRegister.text,
                            password: passwordControllerRegister.text,
                          );

                          final sms = BlocProvider.of<SmsCubit>(context);
                          sms.smsSend(phoneControllerRegister.text);
                        } else {
                          Get.snackbar('Ошибка запроса', 'Пароли не совпадают!',
                              backgroundColor: Colors.blueAccent);
                        }
                      } else {
                        Get.snackbar('Ошибка запроса', 'Заполните данные!',
                            backgroundColor: Colors.blueAccent);
                      }

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) =>const  Base()),
                      // );
                    },
                    color: Colors.white,
                    width: 343),
              ),
            ],
          ),
        ),

        // SizedBox(height: 20,),
      );
    });
  }
}
