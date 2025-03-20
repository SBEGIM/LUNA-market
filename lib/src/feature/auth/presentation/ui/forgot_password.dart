import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/widgets/custom_back_button.dart';
import 'package:haji_market/src/feature/auth/data/bloc/sms_state.dart';

import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';

import '../../data/bloc/sms_cubit.dart';
import '../widgets/login_forget_password_modal_bottom.dart';

@RoutePage()
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController phoneControllerAuth =
      MaskedTextController(mask: '+7(000)-000-00-00');

  bool _visibleIconView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Восстановление пароля',
          style: AppTextStyles.appBarTextStyle,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            Navigator.pop(context);
          }),
        ),
      ),
      body: BlocConsumer<SmsCubit, SmsState>(listener: (context, state) {
        if (state is LoadedState) {
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0)),
              ),
              context: context,
              builder: (context) {
                return LoginForgotPasswordModalBottom(
                  textEditingController: phoneControllerAuth.text,
                );
              });
        }
      }, builder: (context, state) {
        if (state is InitState) {
          return Container(
            color: AppColors.kBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16, top: 16, bottom: 45),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        ListTile(
                            horizontalTitleGap: 5,
                            leading: SvgPicture.asset(
                              'assets/icons/phone.svg',
                              height: 24,
                              width: 24,
                            ),
                            title: TextField(
                              keyboardType: TextInputType.phone,
                              // inputFormatters: [maskFormatter],
                              controller: phoneControllerAuth,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Номер телефона',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  // borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              onChanged: (value) {
                                phoneControllerAuth.text.length.toInt() != 0
                                    ? _visibleIconView = true
                                    : _visibleIconView = false;
                                setState(() {});
                              },
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                phoneControllerAuth.clear();
                                _visibleIconView = false;
                                setState(() {});
                              },
                              child: _visibleIconView == true
                                  ? SvgPicture.asset(
                                      'assets/icons/delete_circle.svg',
                                      height: 15,
                                      width: 15,
                                    )
                                  : const SizedBox(width: 5),
                            )),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom * 0.001,
                    ),
                    child: DefaultButton(
                        backgroundColor: AppColors.kPrimaryColor,
                        text: 'Отправить код',
                        press: () {
                          if (phoneControllerAuth.text.length >= 17) {
                            final sms = BlocProvider.of<SmsCubit>(context);
                            sms.resetSend(phoneControllerAuth.text);
                          } else {
                            Get.snackbar('Номер телефона пустой', 'Заполните',
                                backgroundColor: Colors.blueAccent);
                          }
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
