import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/auth/presentation/ui/register_check_sms_modal_bottom.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/metas_webview.dart';
import 'package:haji_market/src/feature/home/data/bloc/meta_cubit.dart'
    as metaCubit;
import 'package:haji_market/src/feature/home/data/bloc/meta_state.dart'
    as metaState;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../app/widgets/scroll_wrapper.dart';
import '../../data/DTO/register.dart';
import '../../data/bloc/sms_cubit.dart';
import '../../data/bloc/sms_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterDTO register =
      const RegisterDTO(name: 'null', phone: 'null', password: 'null');
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

  @override
  void initState() {
    if (BlocProvider.of<metaCubit.MetaCubit>(context).state
        is! metaState.LoadedState) {
      BlocProvider.of<metaCubit.MetaCubit>(context).partners();
    }
    super.initState();
  }

  FocusNode myFocusNodePhone = FocusNode();
  FocusNode myFocusNodeName = FocusNode();

  List<String> metas = [
    'Пользовательское соглашение',
    'Оферта для продавцов',
    'Политика конфиденциальности',
    'Типовой договор купли-продажи',
    'Типовой договор на оказание рекламных услуг'
  ];

  List<String> metasBody = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SmsCubit, SmsState>(listener: (context, state) {
      if (state is InitState) {
        FocusScope.of(context).requestFocus(FocusNode());
        //   Navigator.pop(context);
      }
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
                            FocusScope.of(context).requestFocus(FocusNode());
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
                          repePasswordControllerRegister.text.isEmpty
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
                    const SizedBox(
                      width: 10,
                    ),

                    BlocBuilder<metaCubit.MetaCubit, metaState.MetaState>(
                        builder: (context, state) {
                      if (state is metaState.LoadedState) {
                        metasBody.addAll([
                          state.metas.terms_of_use!,
                          state.metas.privacy_policy!,
                          state.metas.contract_offer!,
                          state.metas.shipping_payment!,
                          state.metas.TTN!,
                        ]);
                        return Flexible(
                            child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                            children: <TextSpan>[
                              const TextSpan(
                                  text: 'Нажимая «Зарегистрироваться», Вы '),
                              const TextSpan(text: 'принимаете '),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(() => MetasPage(
                                        title: metas[0],
                                        body: metasBody[0],
                                      )),
                                text: 'Пользовательское \n соглашение',
                                style: const TextStyle(
                                    color: AppColors.kPrimaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              const TextSpan(
                                  text:
                                      ' и даете согласие на \n обработку персональных данных'),
                              const TextSpan(text: 'в соответствии с '),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.to(() => MetasPage(
                                        title: metas[2],
                                        body: metasBody[2],
                                      )),
                                text: 'Политикой Конфиденциальности',
                                style: const TextStyle(
                                    color: AppColors.kPrimaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ));
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                                color: Colors.indigoAccent));
                      }
                    }),

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
