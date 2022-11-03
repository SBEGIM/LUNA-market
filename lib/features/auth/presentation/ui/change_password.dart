import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/widgets/custom_back_button.dart';
import 'package:haji_market/features/auth/data/bloc/sms_state.dart';
import 'package:haji_market/features/auth/presentation/ui/view_auth_register_page.dart';
import 'package:haji_market/features/auth/presentation/widgets/default_button.dart';
import 'package:haji_market/features/home/presentation/ui/home_page.dart';

import '../../data/bloc/sms_cubit.dart';

class ChangePasswordPage extends StatefulWidget {

  final String textEditingController;
  const ChangePasswordPage({Key? key ,required this.textEditingController,})
: super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  TextEditingController passwordNew = TextEditingController();
  TextEditingController passwordRepeat = TextEditingController();

 void test(){
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
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Изменить пароль',
          style: AppTextStyles.appBarTextStyle,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            Navigator.pop(context);
          }),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22.0),
            child: CustomDropButton(
              onTap: () {},
            ),
          ),
        ],
      ),
      body: BlocConsumer<SmsCubit, SmsState>(listener: (context, state) {
        if (state is ResetSuccessState) {
          Get.offAll(() => new  ViewAuthRegisterPage());
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Base()),
          // );
        }
      }, builder: (context, state) {
        if (state is InitState) {
          return Container(
            color: AppColors.kBackgroundColor,
            child: Padding(
              padding:
              const EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 45),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        ListTile(
                          leading: SvgPicture.asset(
                            'assets/icons/password.svg',
                            height: 24,
                            width: 24,
                          ),
                          title:  TextField(
                            // inputFormatters: [maskFormatter],
                            controller: passwordNew,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: ' Пароль',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                // borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: SvgPicture.asset(
                            'assets/icons/password.svg',
                            height: 24,
                            width: 24,
                          ),
                          title:  TextField(
                            // inputFormatters: [maskFormatter],
                            controller: passwordRepeat,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Подтвердите пароль',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                // borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Для смены пароля введите новый пароль, а затем подтвердите',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom * 0.001,
                    ),
                    child: DefaultButton(
                        backgroundColor: AppColors.kPrimaryColor,
                        text: 'Изменить пароль',
                        press: () {
                          log(widget.textEditingController);
                          log('1111');
                          final sms = BlocProvider.of<SmsCubit>(context);
                          sms.passwordReset(widget.textEditingController,passwordRepeat.text);
                        },
                        color: Colors.white,
                        width: 343),
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
              style: TextStyle(color: Colors.redAccent),
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
