import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/seller/auth/bloc/sms_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/auth/bloc/sms_seller_state.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/widgets/custom_back_button.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:haji_market/src/feature/seller/auth/presentation/ui/login_seller_page.dart';

@RoutePage()
class ChangePasswordSellerPage extends StatefulWidget {
  final String textEditingController;
  const ChangePasswordSellerPage({
    super.key,
    required this.textEditingController,
  });

  @override
  State<ChangePasswordSellerPage> createState() =>
      _ChangePasswordSellerPageState();
}

class _ChangePasswordSellerPageState extends State<ChangePasswordSellerPage> {
  TextEditingController passwordNew = TextEditingController();
  TextEditingController passwordRepeat = TextEditingController();

  bool _visibleIconView = false;
  bool _visibleIconViewRepeat = false;
  bool _passwordVisible = false;

  void test() {
    log("11 ${widget.textEditingController}");
  }

  @override
  void initState() {
    test();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            Navigator.pop(context);
          }),
        ),
      ),
      body: BlocConsumer<SmsSellerCubit, SmsSellerState>(
          listener: (context, state) {
        if (state is ResetSuccessState) {
          // Get.offAll(() => const LoginAdminPage());
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const AdminAuthPage()),
          // );
          context.router.popUntil(
            (route) => route.settings.name == AuthSellerRoute.name,
          );
        }
      }, builder: (context, state) {
        if (state is InitState) {
          return Container(
            color: AppColors.kBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, top: 16, bottom: 45),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Создайте новый пароль',
                    style: AppTextStyles.defaultAppBarTextStyle,
                  ),
                  SizedBox(height: 16),
                  FieldsCoopRequest(
                    titleText: 'Новый пароль',
                    hintText: 'Введите новый пароль',
                    star: false,
                    controller: passwordNew,
                    arrow: _visibleIconView,
                    onChanged: (value) {
                      setState(() {});
                    },
                    onPressed: () {
                      _visibleIconView = !_visibleIconView;
                      setState(() {});
                    },
                  ),
                  FieldsCoopRequest(
                    titleText: 'Повторите пароль',
                    hintText: 'Повторите новый пароль',
                    star: false,
                    arrow: _visibleIconViewRepeat,
                    onChanged: (value) {
                      setState(() {});
                    },
                    onPressed: () {
                      _visibleIconViewRepeat = !_visibleIconViewRepeat;
                      setState(() {});
                    },
                    controller: passwordRepeat,
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom * 0.001,
                    ),
                    child: DefaultButton(
                        backgroundColor: passwordNew.text == passwordRepeat.text
                            ? AppColors.mainPurpleColor
                            : AppColors.mainBackgroundPurpleColor,
                        text: 'Готово',
                        press: () {
                          if (passwordNew.text == passwordRepeat.text) {
                            final sms =
                                BlocProvider.of<SmsSellerCubit>(context);
                            sms.passwordReset(widget.textEditingController,
                                passwordRepeat.text);
                          } else {
                            Get.snackbar('Ошибка', 'Пароли не совпадают',
                                backgroundColor: Colors.blueAccent);
                          }
                        },
                        color: Colors.white,
                        width: double.infinity),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is ErrorState) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.redAccent),
            ),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(color: Colors.indigoAccent));
        }
      }),
    );
  }
}

class FieldsCoopRequest extends StatelessWidget {
  final String titleText;
  final String hintText;
  final bool star;
  final bool arrow;
  final void Function()? onPressed;
  final void Function(String)? onChanged;

  TextEditingController? controller;
  FieldsCoopRequest({
    required this.hintText,
    required this.titleText,
    required this.star,
    required this.arrow,
    this.controller,
    this.onPressed,
    required this.onChanged,
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
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColors.kGray900),
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
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: TextField(
              obscureText: arrow,
              keyboardType: TextInputType.text,
              controller: controller,
              textAlign: TextAlign.left,
              onChanged: onChanged,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(
                    color: Color.fromRGBO(194, 197, 200, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  // borderRadius: BorderRadius.circular(3),
                ),
                suffixIcon: IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    arrow != true ? Icons.visibility : Icons.visibility_off,
                    color: const Color.fromRGBO(177, 179, 181, 1),
                  ),
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
