import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/admin/auth/presentation/ui/register_shop_page.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/widgets/custom_back_button.dart';
import 'package:haji_market/features/auth/presentation/widgets/default_button.dart';

class AuthAdminPage extends StatefulWidget {
  AuthAdminPage({Key? key}) : super(key: key);

  @override
  State<AuthAdminPage> createState() => _AuthAdminPageState();
}

class _AuthAdminPageState extends State<AuthAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22.0),
            child: CustomDropButton(
              onTap: () {},
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Вход',
          style: AppTextStyles.appBarTextStyle,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            Navigator.pop(context);
          }),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/icons/phone.svg',
                      height: 24,
                      width: 24,
                    ),
                    title: const TextField(
                      // controller: phoneControllerAuth,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Ваш логин',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          // borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    // trailing: SvgPicture.asset(
                    //   'assets/icons/delete_circle.svg',
                    //   height: 24,
                    //   width: 24,
                    // ),
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
          ),
          const SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () {
              //                  Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
              // );
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
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom * 0.01,
            ),
            child: DefaultButton(
                text: 'Войти',
                press: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterShopPage()),
                  );
                  //                    Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const HomePage()),
                  // );
                },
                color: Colors.white,
                width: 343),
          ),
          const SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }
}
