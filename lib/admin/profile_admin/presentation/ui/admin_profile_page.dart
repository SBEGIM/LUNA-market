import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/admin/profile_admin/presentation/widgets/about_shop_admin_page.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/auth/presentation/ui/view_auth_register_page.dart';

import '../widgets/reqirect_profile_page.dart';

class ProfileAdminPage extends StatefulWidget {
  ProfileAdminPage({Key? key}) : super(key: key);

  @override
  State<ProfileAdminPage> createState() => _ProfileAdminPageState();
}

class _ProfileAdminPageState extends State<ProfileAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios,
        //     color: AppColors.kPrimaryColor,
        //   ),
        // ),
        centerTitle: true,
        title: const Text(
          'Профиль продавца',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: SvgPicture.asset('assets/icons/notification.svg'))
        ],
      ),
      body: Column(
        children: [
          ListTile(
            horizontalTitleGap: 12,
            leading: CircleAvatar(
              backgroundImage: const AssetImage('assets/images/kana.png'),
              radius: 34,
              child: Align(
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset(
                  'assets/icons/camera.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: const Text(
              'Маржан Жумадилова',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.kGray900,
                  fontSize: 16),
            ),
            subtitle: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReqirectProfilePage()),
                );
              },
              child: const Text(
                'Редактирование',
                style: TextStyle(
                    color: AppColors.kPrimaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          // ListTile(
          //     leading: ClipOval(
          //       child: SizedBox(
          //         height: 60,
          //         width: 60,
          //         child: Image.asset(
          //           'assets/images/wireles.png',
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //     ),
          //     title: const Text(
          //       'Маржан Жумадилова',
          //       style: TextStyle(
          //         fontWeight: FontWeight.w400,
          //         color: AppColors.kGray900,
          //         fontSize: 15,
          //       ),
          //     ),
          // subtitle: InkWell(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => ReqirectProfilePage()),
          //     );
          //   },
          //   child: const Text(
          //     'Редактирование',
          //     style: TextStyle(
          //         color: AppColors.kPrimaryColor,
          //         fontSize: 14,
          //         fontWeight: FontWeight.w400),
          //   ),
          //     )),
          const Divider(
            color: AppColors.kGray400,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 15.0, bottom: 15, right: 15, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Связаться с администрацией',
                  style: TextStyle(
                      color: AppColors.kGray900,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.kGray300,
                )
              ],
            ),
          ),
          const Divider(
            color: AppColors.kGray400,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AbouShopAdminPage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, bottom: 15, right: 15, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'О нас',
                    style: TextStyle(
                        color: AppColors.kGray900,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppColors.kGray300,
                  )
                ],
              ),
            ),
          ),
          const Divider(
            color: AppColors.kGray400,
          ),
          GestureDetector(
            onTap: (){
              GetStorage().remove('token');
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ViewAuthRegisterPage()),
              );
            },
            child: Container(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Выйти',
                        style: TextStyle(
                            color: AppColors.kGray900,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: AppColors.kGray300,
                  )
                ],
              ),
            ),
          ),
          const Divider(
            color: AppColors.kGray400,
          ),
        ],
      ),
    );
  }
}
