import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/auth/bloc/register_cubit.dart';
import 'package:haji_market/src/feature/auth/bloc/register_state.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/metas_webview.dart';
import 'package:haji_market/src/feature/home/bloc/meta_cubit.dart' as metaCubit;
import 'package:haji_market/src/feature/home/bloc/meta_state.dart' as metaState;
import 'package:haji_market/src/feature/seller/auth/data/DTO/contry_seller_dto.dart';
import 'package:haji_market/src/feature/seller/auth/presentation/widget/show_seller_login_phone_widget.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../data/DTO/register.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isChecked = false;
  bool _passwordVisible = false;
  bool _repeatPasswordVisible = false;

  bool _visibleIconClear = false;
  bool __visibleIconView = false;
  bool isButtonEnabled = false;
  RegisterDTO register = const RegisterDTO(
      surName: 'null',
      firstName: 'null',
      lastName: 'null',
      phone: 'null',
      password: 'null');
  final maskFormatter = MaskTextInputFormatter(mask: '+#(###)-###-##-##');

  TextEditingController userFirstNameController = TextEditingController();
  TextEditingController userLastNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();

  TextEditingController nameControllerRegister = TextEditingController();
  TextEditingController phoneControllerRegister =
      MaskedTextController(mask: '(000)-000-00-00');
  TextEditingController passwordControllerRegister = TextEditingController();
  TextEditingController repePasswordControllerRegister =
      TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();


  setIsButtonEnabled(bool value) {
    // log("is button state changed $value");
    isButtonEnabled = value;
    setState(() {});
  }

  Map<String, String?> fieldErrors = {
    'lastName': null,
    'middleName': null,
    'firstName': null,
    'phone': null,
    'email': null,
    'password': null,
    'repeatPassword': null,
  };

  @override
  void initState() {
    countrySellerDto = CountrySellerDto(
        code: '+7', flagPath: Assets.icons.ruFlagIcon.path, name: 'Россия');
    if (BlocProvider.of<metaCubit.MetaCubit>(context).state
        is! metaState.LoadedState) {
      BlocProvider.of<metaCubit.MetaCubit>(context).partners();
    }

    for (final c in [
      userFirstNameController,
      userLastNameController,
      middleNameController,
      phoneControllerRegister,
      emailController,
      passwordController,
      repeatPasswordController,
    ]) {
      c.addListener(() => setState(() {}));
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

  int filledCount = 1;
  double segmentHeight = 8;
  double segmentWidth = 8;
  double segmentSpacing = 2;
  int filledSegments = 1; // Начинаем с 1 заполненного сегмента
  int totalSegments = 2; // Всего сегментов
  Color filledColor = AppColors.mainPurpleColor;
  Color emptyColor = Colors.grey[200]!;
  double spacing = 5.0;
  String title = "Основная информация";

  CountrySellerDto? countrySellerDto;

  void _nextStep() {
    if (filledSegments < 2) {
      setState(() {
        filledSegments++;
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Регистрация завершена')));
    }
  }

  List<String> metasBody = [];

  String? _validateStep1Error() {
    final first = userFirstNameController.text.trim();
    final last = userLastNameController.text.trim();
    final middle = middleNameController.text.trim();

    if (last.isEmpty && first.isEmpty && middle.isEmpty)
      return 'Заполните фамилию и имя';
    if (last.isEmpty) return 'Заполните фамилию';
    if (first.isEmpty) return 'Заполните имя';
    if (middle.isEmpty) return 'Заполните отчество';

    return null;
  }

  void _validateStep1Fields() {
    setState(() {
      fieldErrors['lastName'] =
          userLastNameController.text.trim().isEmpty ? 'Введите фамилию' : null;
      fieldErrors['middleName'] =
          middleNameController.text.trim().isEmpty ? 'Введите отчество' : null;
      fieldErrors['firstName'] =
          userFirstNameController.text.trim().isEmpty ? 'Введите имя' : null;
    });
  }

  String? _validateStep2Error() {
    final rawDigits =
        phoneControllerRegister.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (rawDigits.length != 10) return 'Введите корректный номер телефона';

    final email = emailController.text.trim();
    if (email.isEmpty) return 'Введите Email';
    final emailOk = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email);
    if (!emailOk) return 'Некорректный Email';

    final pass = passwordController.text;
    final rep = repeatPasswordController.text;
    if (pass.isEmpty) return 'Введите пароль';
    if (pass.length < 6) return 'Пароль должен быть не короче 6 символов';
    if (rep.isEmpty) return 'Повторите пароль';
    if (pass != rep) return 'Пароли не совпадают';

    if (!isChecked) return 'Подтвердите соглашение';
    return null;
  }

  void _validateStep2Fields() {
    final phone =
        phoneControllerRegister.text.replaceAll(RegExp(r'[^0-9]'), '');
    final email = emailController.text.trim();
    final pass = passwordController.text;
    final rep = repeatPasswordController.text;

    setState(() {
      fieldErrors['phone'] =
          phone.length != 10 ? 'Введите корректный номер телефона' : null;
      fieldErrors['email'] = email.isEmpty
          ? 'Введите Email'
          : (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)
              ? 'Некорректный Email'
              : null);
      fieldErrors['password'] =
          pass.length < 6 ? 'Пароль слишком короткий' : null;
      fieldErrors['repeatPassword'] =
          rep != pass ? 'Пароли не совпадают' : null;
    });
  }

  bool _ensureStep1Valid() {
    final msg = _validateStep1Error();
    if (msg != null) {
      AppSnackBar.show(context, msg, type: AppSnackType.error);
      return false;
    }
    return true;
  }

  bool _ensureStep2Valid() {
    final msg = _validateStep2Error();
    if (msg != null) {
      AppSnackBar.show(context, msg, type: AppSnackType.error);
      return false;
    }
    return true;
  }

  bool get _canProceed {
    if (filledSegments == 1) return _validateStep1Error() == null;
    return _validateStep2Error() == null;
  }

  @override
  void dispose() {
    userFirstNameController.dispose();
    userLastNameController.dispose();
    middleNameController.dispose();
    nameControllerRegister.dispose();
    phoneControllerRegister.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        toolbarHeight: 22,
        backgroundColor: AppColors.kWhite,
        leading: InkWell(
            onTap: () {
              if (filledCount != 1) {
                filledCount--;
                if (filledCount == 2) {
                  title = 'Основная информация';
                } else {
                  title = 'Контактные данные';
                }
                setState(() {
                  filledSegments = filledCount;
                });
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
        if (state is InitState) {
          FocusScope.of(context).requestFocus(FocusNode());
          //   Navigator.pop(context);
        }
        if (state is LoadedState) {
          context.router.push(SuccessRegisterRoute());
          // showModalBottomSheet(
          //     shape: const RoundedRectangleBorder(
          //       borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(10.0),
          //           topRight: Radius.circular(10.0)),
          //     ),
          //     context: context,
          //     builder: (context) {
          //       return RegisterSmsCheckModalBottom(
          //           textEditingController: phoneControllerRegister.text,
          //           registerDTO: RegisterDTO(
          //               name: nameControllerRegister.text,
          //               phone: phoneControllerRegister.text,
          //               password: passwordControllerRegister.text));
          //     });
        }
      }, builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.indigoAccent),
          );
        }
        return Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 45),
          child: ListView(
            children: [
              SizedBox(
                width: 320,
                child: Text(
                  'Регистрация аккаунта пользователя',
                  maxLines: 2,
                  style: AppTextStyles.size29Weight700,
                ),
              ),
              SizedBox(height: 10),
              Text(title,
                  style: AppTextStyles.size16Weight400
                      .copyWith(color: Color(0xFF808080))),
              SizedBox(height: 8),
              SizedBox(
                height: segmentHeight,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: totalSegments,
                  separatorBuilder: (_, __) => SizedBox(width: segmentSpacing),
                  itemBuilder: (context, index) {
                    bool isFilled = index < filledCount;
                    return Container(
                      width: (MediaQuery.of(context).size.width -
                              (totalSegments - 1) * segmentSpacing -
                              32) /
                          totalSegments,
                      decoration: BoxDecoration(
                        color: isFilled ? filledColor : emptyColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 24),
              Visibility(
                  visible: filledSegments == 1 ? true : false,
                  child: Column(
                    children: [
                      FieldsCoopRequest(
                        titleText: 'Фамилия',
                        hintText: 'Введите вашу фамилию',
                        star: false,
                        arrow: false,
                        controller: userLastNameController,
                        errorText: fieldErrors['lastName'],
                      ),
                      FieldsCoopRequest(
                        titleText: 'Имя',
                        hintText: 'Введите ваше имя',
                        star: false,
                        arrow: false,
                        controller: userFirstNameController,
                        errorText: fieldErrors['firstName'],
                      ),
                      FieldsCoopRequest(
                        titleText: 'Отчество',
                        hintText: 'Введите ваше отчество',
                        star: false,
                        arrow: false,
                        controller: middleNameController,
                        errorText: fieldErrors['middleName'],
                      ),
                    ],
                  )),
              Visibility(
                  visible: filledSegments == 2 ? true : false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Номер телефона',
                          textAlign: TextAlign.start,
                          style: AppTextStyles.size13Weight500
                              .copyWith(color: Color(0xFF636366))),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showSellerLoginPhone(
                                context,
                                countryCall: (dto) {
                                  countrySellerDto = dto;
                                  setState(() {});
                                },
                              );
                            },
                            child: Shimmer(
                              child: Container(
                                height: 52,
                                width: 83,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  color: AppColors.kGray2,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      countrySellerDto!.flagPath,
                                      width: 24,
                                      height: 24,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      '${countrySellerDto!.code}',
                                      style: AppTextStyles.size16Weight400
                                          .copyWith(color: Color(0xFF636366)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 4),
                          // Поле ввода
                          Flexible(
                            child: Container(
                              height: 52,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: AppColors.kGray2,
                                borderRadius: BorderRadius.circular(16),
                                border: fieldErrors['phone'] != null
                                    ? Border.all(color: Colors.red, width: 1.0)
                                    : null,
                              ),
                              child: TextField(
                                controller: phoneControllerRegister,
                                textInputAction: TextInputAction.send,
                                keyboardType: TextInputType.phone,
                                style: AppTextStyles.size16Weight400
                                    .copyWith(color: Color(0xFF636366)),
                                decoration: InputDecoration(
                                  hintText: 'Введите номер телефона',
                                  hintStyle: AppTextStyles.size16Weight400
                                      .copyWith(color: Color(0xFF8E8E93)),
                                  border: InputBorder.none,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onSubmitted: (_) {
                                  FocusScope.of(context)
                                      .unfocus(); // закрыть клавиатуру
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (fieldErrors['phone'] != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 4),
                          child: Text(
                            fieldErrors['phone']!,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12),
                          ),
                        ),
                      SizedBox(height: 12),
                      // FieldsCoopRequest(
                      //   titleText: 'Мобильный телефон ',
                      //   hintText: 'Введите мобильный телефон ',
                      //   star: false,
                      //   arrow: false,
                      //   number: true,
                      //   controller: phoneController,
                      // ),
                      FieldsCoopRequest(
                        titleText: 'Email ',
                        hintText: 'Введите Email',
                        star: false,
                        arrow: false,
                        controller: emailController,
                        errorText: fieldErrors['email'],
                      ),

                      Row(
                        children: [
                          Text('Пароль',
                              style: AppTextStyles.size13Weight500
                                  .copyWith(color: Color(0xFF636366))),
                          const Text('*',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.red)),
                        ],
                      ),
                      SizedBox(height: 4),
                      Container(
                        height: 52,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16), // Increased horizontal padding
                        decoration: BoxDecoration(
                          color: AppColors.kGray2,
                          borderRadius: BorderRadius.circular(16),
                          border: fieldErrors['password'] != null
                              ? Border.all(color: Colors.red, width: 1.0)
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: passwordController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                obscureText: !_passwordVisible,
                                style: AppTextStyles.size16Weight400
                                    .copyWith(color: Color(0xFF636366)),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Введите пароль',
                                  hintStyle: AppTextStyles.size16Weight400
                                      .copyWith(color: Color(0xFF8E8E93)),
                                  contentPadding: EdgeInsets
                                      .zero, // Better control over padding
                                  isDense: true,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                              child: Image.asset(
                                _passwordVisible
                                    ? Assets.icons.passwordViewHiddenIcon.path
                                    : Assets.icons.passwordViewIcon.path,
                                scale: 1.9,
                                color: AppColors.kGray300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (fieldErrors['password'] != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 4),
                          child: Text(
                            fieldErrors['password']!,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12),
                          ),
                        ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Text('Повторить  пароль',
                              style: AppTextStyles.size13Weight500
                                  .copyWith(color: Color(0xFF636366))),
                          const Text('*',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.red)),
                        ],
                      ),
                      SizedBox(height: 4),
                      Container(
                        height: 52,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16), // Increased horizontal padding
                        decoration: BoxDecoration(
                          color: AppColors.kGray2,
                          borderRadius: BorderRadius.circular(16),
                          border: fieldErrors['repeatPassword'] != null
                              ? Border.all(color: Colors.red, width: 1.0)
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: repeatPasswordController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                obscureText: !_repeatPasswordVisible,
                                style: AppTextStyles.size16Weight400
                                    .copyWith(color: Color(0xFF636366)),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Повторите пароль',
                                  hintStyle: AppTextStyles.size16Weight400
                                      .copyWith(color: Color(0xFF8E8E93)),
                                  contentPadding: EdgeInsets
                                      .zero, // Better control over padding
                                  isDense: true,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _repeatPasswordVisible =
                                      !_repeatPasswordVisible;
                                });
                              },
                              child: Image.asset(
                                _repeatPasswordVisible
                                    ? Assets.icons.passwordViewHiddenIcon.path
                                    : Assets.icons.passwordViewIcon.path,
                                scale: 1.9,
                                color: AppColors.kGray300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (fieldErrors['repeatPassword'] != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 4),
                          child: Text(
                            fieldErrors['repeatPassword']!,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  )),
              Visibility(
                  visible: filledSegments == 2 ? true : false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isChecked = !isChecked;
                                });
                              },
                              child: Image.asset(
                                isChecked
                                    ? Assets.icons.defaultCheckIcon.path
                                    : Assets.icons.defaultUncheckIcon.path,
                                scale: 1.9,
                                color: isChecked
                                    ? AppColors.arrowColor
                                    : AppColors.kGray300,
                              ),
                            ),
                            SizedBox(width: 10),
                            // Container(
                            //   alignment: Alignment.topLeft,
                            //   child: Checkbox(
                            //     visualDensity: const VisualDensity(
                            //         horizontal: 0, vertical: 0),
                            //     checkColor: Colors.white,
                            //     // fillColor: WidgetStateProperty.resolveWith(Colors.),
                            //     value: isChecked,
                            //     onChanged: (bool? value) {
                            //       setState(() {
                            //         isChecked = value!;
                            //       });
                            //     },
                            //   ),
                            // ),
                            SizedBox(
                              width: 311,
                              child: BlocBuilder<metaCubit.MetaCubit,
                                      metaState.MetaState>(
                                  builder: (context, state) {
                                if (state is metaState.LoadedState) {
                                  metasBody.addAll([
                                    state.metas.terms_of_use!,
                                    state.metas.privacy_policy!,
                                    state.metas.contract_offer!,
                                    state.metas.shipping_payment!,
                                    state.metas.TTN!,
                                  ]);
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() => MetasPage(
                                            title: metas[2],
                                            body: metasBody[2],
                                          ));
                                    },
                                    child: Container(
                                      alignment: Alignment.bottomLeft,
                                      child: RichText(
                                        textAlign: TextAlign.left,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  "Нажимая «Зарегистрироваться», вы подтверждаете, что ознакомились и \nпринимаете ",
                                              style: TextStyle(
                                                color: AppColors.kGray200,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  "Пользовательское соглашение ",
                                              style: TextStyle(
                                                color:
                                                    AppColors.mainPurpleColor,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  ", а также соглашаетесь с правилами использования платформы.",
                                              style: TextStyle(
                                                color: AppColors.kGray200,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.indigoAccent));
                                }
                              }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  )),
            ],
          ),
        );
      }),
      bottomSheet: Container(
        margin: EdgeInsets.only(bottom: 50, left: 16, right: 16),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: DefaultButton(
            backgroundColor: _canProceed
                ? AppColors.mainPurpleColor
                : const Color(0xFFC5ADFC),
            text: filledCount == 1 ? 'Далее' : 'Зарегистрироваться',
            press: () {
              _validateStep1Fields();

              if (!_ensureStep1Valid()) return;
              nameControllerRegister.text = '${userFirstNameController.text} '
                  '${userLastNameController.text} '
                  '${middleNameController.text}';

              if (filledSegments == 1) {
                if (nameControllerRegister.text.isNotEmpty) {
                  setState(() {
                    filledSegments = 2;
                    filledCount = 2;
                    title = 'Контактные данные';
                  });
                  return;
                }
              }
              _validateStep2Fields();
              if (!_ensureStep2Valid()) return;

              final RegisterDTO registerDTO = RegisterDTO(
                  firstName: userFirstNameController.text,
                  lastName: userLastNameController.text,
                  surName: middleNameController.text,
                  phone: phoneControllerRegister.text,
                  password: passwordController.text);
              final register = BlocProvider.of<RegisterCubit>(context);
              register.register(context, registerDTO);
            },
            color: Colors.white,
            width: double.infinity),
      ),
    );
  }
}

