import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/admin/admin_app/presentation/base_admin.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/auth/presentation/widgets/default_button.dart';

import '../../../../features/app/widgets/custom_back_button.dart';

class RegisterShopPage extends StatefulWidget {
  RegisterShopPage({Key? key}) : super(key: key);

  @override
  State<RegisterShopPage> createState() => _RegisterShopPageState();
}

class _RegisterShopPageState extends State<RegisterShopPage> {
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
          'Регистрация магазина',
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
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  color: Colors.white,
                  child: Stack(
                    children: [
                      SvgPicture.asset('assets/icons/border.svg'),
                      Center(
                          child: SvgPicture.asset('assets/icons/camera2.svg')
                      ),
                    ],
                  )
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'ЗАГРУЗИТЬ ЛОГОТИП',
                  style: TextStyle(
                      color: AppColors.kPrimaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: SvgPicture.asset(
                  'assets/icons/shop1.svg',
                  height: 24,
                  width: 24,
                  color: const Color.fromRGBO(28,189,199,1),
                ),
                minLeadingWidth: 10,
                title: const TextField(
                  // controller: phoneControllerAuth,
                  cursorColor: Color.fromRGBO(31,196,207, 1),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Название магазина',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(170,174,179,1)
                    ) ,
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
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom * 0.01,
            ),
            child: DefaultButton(
              backgroundColor: AppColors.kPrimaryColor,
                text: 'Войти',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BaseAdmin()),
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
