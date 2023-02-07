import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:haji_market/bloger/auth/presentation/ui/auth_page.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/presentaion/base.dart';
import 'package:haji_market/features/app/widgets/custom_back_button.dart';
import 'package:haji_market/features/app/widgets/custom_switch_button.dart';
import 'package:haji_market/features/auth/presentation/ui/auth_page.dart';
import 'package:haji_market/features/auth/presentation/ui/register_page.dart';

import '../../../../bloger/auth/presentation/ui/login_admin_page.dart';
import '../../../coop_request/presentation/ui/coop_request_page.dart';

class AdminAuthPage extends StatefulWidget {
  final bool? BackButton;
  const AdminAuthPage({this.BackButton, Key? key}) : super(key: key);

  @override
  State<AdminAuthPage> createState() => _AdminAuthPageState();
}

class _AdminAuthPageState extends State<AdminAuthPage> {
  int segmentValue = 0;

  final List<bool> selectedBotton = [true, false];
  int currentIndex = 0;
  String title = 'Войти в кабинет продавца';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: AppTextStyles.appBarTextStyle,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            Get.to(() => const Base(index: 0));
          }),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Column(
            children: [
              Container(
                height: 12,
                color: AppColors.kBackgroundColor,
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 8,
                  left: 16,
                  bottom: 8,
                  right: 16,
                  // right: screenSize.height * 0.016,
                ),
                child: CustomSwitchButton<int>(
                  groupValue: segmentValue,
                  children: {
                    0: Container(
                      alignment: Alignment.center,
                      height: 39,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Вход',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: segmentValue == 0
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: segmentValue == 0
                              ? Colors.black
                              : const Color(0xff9B9B9B),
                        ),
                      ),
                    ),
                    1: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      height: 39,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Регистрация',
                        style: TextStyle(
                          fontWeight: segmentValue == 1
                              ? FontWeight.w700
                              : FontWeight.w500,
                          fontSize: 14,
                          color: segmentValue == 1
                              ? Colors.black
                              : const Color(0xff9B9B9B),
                        ),
                      ),
                    ),
                  },
                  onValueChanged: (int? value) async {
                    if (value != null) {
                      value == 0
                          ? (title = 'Войти в кабинет продавца')
                          : (title = 'Заявка на содрудничество');
                      segmentValue = value;
                    }
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 22.0),
        //     child: SvgPicture.asset('assets/icons/cancel.svg'),
        //     // child: Ico(
        //     //   onTap: () {},
        //     // ),
        //   ),
        // ],
      ),
      body: Container(
        color: AppColors.kBackgroundColor,
        child: IndexedStack(
          index: segmentValue,
          children: [
            LoginAdminPage(),
            CoopRequestPage()
            // const BlogAuthPage(),
            // BlogRequestPage(),
            // ViewRegisterPage(),
            // AuthPage(),
          ],
        ),
      ),
    );
  }
}
