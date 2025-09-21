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
import 'package:haji_market/src/feature/bloger/coop_request/presentation/widget/show_blogger_register_type_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/metas_webview.dart';
import 'package:haji_market/src/feature/home/bloc/meta_cubit.dart' as metaCubit;
import 'package:haji_market/src/feature/home/bloc/meta_state.dart' as metaState;
import 'package:haji_market/src/feature/seller/auth/data/DTO/contry_seller_dto.dart';
import 'package:haji_market/src/feature/seller/auth/presentation/widget/show_seller_login_phone_widget.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../auth/data/DTO/register_blogger_dto.dart';

@RoutePage()
class BlogRegisterPage extends StatefulWidget {
  final Function(int status)? onTap;
  const BlogRegisterPage({Key? key, this.onTap}) : super(key: key);

  @override
  State<BlogRegisterPage> createState() => _BlogRegisterPageState();
}

class _BlogRegisterPageState extends State<BlogRegisterPage> {
  bool isChecked = false;
  bool _passwordVisible = false;
  bool _repeatPasswordVisible = false;

  bool _visibleIconClear = false;
  bool __visibleIconView = false;
  bool isButtonEnabled = false;

  TextEditingController userFirstNameController = TextEditingController();
  TextEditingController userLastNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController iinController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController =
      MaskedTextController(mask: '(000)-000-00-00');
  TextEditingController emailController = TextEditingController();
  TextEditingController socialNetworkController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

  TextEditingController checkController = TextEditingController();

  CountrySellerDto? countrySellerDto;

  @override
  void initState() {
    countrySellerDto = CountrySellerDto(
        code: '+7', flagPath: Assets.icons.ruFlagIcon.path, name: 'Россия');
    if (BlocProvider.of<metaCubit.MetaCubit>(context).state
        is! metaState.LoadedState) {
      BlocProvider.of<metaCubit.MetaCubit>(context).partners();
    }
    super.initState();
  }

