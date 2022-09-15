import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/presentaion/base.dart';
import 'package:haji_market/features/auth/presentation/widgets/default_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/features/home/presentation/ui/home_page.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final maskFormatter = MaskTextInputFormatter(mask: '+#(###)-###-##-##');
  bool isChecked = false;
  bool isButtonEnabled = false;
  TextEditingController nameControllerRegister = TextEditingController();
  TextEditingController phoneControllerRegister = TextEditingController();
  TextEditingController passwordControllerRegister = TextEditingController();
  TextEditingController repePasswordControllerRegister =
      TextEditingController();
  setIsButtonEnabled(bool value) {
    // log("is button state changed $value");
    isButtonEnabled = value;
    setState(() {});
  }
  FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 45),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                ListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/user.svg',
                    height: 24,
                    width: 24,
                  ),
                  title: TextField(
                    focusNode: myFocusNode,
                    controller: nameControllerRegister,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Имя и фамилия',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        // borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    onChanged: (value) {
                      if (nameControllerRegister.text.isNotEmpty) {
                        setIsButtonEnabled(true);
                      } else {
                        setIsButtonEnabled(false);
                      }
                    },
                  ),
                  // trailing: SvgPicture.asset(
                  //   'assets/icons/delete_circle.svg',
                  //   height: 24,
                  //   width: 24,
                  // ),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/phone.svg',
                    height: 24,
                    width: 24,
                  ),
                  title: TextField(
                    focusNode: myFocusNode,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [maskFormatter],
                    controller: phoneControllerRegister,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Номер телефона',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        // borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    onChanged: (value) {
                      if (phoneControllerRegister.text.length == 17) {
                        setIsButtonEnabled(true);
                      } else {
                        setIsButtonEnabled(false);
                      }
                    },
                  ),
                  trailing: SvgPicture.asset(
                    'assets/icons/delete_circle.svg',
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/password.svg',
                    height: 24,
                    width: 24,
                  ),
                  title: TextField(
                    // inputFormatters: [maskFormatter],
                    controller: passwordControllerRegister,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Пароль',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        // borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    onChanged: (value) {
                      if (passwordControllerRegister.text.isNotEmpty) {
                        setIsButtonEnabled(true);
                      } else {
                        setIsButtonEnabled(false);
                      }
                    },
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    'assets/icons/password.svg',
                    height: 24,
                    width: 24,
                  ),
                  title: TextField(
                    // inputFormatters: [maskFormatter],
                    controller: repePasswordControllerRegister,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Подтвердите пароль',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        // borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    onChanged: (value) {
                      if (passwordControllerRegister.text ==
                          repePasswordControllerRegister.text) {
                        setIsButtonEnabled(true);
                      } else {
                        setIsButtonEnabled(false);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  // fillColor: MaterialStateProperty.resolveWith(Colors.),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                const Flexible(
                  child: Text(
                    textAlign: TextAlign.center,
                    'Регистрируясь, вы соглашаетесь с пользовательским соглашением',
                    style: TextStyle(
                        color: AppColors.kGray900,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
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
backgroundColor: isButtonEnabled? AppColors.kPrimaryColor: const Color(0xFFD6D8DB),
                text: 'Зарегистрироваться',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>const  Base()),
                  );
                },
                color: Colors.white,
                width: 343),
          ),
        ],
      ),

      // SizedBox(height: 20,),
    );
  }
}
