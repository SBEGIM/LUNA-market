import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/feature/bloger/auth/bloc/login_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/auth/bloc/login_blogger_state.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/bloger/coop_request/presentation/widget/show_blogger_register_type_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/metas_webview.dart';
import 'package:haji_market/src/feature/home/bloc/meta_cubit.dart' as metaCubit;
import 'package:haji_market/src/feature/home/bloc/meta_state.dart' as metaState;
import '../../../auth/data/DTO/register_blogger_dto.dart';

class BlogRegisterPage extends StatefulWidget {
  final Function(int status)? onTap;
  const BlogRegisterPage({Key? key, this.onTap}) : super(key: key);

  @override
  State<BlogRegisterPage> createState() => _BlogRegisterPageState();
}

class _BlogRegisterPageState extends State<BlogRegisterPage> {
  bool isChecked = false;

  TextEditingController userFirstNameController = TextEditingController();
  TextEditingController userLastNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController iinController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController =
      MaskedTextController(mask: '+7(000)-000-00-00');
  TextEditingController emailController = TextEditingController();
  TextEditingController socialNetworkController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController checkController = TextEditingController();

  @override
  void initState() {
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
  String title = "Оснавная информация";

  List<String> metasBody = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
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
                padding: EdgeInsets.only(top: 16, right: 26),
                child: SizedBox(
                  width: 300,
                  child: Text(
                    'Регистрация аккаунта\nблогера',
                    maxLines: 2,
                    style: AppTextStyles.size28Weight700,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0,
                      fontFamily: 'SFProDisplay',
                      color: AppColors.kGray300),
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

              SizedBox(height: 20),
              const SizedBox(
                height: 10,
              ),

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
                      FieldsCoopRequest(
                        titleText: 'Мобильный телефон ',
                        hintText: 'Введите мобильный телефон ',
                        star: false,
                        arrow: false,
                        number: true,
                        controller: phoneController,
                      ),
                      FieldsCoopRequest(
                        titleText: 'Email ',
                        hintText: 'Введите Email',
                        star: false,
                        arrow: false,
                        controller: emailController,
                      ),
                      FieldsCoopRequest(
                        titleText: 'Пароль ',
                        hintText: 'Введите пароль',
                        star: false,
                        arrow: false,
                        controller: passwordController,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Checkbox(
                              visualDensity: const VisualDensity(
                                  horizontal: 0, vertical: 0),
                              checkColor: Colors.white,
                              // fillColor: MaterialStateProperty.resolveWith(Colors.),
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
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
                                    text: const TextSpan(
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text:
                                              "Нажимая зарегистрироваться вы \nпринимаете ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        TextSpan(
                                          text: "Оферту для блогеров",
                                          style: TextStyle(
                                              color: AppColors.mainPurpleColor,
                                              fontSize: 14),
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
                        ],
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
                  Get.snackbar('Ошибка', 'Заполните основную информацию *',
                      backgroundColor: Colors.blueAccent);
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
                  Get.snackbar('Ошибка', 'Заполните юридические данные *',
                      backgroundColor: Colors.blueAccent);
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
                  Get.snackbar('Ошибка', 'Заполните реквизиты *',
                      backgroundColor: Colors.blueAccent);
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
                  Get.snackbar('Ошибка', 'Заполните контактные данные *',
                      backgroundColor: Colors.blueAccent);
                }
              }

              if (filledSegments == 5) {
                if (phoneController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty &&
                    isChecked == true) {
                  setState(() {
                    filledSegments = 6;
                    filledCount = 6;
                    title = 'Контактные данные';
                  });
                  return;
                } else {
                  Get.snackbar('Ошибка', 'Заполните контактные данные *',
                      backgroundColor: Colors.blueAccent);
                }
              }

              if (filledSegments == 5) {
                if (phoneController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty &&
                    isChecked == true) {
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

                  widget.onTap?.call(statuCode ?? 200);

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => BlogAuthRegisterPage()),
                  // );
                } else {
                  Get.snackbar('Ошибка', 'Заполните контактные данные *',
                      backgroundColor: Colors.blueAccent);
                }
              }

              // Navigator.pop(context);
            },
            child: SizedBox(
                height: 80,
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Container(
                        height: 46,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.mainPurpleColor,
                        ),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        // padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          filledSegments != 5
                              ? 'Продолжить'
                              : 'Зарегистрироваться',
                          style: AppTextStyles.defaultButtonTextStyle
                              .copyWith(color: AppColors.kWhite),
                          textAlign: TextAlign.center,
                        )),
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
  final bool readOnly;
  final bool? number;
  final bool trueColor;

  final void Function()? onPressed;

  TextEditingController? controller;
  FieldsCoopRequest({
    required this.hintText,
    required this.titleText,
    required this.star,
    required this.arrow,
    this.controller,
    this.onPressed,
    this.readOnly = false,
    this.number,
    this.trueColor = false,
    Key? key,
  }) : super(key: key);

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
                titleText,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    fontFamily: 'SFProDisplay',
                    letterSpacing: 0,
                    color: AppColors.kGray300),
              ),
              star != true
                  ? const Text(
                      '*',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.red),
                    )
                  : Container()
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            height: 47,
            padding: const EdgeInsets.only(left: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.kGray2,
                borderRadius: BorderRadius.circular(16)),
            child: TextField(
              readOnly: readOnly,
              keyboardType:
                  number == true ? TextInputType.number : TextInputType.text,
              controller: controller,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                    color: trueColor != false
                        ? Colors.black
                        : Color.fromRGBO(194, 197, 200, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  // borderRadius: BorderRadius.circular(3),
                ),
                suffixIcon: IconButton(
                  onPressed: onPressed,
                  icon: arrow == true
                      ? SvgPicture.asset('assets/icons/back_menu.svg',
                          color: Colors.grey)
                      : SizedBox.shrink(),
                ),
                // suffixIcon: IconButton(
                //     onPressed: () {},
                //     icon: SvgPicture.asset('assets/icons/back_menu.svg ',
                //         color: Colors.grey)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
