import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/admin/auth/data/DTO/register_admin_dto.dart';
import 'package:haji_market/admin/auth/data/bloc/register_admin_cubit.dart';
import 'package:haji_market/admin/auth/presentation/ui/auth_admin_page.dart';

import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/router/app_router.dart';
import 'package:haji_market/features/drawer/presentation/widgets/metas_webview.dart';
import 'package:haji_market/features/home/data/bloc/meta_cubit.dart' as metaCubit;
import 'package:haji_market/features/home/data/bloc/meta_state.dart' as metaState;
import '../../../../features/home/data/model/Cats.dart';
import '../../../../oferta.dart';
import '../../../../politic.dart';
import '../../../my_products_admin/presentation/widgets/cats_admin_page.dart';

class CoopRequestPage extends StatefulWidget {
  const CoopRequestPage({Key? key}) : super(key: key);

  @override
  State<CoopRequestPage> createState() => _CoopRequestPageState();
}

class _CoopRequestPageState extends State<CoopRequestPage> {
  bool isChecked = false;
  bool typeOrganization = false;

  Cats cats = Cats(id: 0, name: 'Выберите категорию');

  TextEditingController iinController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController checkController = TextEditingController();
  TextEditingController catController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = MaskedTextController(mask: '+7(000)-000-00-00');
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<String> metas = [
    'Пользовательское соглашение',
    'Оферта для продавцов',
    'Политика конфиденциальности',
    'Типовой договор купли-продажи',
    'Типовой договор на оказание рекламных услуг'
  ];

