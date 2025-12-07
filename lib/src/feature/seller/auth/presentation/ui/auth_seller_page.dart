import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/seller/auth/presentation/ui/login_seller_page.dart';

@RoutePage()
class AuthSellerPage extends StatelessWidget {
  const AuthSellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,

        appBar: AppBar(
          toolbarHeight: 20,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image.asset(Assets.icons.defaultBackIcon.path, scale: 2.1),
          ),
        ),
        body: LoginSellerPage(),
      ),
    );
  }
}
