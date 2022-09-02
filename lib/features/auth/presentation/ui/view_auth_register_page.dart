import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/widgets/custom_back_button.dart';
import 'package:haji_market/features/app/widgets/custom_switch_button.dart';
import 'package:haji_market/features/auth/presentation/ui/auth_page.dart';
import 'package:haji_market/features/auth/presentation/ui/register_page.dart';

class ViewAuthRegisterPage extends StatefulWidget {
  const ViewAuthRegisterPage({Key? key}) : super(key: key);

  @override
  State<ViewAuthRegisterPage> createState() => _ViewAuthRegisterPageState();
}

class _ViewAuthRegisterPageState extends State<ViewAuthRegisterPage> {
  int segmentValue = 0;

  final List<bool> selectedBotton = [true, false];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
                      segmentValue = value;
                    }
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
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
        child: IndexedStack(
          index: segmentValue,
          children:const [
             AuthPage(),
             RegisterPage(),
            // ViewRegisterPage(),
            // AuthPage(),
          ],
        ),
      ),
    );
  }
}
