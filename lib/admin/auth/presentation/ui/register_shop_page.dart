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
                  color: Colors.white,
                  height: 120,
                  width: 120,
                  child: const Center(
                    child: Icon(
                      Icons.camera_alt,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Загрузить аватарку',
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
                  'assets/icons/store.svg',
                  height: 24,
                  width: 24,
                ),
                title: const TextField(
                  // controller: phoneControllerAuth,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Название магазина',
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