class FieldsCoopRequest extends StatelessWidget {
  final String titleText;
  final String hintText;
  final bool star;
  final bool arrow;
  final bool readOnly;
  final bool? number;
  final bool trueColor;
  final VoidCallback? onPressed;
  final String? icon;
  final TextEditingController? controller;
  final String? errorText; // 🆕 добавили

  const FieldsCoopRequest({
    super.key,
    required this.hintText,
    required this.titleText,
    required this.star,
    required this.arrow,
    this.controller,
    this.onPressed,
    this.readOnly = false,
    this.number,
    this.trueColor = false,
    this.icon,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final bool tapMode = onPressed != null;
    final hasError = errorText != null;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(hasError ? errorText! : titleText,
                      style: AppTextStyles.size13Weight500.copyWith(
                          color: hasError
                              ? AppColors.mainRedColor
                              : Color(0xFF636366))),
                  if (!star)
                    const Text('*',
                        style: TextStyle(fontSize: 12, color: Colors.red)),
                ],
              ),
              const SizedBox(height: 4),
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.kGray2,
                  borderRadius: BorderRadius.circular(16),
                  border: hasError
                      ? Border.all(color: AppColors.mainRedColor, width: 1.0)
                      : null,
                ),
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.left,
                  readOnly: tapMode || readOnly,
                  showCursor: !(tapMode || readOnly),
                  enableInteractiveSelection: !(tapMode || readOnly),
                  onTap: tapMode ? onPressed : null,
                  keyboardType: number == true
                      ? TextInputType.number
                      : TextInputType.text,
                  style: AppTextStyles.size16Weight400
                      .copyWith(color: Color(0xFF636366)),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    hintStyle: AppTextStyles.size16Weight400
                        .copyWith(color: Color(0xFF8E8E93)),
                    suffixIcon: arrow
                        ? Padding(
                            padding: EdgeInsets.only(
                                right:
                                    (icon != null && icon!.isNotEmpty) ? 0 : 0),
                            child: Image.asset(
                                (icon != null && icon!.isNotEmpty)
                                    ? icon!
                                    : Assets.icons.defaultArrowForwardIcon.path,
                                scale: 1.9,
                                color: (icon != null && icon!.isNotEmpty)
                                    ? AppColors.kGray300
                                    : null),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
