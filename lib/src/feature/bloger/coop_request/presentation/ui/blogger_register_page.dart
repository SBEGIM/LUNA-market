import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/bloger/auth/bloc/login_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/auth/bloc/login_blogger_state.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/bloger/auth/data/DTO/blogger_dto.dart';
import 'package:haji_market/src/feature/bloger/coop_request/presentation/widget/show_blogger_register_type_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/metas_webview.dart';
import 'package:haji_market/src/feature/home/bloc/meta_cubit.dart' as meta_cubit;
import 'package:haji_market/src/feature/home/bloc/meta_state.dart' as meta_state;
import 'package:haji_market/src/feature/seller/auth/data/DTO/contry_seller_dto.dart';
import 'package:haji_market/src/feature/seller/auth/presentation/widget/show_seller_login_phone_widget.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

@RoutePage()
class BlogRegisterPage extends StatefulWidget {
  final Function(int status)? onTap;
  const BlogRegisterPage({super.key, this.onTap});

  @override
  State<BlogRegisterPage> createState() => _BlogRegisterPageState();
}

class _BlogRegisterPageState extends State<BlogRegisterPage> {
  bool isChecked = false;
  bool _passwordVisible = false;
  bool _repeatPasswordVisible = false;

  bool isButtonEnabled = false;

  TextEditingController userFirstNameController = TextEditingController();
  TextEditingController userLastNameController = TextEditingController();
  TextEditingController userSurNameController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController iinController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = MaskedTextController(mask: '(000)-000-00-00');
  TextEditingController emailController = TextEditingController();
  TextEditingController socialNetworkController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  TextEditingController checkController = TextEditingController();

  CountrySellerDto? countrySellerDto;

  @override
  void initState() {
    countrySellerDto = CountrySellerDto(
      code: '+7',
      flagPath: Assets.icons.ruFlagIcon.path,
      name: 'Россия',
    );
    if (BlocProvider.of<meta_cubit.MetaCubit>(context).state is! meta_state.MetaStateLoaded) {
      BlocProvider.of<meta_cubit.MetaCubit>(context).partners();
    }
    super.initState();
  }

  List<String> metas = [
    'Пользовательское соглашение',
    'Оферта для продавцов',
    'Политика конфиденциальности',
    'Типовой договор купли-продажи',
    'Типовой договор на оказание рекламных услуг',
  ];

  int filledCount = 1;
  int type = 0;
  double segmentHeight = 8;
  double segmentWidth = 8;
  double segmentSpacing = 2;
  int filledSegments = 1; // Начинаем с 1 заполненного сегмента
  int totalSegments = 5; // Всего сегментов
  Color filledColor = AppColors.mainPurpleColor;
  Color emptyColor = Colors.grey[200]!;
  double spacing = 5.0;
  String title = "Основная информация";

  List<String> metasBody = [];

  Map<String, String?> fieldStep1Errors = {'firstName': null, 'lastName': null, 'surName': null};

  Map<String, String?> fieldStep2Errors = {'nick': null, 'link': null};

  Map<String, String?> fieldStep3Errors = {'type': null, 'iin': null};

  Map<String, String?> fieldStep4Errors = {'check': null};

  Map<String, String?> fieldStep5Errors = {
    'phone': null,
    'email': null,
    'password': null,
    'repPassword': null,
  };

  void _validateStep1Fields() {
    setState(() {
      fieldStep1Errors['firstName'] = userFirstNameController.text.trim().isEmpty
          ? 'Введите имя'
          : null;
      fieldStep1Errors['lastName'] = userLastNameController.text.trim().isEmpty
          ? 'Введите фамилию'
          : null;
      fieldStep1Errors['surName'] = userSurNameController.text.trim().isEmpty
          ? 'Введите отчество'
          : null;
    });
  }

  void _validateStep2Fields() {
    setState(() {
      fieldStep2Errors['nick'] = nameController.text.trim().isEmpty ? 'Введите никнейм' : null;
      fieldStep2Errors['link'] = socialNetworkController.text.trim().isEmpty
          ? 'Введите ссылку на соцальную сеть'
          : null;
    });
  }

  void _validateStep3Fields() {
    setState(() {
      fieldStep3Errors['type'] = type == 0 ? 'Введите юридический статус' : null;
      fieldStep3Errors['iin'] = iinController.text.trim().isEmpty ? 'Введите иин' : null;
    });
  }

