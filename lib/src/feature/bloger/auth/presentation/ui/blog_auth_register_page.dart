import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/bloger/auth/presentation/ui/blog_auth_page.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/widgets/custom_back_button.dart';
import 'package:haji_market/src/feature/app/widgets/custom_switch_button.dart';
import '../../../coop_request/presentation/ui/blogger_register_page.dart';

@RoutePage()
class BlogAuthRegisterPage extends StatefulWidget {
  final bool? BackButton;
  const BlogAuthRegisterPage({this.BackButton, Key? key}) : super(key: key);

  @override
  State<BlogAuthRegisterPage> createState() => _BlogAuthRegisterPageState();
}

class _BlogAuthRegisterPageState extends State<BlogAuthRegisterPage> {
  int segmentValue = 0;

  final List<bool> selectedBotton = [true, false];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.kWhite,
        appBar: AppBar(
          toolbarHeight: 18,
          backgroundColor: Colors.white,
          leading: InkWell(
            onTap: () {
              context.router.pop();
            },
            child: Image.asset(Assets.icons.defaultBackIcon.path, scale: 1.9),
          ),
        ),
        body: BlogAuthPage(),
      ),
    );
  }
}