  List<String> metasBody = [];
  @override
  void initState() {
    if (BlocProvider.of<metaCubit.MetaCubit>(context).state is! metaState.LoadedState) {
      BlocProvider.of<metaCubit.MetaCubit>(context).partners();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      backgroundColor: AppColors.kBackgroundColor,
      // appBar: AppBar(
      //     iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
      //     backgroundColor: Colors.white,
      //     elevation: 0,
      //     centerTitle: true,
      //     title: const Text(
      //       'Заявка на сотрудничество',
      //       style: TextStyle(
      //         color: Colors.black,
      //         fontSize: 16,
      //         fontWeight: FontWeight.w500,
      //       ),
      //     )),
      body: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
        child: ListView(
            shrinkWrap: true,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Укажите данные Вашего бизнеса',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.kGray900),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    'Выберите тип организаций ',
                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.kGray900),
                  ),
                  Text(
                    '*',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.red),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: 168,
                    height: 47,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      const Text(
                        'ИП',
                        textAlign: TextAlign.center,
                      ),
                      Checkbox(
                        shape: const CircleBorder(),
                        value: !typeOrganization,
                        activeColor: AppColors.kPrimaryColor,
                        onChanged: ((value) {
                          typeOrganization = !typeOrganization;
                          setState(() {});
                        }),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: 168,
                    height: 47,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      const Text(
                        'OОО',
                        textAlign: TextAlign.center,
                      ),
                      Checkbox(
                        value: typeOrganization,
                        shape: const CircleBorder(),
                        activeColor: AppColors.kPrimaryColor,
                        onChanged: ((value) {
                          typeOrganization = !typeOrganization;
                          setState(() {});
                        }),
                      ),
                    ]),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FieldsCoopRequest(
                titleText: 'ИНН ',
                hintText: 'Введите ИНН',
                star: false,
                arrow: false,
                controller: iinController,
              ),
              FieldsCoopRequest(
                titleText: 'Название компании или ИП ',
                hintText: 'Введите название компании',
                star: false,
                arrow: false,
                controller: userNameController,
              ),
              FieldsCoopRequest(
                titleText: 'Название магазина',
                hintText: 'Введите название магазина',
                star: false,
                arrow: false,
                controller: nameController,
              ),
              FieldsCoopRequest(
                titleText: 'Счёт',
                hintText: 'Введите счёт',
                star: false,
                arrow: false,
                controller: checkController,
              ),
              FieldsCoopRequest(
                titleText: 'Основная категория товаров ',
                hintText: cats.name.toString(),
                star: false,
                arrow: true,
                // controller: catController,
                onPressed: () async {
                  final data = await Get.to(const CatsAdminPage());
                  if (data != null) {
                    final Cats cat = data;

                    setState(() {});
                    catController.text = cat.id.toString();
                    cats = cat;
                  }
                },
              ),
              FieldsCoopRequest(
                titleText: 'Контактное имя ',
                hintText: 'Введите контактное имя',
                star: false,
                arrow: false,
                controller: contactController,
              ),
              FieldsCoopRequest(
                titleText: 'Мобильный телефон ',
                hintText: 'Введите мобильный телефон ',
                star: false,
                arrow: false,
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
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 150,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Checkbox(
                        visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
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
                    BlocBuilder<metaCubit.MetaCubit, metaState.MetaState>(builder: (context, state) {
                      if (state is metaState.LoadedState) {
                        metasBody.addAll([
                          state.metas.terms_of_use!,
                          state.metas.privacy_policy!,
                          state.metas.contract_offer!,
                          state.metas.shipping_payment!,
                          state.metas.TTN!,
                        ]);
                        return Container(
                          alignment: Alignment.topRight,
                          child: RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              style: const TextStyle(fontSize: 16, color: Colors.black),
                              children: <TextSpan>[
                                const TextSpan(
                                  text: "принимаю ",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.to(() => MetasPage(
                                          title: metas[0],
                                          body: metasBody[0],
                                        )),
                                  text: 'Пользовательское \nсоглашение ',
                                  style: const TextStyle(
                                      color: AppColors.kPrimaryColor, fontSize: 16, fontWeight: FontWeight.w400),
                                ),
                                const TextSpan(
                                  text: "и даю согласие  на  обработку \nперсональных ",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                ),
                                const TextSpan(
                                  text: "данных в  соответсвии \nс ",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.to(() => MetasPage(
                                          title: metas[2],
                                          body: metasBody[2],
                                        )),
                                  text: 'Политикой  Конфиденциальности',
                                  style: const TextStyle(
                                      color: AppColors.kPrimaryColor, fontSize: 16, fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Center();
                      }
                    }),
                  ],
                ),
              ),
            ]),
      ),

      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: InkWell(
            onTap: () async {
              if (iinController.text.isNotEmpty &&
                  nameController.text.isNotEmpty &&
                  phoneController.text.length == 17 &&
                  emailController.text.isNotEmpty &&
                  userNameController.text.isNotEmpty &&
                  catController.text.isNotEmpty &&
                  checkController.text.isNotEmpty &&
                  isChecked == true) {
                final RegisterAdminDTO registerDto = RegisterAdminDTO(
                    catName: catController.text,
                    name: nameController.text,
                    email: emailController.text,
                    phone: phoneController.text,
                    password: passwordController.text,
                    iin: iinController.text,
                    userName: userNameController.text,
                    check: checkController.text,
                    typeOrganization: typeOrganization);

                await BlocProvider.of<RegisterAdminCubit>(context).register(registerDto);
                if (!mounted) return;
                context.router.push(AdminAuthRoute());
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AuthAdminPage()),
                // );
                Get.snackbar('Успешно', 'Заявка отправлено', backgroundColor: Colors.blueAccent);
              } else {
                Get.snackbar('Ошибка', 'Заполните все данные *', backgroundColor: Colors.blueAccent);
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
                          color: AppColors.kPrimaryColor,
                        ),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        // padding: const EdgeInsets.only(left: 16, right: 16),
                        child: const Text(
                          'Продолжить',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
                          textAlign: TextAlign.center,
                        )),
                  ],
                ))),
      ),
    );

    //  bottomSheet: );
  }
}

class FieldsCoopRequest extends StatelessWidget {
  final String titleText;
  final String hintText;
  final bool star;
  final bool arrow;
  final void Function()? onPressed;

  TextEditingController? controller;
  FieldsCoopRequest({
    required this.hintText,
    required this.titleText,
    required this.star,
    required this.arrow,
    this.controller,
    this.onPressed,
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
                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.kGray900),
              ),
              star != true
                  ? const Text(
                      '*',
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.red),
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
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: TextField(
              keyboardType: TextInputType.text,
              controller: controller,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle:
                    const TextStyle(color: Color.fromRGBO(194, 197, 200, 1), fontSize: 16, fontWeight: FontWeight.w400),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  // borderRadius: BorderRadius.circular(3),
                ),
                suffixIcon: IconButton(
                  onPressed: onPressed,
                  icon: arrow == true
                      ? SvgPicture.asset('assets/icons/back_menu.svg', color: Colors.grey)
                      : SvgPicture.asset(''),
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