  void _validateStep4Fields() {
    setState(() {
      fieldStep4Errors['check'] = checkController.text.trim().isEmpty ? 'Введите счет' : null;
    });
  }

  void _validateStep5Fields() {
    final rawDigits = phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');

    final email = emailController.text.trim();
    if (email.isEmpty) 'Введите Email';
    final emailOk = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email);
    if (!emailOk) 'Некорректный Email';

    final pass = passwordController.text;
    final rep = repeatPasswordController.text;
    if (pass.isEmpty) 'Введите пароль';
    if (pass.length < 6) 'Пароль должен быть не короче 6 символов';
    if (rep.isEmpty) 'Повторите пароль';
    if (pass != rep) 'Пароли не совпадают';

    if (!isChecked) 'Подтвердите соглашение';

    setState(() {
      fieldStep5Errors['phone'] = rawDigits.length != 10
          ? 'Введите корректный номер телефона'
          : null;
      fieldStep5Errors['email'] = email.isEmpty
          ? 'Введите Email'
          : (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email) ? 'Некорректный Email' : null);
      fieldStep5Errors['password'] = pass.length < 6 ? 'Пароль слишком короткий' : null;
      fieldStep5Errors['repPassword'] = rep != pass ? 'Пароли не совпадают' : null;
    });

    return;
  }

  bool get isStep1Valid => fieldStep1Errors.values.every((e) => e == null);
  bool get isStep2Valid => fieldStep2Errors.values.every((e) => e == null);
  bool get isStep3Valid => fieldStep3Errors.values.every((e) => e == null);
  bool get isStep4Valid => fieldStep4Errors.values.every((e) => e == null);
  bool get isStep5Valid => fieldStep5Errors.values.every((e) => e == null);

  bool validateStep1AndSubmit() {
    _validateStep1Fields();
    return isStep1Valid;
  }

  bool validateStep2AndSubmit() {
    _validateStep2Fields();
    return isStep2Valid;
  }

  bool validateStep3AndSubmit() {
    _validateStep3Fields();
    return isStep3Valid;
  }

  bool validateStep4AndSubmit() {
    _validateStep4Fields();
    return isStep4Valid;
  }

  bool validateStep5AndSubmit() {
    _validateStep5Fields();
    return isStep5Valid;
  }

  final _step1Order = const ['lastName', 'firstName', 'lastName'];

  final _step2Order = const ['nick', 'link'];

  final _step3Order = const ['nick', 'link'];

  final _step4Order = const ['check'];

  final _step5Order = const ['phone', 'email', 'password', 'repPassword'];

  String? _validateStep1Error() {
    _validateStep1Fields();
    for (final key in _step1Order) {
      final msg = fieldStep1Errors[key];
      if (msg != null) return msg;
    }
    return null;
  }

  String? _validateStep2Error() {
    _validateStep2Fields();
    for (final key in _step2Order) {
      final msg = fieldStep2Errors[key];
      if (msg != null) return msg;
    }
    return null;
  }

  String? _validateStep3Error() {
    _validateStep3Fields();
    for (final key in _step3Order) {
      final msg = fieldStep3Errors[key];
      if (msg != null) return msg;
    }
    return null;
  }

  String? _validateStep4Error() {
    _validateStep4Fields();
    for (final key in _step4Order) {
      final msg = fieldStep4Errors[key];
      if (msg != null) return msg;
    }
    return null;
  }

  String? _validateStep5Error() {
    _validateStep5Fields();
    for (final key in _step5Order) {
      final msg = fieldStep5Errors[key];
      if (msg != null) return msg;
    }
    return null;
  }

  bool _ensureStep1Valid() {
    final msg = _validateStep1Error();
    if (msg != null) {
      // Берём живой root-контекст, чтобы не ловить "deactivated widget's ancestor"
      final rootCtx = context.router.root.navigatorKey.currentContext ?? context;
      AppSnackBar.show(rootCtx, msg, type: AppSnackType.error);
      return false;
    }
    return true;
  }

  bool _ensureStep2Valid() {
    final msg = _validateStep2Error();
    if (msg != null) {
      // Берём живой root-контекст, чтобы не ловить "deactivated widget's ancestor"
      final rootCtx = context.router.root.navigatorKey.currentContext ?? context;
      AppSnackBar.show(rootCtx, msg, type: AppSnackType.error);
      return false;
    }
    return true;
  }

  bool _ensureStep3Valid() {
    final msg = _validateStep3Error();
    if (msg != null) {
      // Берём живой root-контекст, чтобы не ловить "deactivated widget's ancestor"
      final rootCtx = context.router.root.navigatorKey.currentContext ?? context;
      AppSnackBar.show(rootCtx, msg, type: AppSnackType.error);
      return false;
    }
    return true;
  }

  bool _ensureStep4Valid() {
    final msg = _validateStep4Error();
    if (msg != null) {
      // Берём живой root-контекст, чтобы не ловить "deactivated widget's ancestor"
      final rootCtx = context.router.root.navigatorKey.currentContext ?? context;
      AppSnackBar.show(rootCtx, msg, type: AppSnackType.error);
      return false;
    }
    return true;
  }

  bool _ensureStep5Valid() {
    final msg = _validateStep5Error();
    if (msg != null) {
      // Берём живой root-контекст, чтобы не ловить "deactivated widget's ancestor"
      final rootCtx = context.router.root.navigatorKey.currentContext ?? context;
      AppSnackBar.show(rootCtx, msg, type: AppSnackType.error);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      resizeToAvoidBottomInset: true, // сами двигаем контент

      appBar: AppBar(
        toolbarHeight: 22,
        backgroundColor: AppColors.kWhite,
        leading: InkWell(
          onTap: () {
            if (filledCount != 1) {
              filledCount--;
              if (filledCount == 2) {
                title = 'Социальные сети';
              } else {
                title = 'Юридические данные';
              }
              setState(() {
                filledSegments = filledCount;
              });
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Icon(Icons.arrow_back),
        ),
      ),

      // appBar: AppBar(
      //     iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
      //     backgroundColor: Colors.white,
      //     elevation: 0,
      //     centerTitle: true,
      //     title: const Text(
      //       'Кабинет блогера',
      //       style: TextStyle(
      //         color: Colors.black,
      //         fontSize: 16,
      //         fontWeight: FontWeight.w500,
      //       ),
      //     )),
      body: Container(
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom + 52),
        child: BlocConsumer<LoginBloggerCubit, LoginBloggerState>(
          listener: (context, state) {
            if (state is LoadedState) {}
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
            }
            return Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ListView(
                shrinkWrap: true,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 22, right: 26),
                    child: SizedBox(
                      width: 300,
                      child: Text(
                        'Регистрация аккаунта\nблогера',
                        maxLines: 2,
                        style: AppTextStyles.size29Weight700,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Text(
                      title,
                      style: AppTextStyles.size16Weight400.copyWith(color: Color(0xFF808080)),
                    ),
                  ),
                  SizedBox(height: 8),
                  // const SizedBox(height: 8),
                  // const Text(
                  //   'Укажите данные ип или физ.лица',
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.w700,
                  //       fontSize: 16,
                  //       color: AppColors.kGray900),
                  // ),

                  // Прогресс-бар с пробелами
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: SizedBox(
                      height: segmentHeight,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: totalSegments,
                        separatorBuilder: (_, _) => SizedBox(width: segmentSpacing),
                        itemBuilder: (context, index) {
                          bool isFilled = index < filledCount;
                          return Container(
                            width:
                                (MediaQuery.of(context).size.width -
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
                          errorText: fieldStep1Errors['lastName'],
                        ),
                        FieldsCoopRequest(
                          titleText: 'Имя',
                          hintText: 'Введите ваше имя',
                          star: false,
                          arrow: false,
                          controller: userFirstNameController,
                          errorText: fieldStep1Errors['firstName'],
                        ),
                        FieldsCoopRequest(
                          titleText: 'Отчество',
                          hintText: 'Введите ваше отчество',
                          star: false,
                          arrow: false,
                          controller: userSurNameController,
                          errorText: fieldStep1Errors['surName'],
                        ),
                      ],
                    ),
                  ),

                  Visibility(
                    visible: filledSegments == 2 ? true : false,
                    child: Column(
                      children: [
                        FieldsCoopRequest(
                          titleText: 'Никнейм блогера (публичное имя)',
                          hintText: 'Введите никнейм блогера',
                          star: false,
                          arrow: false,
                          controller: nameController,
                          errorText: fieldStep2Errors['nick'],
                        ),
                        FieldsCoopRequest(
                          titleText: 'Ссылка на соцальную сеть',
                          hintText: 'Укажите ссылку на ваш профиль в соц.cети',
                          star: false,
                          arrow: false,
                          controller: socialNetworkController,
                          errorText: fieldStep2Errors['link'],
                        ),
                      ],
                    ),
                  ),

                  Visibility(
                    visible: filledSegments == 3 ? true : false,
                    child: Column(
                      children: [
                        FieldsCoopRequest(
                          titleText: 'Юридический статус',
                          hintText: type == 0
                              ? 'Выберите из списка'
                              : (type == 1 ? 'ИП' : 'Самозанятый'),
                          star: false,
                          arrow: true,
                          readOnly: true,
                          trueColor: type != 0 ? true : false,
                          errorText: fieldStep3Errors['type'],
                          onPressed: () async {
                            showBloggerRegisterType(
                              context,
                              type,
                              typeCall: (value) {
                                type = value;
                                setState(() {});
                              },
                            );
                          },
                        ),
                        FieldsCoopRequest(
                          titleText: 'ИНН',
                          hintText: 'Введите инн',
                          star: false,
                          arrow: false,
                          number: true,
                          controller: iinController,
                          errorText: fieldStep3Errors['iin'],
                        ),
                      ],
                    ),
                  ),
                  filledSegments == 4
                      ? FieldsCoopRequest(
                          titleText: 'Счет',
                          hintText: 'Введите счет',
                          star: false,
                          arrow: false,
                          controller: checkController,
                          errorText: fieldStep4Errors['check'],
                        )
                      : SizedBox.shrink(),

                  Visibility(
                    visible: filledSegments == 5 ? true : false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              fieldStep5Errors['phone'] == null
                                  ? 'Номер телефона'
                                  : fieldStep5Errors['phone']!,
                              textAlign: TextAlign.start,
                              style: AppTextStyles.size13Weight500.copyWith(
                                color: fieldStep5Errors['phone'] == null
                                    ? Color(0xFF636366)
                                    : AppColors.mainRedColor,
                              ),
                            ),
                            Text(
                              ' *',
                              style: TextStyle(
                                fontSize: 12,
                                color: fieldStep5Errors['phone'] == null
                                    ? Color(0xFF636366)
                                    : AppColors.mainRedColor,
                              ),
                            ),
                          ],
                        ),

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
                                        '${countrySellerDto?.code}',
                                        style: AppTextStyles.size16Weight400.copyWith(
                                          color: Color(0xFF636366),
                                        ),
                                      ),
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
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: AppColors.kGray2,
                                  border: fieldStep5Errors['phone'] != null
                                      ? Border.all(color: AppColors.mainRedColor, width: 1.0)
                                      : null,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TextField(
                                  controller: phoneController,
                                  textInputAction: TextInputAction.send,
                                  keyboardType: TextInputType.phone,
                                  style: AppTextStyles.size16Weight400.copyWith(
                                    color: Color(0xFF636366),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Введите номер телефона',
                                    hintStyle: AppTextStyles.size16Weight400.copyWith(
                                      color: Color(0xFF8E8E93),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  onSubmitted: (_) {
                                    FocusScope.of(context).unfocus(); // закрыть клавиатуру
                                  },
                                ),
                              ),
                            ),
                          ],
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
                          errorText: fieldStep5Errors['email'],
                        ),

                        Row(
                          children: [
                            Text(
                              fieldStep5Errors['password'] == null
                                  ? 'Пароль'
                                  : fieldStep5Errors['password']!,
                              style: AppTextStyles.size13Weight500.copyWith(
                                color: fieldStep5Errors['password'] == null
                                    ? Color(0xFF636366)
                                    : AppColors.mainRedColor,
                              ),
                            ),
                            const Text('*', style: TextStyle(fontSize: 12, color: Colors.red)),
                          ],
                        ),
                        SizedBox(height: 4),
                        Container(
                          height: 52,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                          ), // Increased horizontal padding
                          decoration: BoxDecoration(
                            color: AppColors.kGray2,
                            border: fieldStep5Errors['password'] != null
                                ? Border.all(color: AppColors.mainRedColor, width: 1.0)
                                : null,
                            borderRadius: BorderRadius.circular(16),
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
                                  style: AppTextStyles.size16Weight400.copyWith(
                                    color: Color(0xFF636366),
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Введите пароль',
                                    hintStyle: AppTextStyles.size16Weight400.copyWith(
                                      color: Color(0xFF8E8E93),
                                    ),
                                    contentPadding: EdgeInsets.zero, // Better control over padding
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
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Text(
                              fieldStep5Errors['repPassword'] == null
                                  ? 'Повторите пароль'
                                  : fieldStep5Errors['repPassword']!,
                              style: AppTextStyles.size13Weight500.copyWith(
                                color: fieldStep5Errors['repPassword'] == null
                                    ? Color(0xFF636366)
                                    : AppColors.mainRedColor,
                              ),
                            ),
                            const Text('*', style: TextStyle(fontSize: 12, color: Colors.red)),
                          ],
                        ),
                        SizedBox(height: 4),
                        Container(
                          height: 52,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                          ), // Increased horizontal padding
                          decoration: BoxDecoration(
                            color: AppColors.kGray2,
                            border: fieldStep5Errors['repPassword'] != null
                                ? Border.all(color: AppColors.mainRedColor, width: 1.0)
                                : null,
                            borderRadius: BorderRadius.circular(16),
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
                                  style: AppTextStyles.size16Weight400.copyWith(
                                    color: Color(0xFF636366),
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Повторите пароль',
                                    hintStyle: AppTextStyles.size16Weight400.copyWith(
                                      color: Color(0xFF8E8E93),
                                    ),
                                    contentPadding: EdgeInsets.zero, // Better control over padding
                                    isDense: true,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _repeatPasswordVisible = !_repeatPasswordVisible;
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
                        SizedBox(height: 40),
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
                                  color: isChecked ? AppColors.arrowColor : AppColors.kGray300,
                                ),
                              ),
                              SizedBox(width: 10),
                              // Container(
                              //   alignment: Alignment.topLeft,
                              //   child: Checkbox(
                              //     visualDensity: const VisualDensity(
                              //         horizontal: 0, vertical: 0),
                              //     checkColor: Colors.white,
                              //     // fillColor: MaterialStateProperty.resolveWith(Colors.),
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
                                child: BlocBuilder<meta_cubit.MetaCubit, meta_state.MetaState>(
                                  builder: (context, state) {
                                    if (state is meta_state.MetaStateLoaded) {
                                      metasBody.addAll([
                                        state.metas.terms_of_use!,
                                        state.metas.privacy_policy!,
                                        state.metas.contract_offer!,
                                        state.metas.shipping_payment!,
                                        state.metas.TTN!,
                                      ]);
                                      return GestureDetector(
                                        onTap: () {
                                          Get.to(
                                            () => MetasPage(title: metas[4], body: metasBody[4]),
                                          );
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
                                                  style: TextStyle(color: AppColors.kGray200),
                                                ),
                                                TextSpan(
                                                  text: "Оферту для блогеров",
                                                  style: TextStyle(
                                                    color: AppColors.mainPurpleColor,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      ", а также соглашаетесь с правилами использования платформы.",
                                                  style: TextStyle(color: AppColors.kGray200),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.indigoAccent,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        onTap: () async {
          userNameController.text =
              '${userFirstNameController.text} '
              '${userLastNameController.text} '
              '${userSurNameController.text}';

          if (filledSegments == 1) {
            if (!_ensureStep1Valid() && filledCount == 1) return;

            if (userFirstNameController.text.isNotEmpty &&
                userLastNameController.text.isNotEmpty &&
                userSurNameController.text.isNotEmpty) {
              setState(() {
                filledSegments = 2;
                filledCount = 2;
                title = 'Социальные сети';
              });
              return;
            } else {
              AppSnackBar.show(
                context,
                'Заполните основную информацию *',
                type: AppSnackType.error,
              );
            }
          }

          if (filledSegments == 2) {
            if (!_ensureStep2Valid() && filledCount == 2) return;

            if (nameController.text.isNotEmpty && socialNetworkController.text.isNotEmpty) {
              setState(() {
                filledSegments = 3;
                filledCount = 3;
                title = 'Юридический статус';
              });
              return;
            } else {
              AppSnackBar.show(context, 'Заполните социальные данные *', type: AppSnackType.error);
            }
          }

          if (filledSegments == 3) {
            if (!_ensureStep3Valid() && filledCount == 3) return;
            if (type != 0 && iinController.text.isNotEmpty) {
              setState(() {
                filledSegments = 4;
                filledCount = 4;
                title = 'Реквизиты банка';
              });
              return;
            } else {
              AppSnackBar.show(context, 'Заполните юридические данные *', type: AppSnackType.error);
            }
          }

          if (filledSegments == 4) {
            if (!_ensureStep4Valid() && filledCount == 4) return;

            if (checkController.text.isNotEmpty) {
              setState(() {
                filledSegments = 5;
                filledCount = 5;
                title = 'Контактные данные';
              });
              return;
            } else {
              AppSnackBar.show(context, 'Заполните реквизиты *', type: AppSnackType.error);
            }
          }

          if (filledSegments == 5) {
            if (!_ensureStep5Valid() && filledCount == 5) return;

            if (phoneController.text.isNotEmpty &&
                emailController.text.isNotEmpty &&
                passwordController.text.isNotEmpty &&
                isChecked == true &&
                passwordController.text == repeatPasswordController.text) {
              final data = BloggerDTO(
                firstName: userFirstNameController.text,
                lastName: userLastNameController.text,
                surName: userSurNameController.text,
                iin: iinController.text,
                socialNetwork: socialNetworkController.text,
                phone: phoneController.text,
                email: emailController.text,
                nick: nameController.text,
                password: passwordController.text,
                check: checkController.text,
                legalStatus: type == 0 ? 'individual-entrepreneur' : 'self-employed',
              );

              final register = BlocProvider.of<LoginBloggerCubit>(context);

              final int? statusCode = await register.register(context, data);

              debugPrint('status code $statusCode');

              if (statusCode == 200) {
                if (context.mounted) context.router.push(SuccessBloggerRegisterRoute());
              }
            } else {
              AppSnackBar.show(context, 'Заполните контактные данные *', type: AppSnackType.error);
            }
          }

          // Navigator.pop(context);
        },
        child: Container(
          height: 52,
          // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.mainPurpleColor,
          ),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          // padding: const EdgeInsets.only(left: 16, right: 16),
          child: Text(
            filledSegments != 5 ? 'Далее' : 'Зарегистрироваться',
            style: AppTextStyles.defaultButtonTextStyle.copyWith(color: AppColors.kWhite),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class FieldsCoopRequest extends StatelessWidget {
  final String titleText;
  final String hintText;
  final bool star;
  final bool arrow;
  final bool readOnly; // доп. флаг, если поле реально только для чтения
  final bool? number;
  final bool trueColor;
  final VoidCallback? onPressed; // если задан — поле работает как кнопка
  final String? icon;
  final TextEditingController? controller;
  final String? errorText;

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
      // для правильного InkWell-эффекта
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onPressed, // тап по всей области
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Заголовок + звёздочка
              Row(
                children: [
                  Text(
                    hasError ? errorText! : titleText,
                    style: AppTextStyles.size13Weight500.copyWith(
                      color: hasError ? AppColors.mainRedColor : Color(0xFF636366),
                    ),
                  ),
                  if (!star) const Text(' *', style: TextStyle(fontSize: 12, color: Colors.red)),
                ],
              ),
              const SizedBox(height: 4),

              // Поле
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.kGray2,
                  border: hasError ? Border.all(color: AppColors.mainRedColor, width: 1.0) : null,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.left,
                  readOnly: tapMode || readOnly,
                  showCursor: !(tapMode || readOnly),
                  enableInteractiveSelection: !(tapMode || readOnly),
                  onTap: tapMode ? onPressed : null,
                  keyboardType: number == true ? TextInputType.number : TextInputType.text,
                  style: AppTextStyles.size16Weight400.copyWith(color: Color(0xFF636366)),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hintText,
                    contentPadding: const EdgeInsets.all(16),
                    hintStyle: AppTextStyles.size16Weight400.copyWith(color: Color(0xFF8E8E93)),
                    suffixIcon: arrow
                        ? Padding(
                            padding: EdgeInsets.only(
                              right: (icon != null && icon!.isNotEmpty) ? 0 : 8,
                            ),
                            child: Image.asset(
                              (icon != null && icon!.isNotEmpty)
                                  ? icon!
                                  : Assets.icons.defaultArrowForwardIcon.path,
                              scale: 1.9,
                              color: (icon != null && icon!.isNotEmpty) ? AppColors.kGray300 : null,
                            ),
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
