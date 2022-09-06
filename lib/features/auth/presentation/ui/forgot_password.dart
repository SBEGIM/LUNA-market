import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/widgets/custom_back_button.dart';

import 'package:haji_market/features/auth/presentation/widgets/default_button.dart';
import 'package:haji_market/features/auth/presentation/widgets/forget_password_modal_bottom.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final maskFormatter = MaskTextInputFormatter(mask: '+#(###)-###-##-##');
  TextEditingController phoneControllerAuth = TextEditingController();
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22.0),
            child: CustomDropButton(
              onTap: () {},
            ),
          ),
        ],
      ),
      body: Container(
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
                        'assets/icons/phone.svg',
                        height: 24,
                        width: 24,
                      ),
                      title: TextField(
                        keyboardType: TextInputType.phone,
                        inputFormatters: [maskFormatter],
                        controller: phoneControllerAuth,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '+7(777) 777-71-18',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            // borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                      trailing: SvgPicture.asset(
                        'assets/icons/delete_circle.svg',
                        height: 24,
                        width: 24,
                      ),
                    ),
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
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                          ),
                          context: context,
                          builder: (context) {
                            return ForgotPasswordModalBottom(
                              textEditingController: phoneControllerAuth.text,
                            );
                          });
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const ChangePasswordPage()),
                      // );
                    },
                    color: Colors.white,
                    width: 343),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
