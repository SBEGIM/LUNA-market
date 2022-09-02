import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/auth/presentation/ui/forgot_password.dart';
import 'package:haji_market/features/auth/presentation/widgets/default_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/features/home/presentation/ui/home_page.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final maskFormatter = MaskTextInputFormatter(mask: '+#(###)-###-##-##');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 45),
      child: Column(
        children: [
          Column(
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
                        // controller: phoneControllerAuth,
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
                    ListTile(
                      leading: SvgPicture.asset(
                        'assets/icons/password.svg',
                        height: 24,
                        width: 24,
                      ),
                      title: const TextField(
                        keyboardType: TextInputType.phone,
                        // inputFormatters: [maskFormatter],
                        // controller: phoneControllerAuth,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Введите пароль',
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
              InkWell(
                onTap: (){
                   Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
  );
                },
                child: const Center(
                  child: Text(
                    'Забыли пароль?',
                    style: TextStyle(
                        color: AppColors.kPrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: DefaultButton(
                text: 'Войти', press: () {
                     Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const HomePage()),
  );
                }, color: Colors.white, width: 343),
          ),
        ],
      ),
    );
  }
}
