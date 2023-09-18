import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/bloger/auth/data/bloc/login_blogger_cubit.dart';
import 'package:haji_market/bloger/auth/data/bloc/login_blogger_state.dart';
import 'package:haji_market/core/common/constants.dart';
import '../../../../offer_for_the_seller.dart';
import '../../../auth/data/DTO/register_blogger_dto.dart';

class BlogRequestPage extends StatefulWidget {
  final Function()? onTap;
  const BlogRequestPage({Key? key, this.onTap}) : super(key: key);

  @override
  State<BlogRequestPage> createState() => _BlogRequestPageState();
}

class _BlogRequestPageState extends State<BlogRequestPage> {
  bool isChecked = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController iinController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = MaskedTextController(mask: '+7(000)-000-00-00');
  TextEditingController emailController = TextEditingController();
  TextEditingController socialNetworkController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController checkController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.kBackgroundColor,
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
      body: BlocConsumer<LoginBloggerCubit, LoginBloggerState>(listener: (context, state) {
        if (state is LoadedState) {}
      }, builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.indigoAccent),
          );
        }
        return Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: ListView(
            shrinkWrap: true,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Укажите данные ип или физ.лица',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.kGray900),
              ),
              const SizedBox(
                height: 10,
              ),
              FieldsCoopRequest(
                titleText: 'ИИН',
                hintText: 'Введите инн',
                star: false,
                arrow: false,
                controller: iinController,
              ),
              FieldsCoopRequest(
                titleText: 'Никнейм блогера',
                hintText: 'Введите никнейм блогера',
                star: false,
                arrow: false,
                controller: nameController,
              ),
              FieldsCoopRequest(
                titleText: 'ФИО',
                hintText: 'Введите ФИО',
                star: false,
                arrow: false,
                controller: userNameController,
              ),
              FieldsCoopRequest(
                titleText: 'Счет',
                hintText: 'Введите счет',
                star: false,
                arrow: false,
                controller: checkController,
              ),
              FieldsCoopRequest(
                titleText: 'Ссылка на соц сеть',
                hintText: 'Введите ссылку на соц сеть',
                star: false,
                arrow: false,
                controller: socialNetworkController,
              ),
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
                  GestureDetector(
                    onTap: () {
                      Get.to(const OfferForTheSeller());
                    },
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: const TextSpan(
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: "принимаю ",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                              text: "Оферту для блогеров",
                              style: TextStyle(color: AppColors.kPrimaryColor, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100)
            ],
          ),
        );
      }),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: InkWell(
            onTap: () async {
              if (socialNetworkController.text.isNotEmpty &&
                  iinController.text.isNotEmpty &&
                  nameController.text.isNotEmpty &&
                  phoneController.text.isNotEmpty &&
                  emailController.text.isNotEmpty &&
                  userNameController.text.isNotEmpty &&
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
                    check: checkController.text);

                final register = BlocProvider.of<LoginBloggerCubit>(context);

                await register.register(data);
                widget.onTap?.call();

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => BlogAuthRegisterPage()),
                // );
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

      //bottomSheet:  );
    );
  }
}

class FieldsCoopRequest extends StatelessWidget {
  final String titleText;
  final String hintText;
  final bool star;
  final bool arrow;
  final bool? number;

  final void Function()? onPressed;

  TextEditingController? controller;
  FieldsCoopRequest({
    required this.hintText,
    required this.titleText,
    required this.star,
    required this.arrow,
    this.controller,
    this.onPressed,
    this.number,
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
              keyboardType: number == true ? TextInputType.number : TextInputType.text,
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