  List<String> metas = [
    'Пользовательское соглашение',
    'Оферта для продавцов',
    'Политика конфиденциальности',
    'Типовой договор купли-продажи',
    'Типовой договор на оказание рекламных услуг'
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.kWhite,
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
            child: Icon(Icons.arrow_back)),
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
      body: BlocConsumer<LoginBloggerCubit, LoginBloggerState>(
          listener: (context, state) {
        if (state is LoadedState) {}
      }, builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.indigoAccent),
          );
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
                child: Text(title,
                    style: AppTextStyles.size16Weight400
                        .copyWith(color: Color(0xFF808080))),
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
                    separatorBuilder: (_, __) =>
                        SizedBox(width: segmentSpacing),
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
                      ),
                      FieldsCoopRequest(
                        titleText: 'Имя',
                        hintText: 'Введите ваше имя',
                        star: false,
                        arrow: false,
                        controller: userFirstNameController,
                      ),
                      FieldsCoopRequest(
                        titleText: 'Отчество',
                        hintText: 'Введите ваше отчество',
                        star: false,
                        arrow: false,
                        controller: middleNameController,
                      ),
                    ],
                  )),

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
                      ),
                      FieldsCoopRequest(
                        titleText: 'Ссылка на соцальную сеть',
                        hintText: 'Укажите ссылку на ваш профиль в соц.cети',
                        star: false,
                        arrow: false,
                        controller: socialNetworkController,
                      ),
                    ],
                  )),

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
                        onPressed: () async {
                          print('ok');
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
                      ),
                    ],
                  )),
              filledSegments == 4
                  ? FieldsCoopRequest(
                      titleText: 'Счет',
                      hintText: 'Введите счет',
                      star: false,
                      arrow: false,
                      controller: checkController,
                    )
                  : SizedBox.shrink(),

              Visibility(
                  visible: filledSegments == 5 ? true : false,
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
                              ),
                              child: TextField(
                                controller: phoneController,
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
                                            title: metas[4],
                                            body: metasBody[4],
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
                                              text: "Оферту для блогеров",
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
                      const SizedBox(height: 100)
                    ],
                  )),
            ],
          ),
        );
      }),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: InkWell(
            onTap: () async {
              userNameController.text = '${userFirstNameController.text} '
                  '${userLastNameController.text} '
                  '${middleNameController.text}';

              if (filledSegments == 1) {
                if (userNameController.text.isNotEmpty) {
                  setState(() {
                    filledSegments = 2;
                    filledCount = 2;
                    title = 'Социальные сети';
                  });
                  return;
                } else {
                  AppSnackBar.show(
                    context,
                    'Заполните ссновную информацию *',
                    type: AppSnackType.error,
                  );
                }
              }

              if (filledSegments == 2) {
                if (nameController.text.isNotEmpty &&
                    socialNetworkController.text.isNotEmpty) {
                  setState(() {
                    filledSegments = 3;
                    filledCount = 3;
                    title = 'Юридический статус';
                  });
                  return;
                } else {
                  AppSnackBar.show(
                    context,
                    'Заполните социальные данные *',
                    type: AppSnackType.error,
                  );
                }
              }

              if (filledSegments == 3) {
                if (type != 0 && iinController.text.isNotEmpty) {
                  setState(() {
                    filledSegments = 4;
                    filledCount = 4;
                    title = 'Реквизиты банка';
                  });
                  return;
                } else {
                  AppSnackBar.show(
                    context,
                    'Заполните юридические данные *',
                    type: AppSnackType.error,
                  );
                }
              }

              if (filledSegments == 4) {
                if (checkController.text.isNotEmpty) {
                  setState(() {
                    filledSegments = 5;
                    filledCount = 5;
                    title = 'Контактные данные';
                  });
                  return;
                } else {
                  AppSnackBar.show(
                    context,
                    'Заполните реквизиты *',
                    type: AppSnackType.error,
                  );
                }
              }

              if (filledSegments == 5) {
                if (phoneController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty &&
                    isChecked == true &&
                    passwordController.text == repeatPasswordController.text) {
                  final data = RegisterBloggerDTO(
                      iin: iinController.text,
                      name: userNameController.text,
                      social_network: socialNetworkController.text,
                      phone: phoneController.text,
                      email: emailController.text,
                      nick_name: nameController.text,
                      password: passwordController.text,
                      check: checkController.text,
                      type: type);

                  final register = BlocProvider.of<LoginBloggerCubit>(context);

                  final statuCode = await register.register(data);

                  context.router.push(SuccessBloggerRegisterRoute());
                } else {
                  AppSnackBar.show(
                    context,
                    'Заполните контактные данные *',
                    type: AppSnackType.error,
                  );
                }
              }

              // Navigator.pop(context);
            },
            child: SizedBox(
                height: 100,
                child: Column(
                  children: [
                    Container(
                        height: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.mainPurpleColor,
                        ),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        // padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          filledSegments != 5 ? 'Далее' : 'Зарегистрироваться',
                          style: AppTextStyles.defaultButtonTextStyle
                              .copyWith(color: AppColors.kWhite),
                          textAlign: TextAlign.center,
                        )),
                    SizedBox(height: 12)
                  ],
                ))),
      ),

      //bottomSheet:  );
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

  const FieldsCoopRequest(
      {super.key,
      required this.hintText,
      required this.titleText,
      required this.star,
      required this.arrow,
      this.controller,
      this.onPressed,
      this.readOnly = false,
      this.number,
      this.trueColor = false,
      this.icon});

  @override
  Widget build(BuildContext context) {
    final bool tapMode = onPressed != null; // режим «нажатия», без клавиатуры

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
                  Text(titleText,
                      style: AppTextStyles.size13Weight500
                          .copyWith(color: Color(0xFF636366))),
                  if (!star)
                    const Text('*',
                        style: TextStyle(fontSize: 12, color: Colors.red)),
                ],
              ),
              const SizedBox(height: 4),

              // Поле
              Container(
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.kGray2,
                  borderRadius: BorderRadius.circular(16),
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
                    contentPadding: const EdgeInsets.all(
                      16,
                    ),
                    hintStyle: AppTextStyles.size16Weight400
                        .copyWith(color: Color(0xFF8E8E93)),
                    suffixIcon: arrow
                        ? Padding(
                            padding: EdgeInsets.only(
                                right:
                                    (icon != null && icon!.isNotEmpty) ? 0 : 8),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
