import 'package:auto_route/auto_route.dart';
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
import 'package:haji_market/src/feature/home/bloc/meta_cubit.dart' as metaCubit;
import 'package:haji_market/src/feature/home/bloc/meta_state.dart' as metaState;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../app/widgets/scroll_wrapper.dart';
import '../../data/DTO/register.dart';
import '../../bloc/sms_cubit.dart';
import '../../bloc/sms_state.dart';

@RoutePage()
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
    return Scaffold(
      backgroundColor: AppColors.kGray1,
      appBar: AppBar(
        backgroundColor: AppColors.kGray1,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: BlocConsumer<SmsCubit, SmsState>(listener: (context, state) {
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
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 45),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: 300,
                  child: Text(
                    'Регистрация аккаунта пользователя',
                    maxLines: 2,
                    style: AppTextStyles.defaultAppBarTextStyle,
                  ),
                ),
              ),
              FieldsCoopRequest(
                titleText: 'Контактное имя ',
                hintText: 'Введите контактное имя',
                star: false,
                controller: nameControllerRegister,
              ),
              FieldsCoopRequest(
                titleText: 'Номер телефона ',
                hintText: 'Введите номер телефона',
                star: false,
                isPhone: true,
                controller: phoneControllerRegister,
              ),
              FieldsCoopRequest(
                titleText: 'Пароль ',
                hintText: 'Введите пароль',
                star: false,
                controller: passwordControllerRegister,
                isPassword: true,
                onChanged: (_) => setState(() {
                  // Обнови логику валидности пароля
                }),
              ),
              FieldsCoopRequest(
                titleText: 'Подтвердите пароль ',
                hintText: 'Введите пароль повторно',
                star: false,
                controller: repePasswordControllerRegister,
                isPassword: true,
                onChanged: (value) {
                  if (value == passwordControllerRegister.text) {
                    setIsButtonEnabled(true);
                  } else {
                    setIsButtonEnabled(false);
                  }
                },
              ),
              // Container(
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(8)),
              //   child: Column(
              //     children: [
              //       ListTile(
              //         horizontalTitleGap: 5,
              //         leading: SvgPicture.asset(
              //           'assets/icons/password.svg',
              //           height: 24,
              //           width: 24,
              //         ),
              //         title: TextField(
              //           // inputFormatters: [maskFormatter],
              //           controller: passwordControllerRegister,
              //           obscureText: !_passwordVisible,
              //           decoration: const InputDecoration(
              //             border: InputBorder.none,
              //             hintText: 'Пароль',
              //           ),
              //           onChanged: (value) {
              //             passwordControllerRegister.text.length.toInt() == 0
              //                 ? _visibleIconView = false
              //                 : _visibleIconView = true;
              //             setState(() {});
              //           },
              //         ),
              //         trailing: GestureDetector(
              //           onTap: () {
              //             setState(() {
              //               _passwordVisible = !_passwordVisible;
              //             });
              //           },
              //           child: _visibleIconView == true
              //               ? Icon(
              //                   _passwordVisible
              //                       ? Icons.visibility_off
              //                       : Icons.visibility,
              //                   color: const Color.fromRGBO(177, 179, 181, 1),
              //                 )
              //               : const SizedBox(width: 5),
              //         ),
              //       ),
              //       ListTile(
              //         horizontalTitleGap: 5,
              //         leading: SvgPicture.asset(
              //           'assets/icons/password.svg',
              //           height: 24,
              //           width: 24,
              //         ),
              //         title: TextField(
              //           // inputFormatters: [maskFormatter],
              //           controller: repePasswordControllerRegister,
              //           obscureText: !_passwordVisible,
              //           decoration: const InputDecoration(
              //             border: InputBorder.none,
              //             hintText: 'Подтвердите пароль',
              //             enabledBorder: UnderlineInputBorder(
              //               borderSide: BorderSide(color: Colors.white),
              //               // borderRadius: BorderRadius.circular(3),
              //             ),
              //           ),
              //           onChanged: (value) {
              //             repePasswordControllerRegister.text.isEmpty
              //                 ? _visibleIconViewRepeat = false
              //                 : _visibleIconViewRepeat = true;
              //             if (passwordControllerRegister.text ==
              //                 repePasswordControllerRegister.text) {
              //               setIsButtonEnabled(true);
              //             } else {
              //               setIsButtonEnabled(false);
              //             }
              //           },
              //         ),
              //         trailing: GestureDetector(
              //           onTap: () {
              //             setState(() {
              //               _passwordVisible = !_passwordVisible;
              //             });
              //           },
              //           child: _visibleIconViewRepeat == true
              //               ? Icon(
              //                   _passwordVisible
              //                       ? Icons.visibility_off
              //                       : Icons.visibility,
              //                   color: const Color.fromRGBO(177, 179, 181, 1),
              //                 )
              //               : const SizedBox(width: 5),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: 16,
              // ),

              SizedBox(height: 20),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                fontSize: 14,
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
                                text: 'Пользовательское соглашение',
                                style: const TextStyle(
                                    color: AppColors.mainPurpleColor,
                                    fontSize: 14,
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
                                    color: AppColors.mainPurpleColor,
                                    fontSize: 14,
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
                        ? AppColors.mainPurpleColor
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
                    width: double.infinity),
              ),
            ],
          ),

          // SizedBox(height: 20,),
        );
      }),
    );
  }
}

class FieldsCoopRequest extends StatefulWidget {
  final String titleText;
  final String hintText;
  final bool star;
  final bool isPassword;
  final bool isPhone;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  const FieldsCoopRequest({
    required this.titleText,
    required this.hintText,
    required this.controller,
    this.star = false,
    this.isPassword = false,
    this.isPhone = false,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<FieldsCoopRequest> createState() => _FieldsCoopRequestState();
}

class _FieldsCoopRequestState extends State<FieldsCoopRequest> {
  bool _obscureText = true;
  bool _showClearIcon = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      final shouldShow = widget.controller.text.isNotEmpty;
      if (_showClearIcon != shouldShow) {
        setState(() {
          _showClearIcon = shouldShow;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.titleText,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColors.kGray900,
                ),
              ),
              if (!widget.star)
                const Text(
                  '*',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            height: 47,
            padding: const EdgeInsets.only(left: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: widget.controller,
              obscureText: widget.isPassword ? _obscureText : false,
              keyboardType:
                  widget.isPhone ? TextInputType.phone : TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(194, 197, 200, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_showClearIcon)
                      IconButton(
                        icon: const Icon(Icons.clear, size: 20),
                        onPressed: () {
                          widget.controller.clear();
                          if (widget.onChanged != null) {
                            widget.onChanged!('');
                          }
                        },
                      ),
                    if (widget.isPassword)
                      IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 20,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                  ],
                ),
              ),
              onChanged: widget.onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
