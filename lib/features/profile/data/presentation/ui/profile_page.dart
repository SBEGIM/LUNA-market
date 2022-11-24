import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/widgets/custom_back_button.dart';
import 'package:haji_market/features/profile/data/presentation/ui/edit_profile_page.dart';
import 'package:haji_market/features/profile/data/presentation/ui/my_bank_card_page.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../auth/presentation/ui/auth_page.dart';
import '../../../../auth/presentation/ui/view_auth_register_page.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isSwitchedPush = false;
  bool isSwitchedTouch = false;
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  bool change = false;

  Future<void> _getImage() async {
    final image = change == true
        ? await _picker.pickImage(source: ImageSource.camera)
        : await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  final _box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            Navigator.pop(context);
          }),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Профиль',
          style: TextStyle(
              color: AppColors.kGray900,
              fontSize: 16,
              fontWeight: FontWeight.w500),
        ),
        elevation: 0,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: SvgPicture.asset('assets/icons/notification.svg'))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 98,
            child: Center(
              child: ListTile(
                horizontalTitleGap: 12,
                leading: GestureDetector(
                  onTap: () {
                    Get.defaultDialog(
                        title: "Изменить фото",
                        middleText: '',
                        textConfirm: 'Камера',
                        textCancel: 'Галлерея',
                        titlePadding: EdgeInsets.only(top: 40),
                        onConfirm: () {
                          change = true;
                          setState(() {
                            change;
                          });
                          _getImage();
                        },
                        onCancel: () {
                          change = false;
                          setState(() {
                            change;
                          });
                          _getImage();
                        });
                  },
                  child: _image != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(
                            File(_image!.path),
                          ),
                          radius: 34,
                          child: Container())
                      : Container(
                          height: 54,
                          width: 54,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(34),
                              image: DecorationImage(
                                image: _box.read('avatar') != null
                                    ? NetworkImage(
                                        "http://80.87.202.73:8001/storage/${_box.read('avatar')}")
                                    : AssetImage('assets/icons/profile2.png')
                                        as ImageProvider,
                                fit: BoxFit.cover,
                              )),
                        ),

                  // CircleAvatar(
                  //   backgroundImage: const AssetImage('assets/images/kana.png'),
                  //   radius: 34,
                  //   child: Align(
                  //           alignment: Alignment.bottomRight,
                  //           child: SvgPicture.asset(
                  //           'assets/icons/camera.svg',
                  //           fit: BoxFit.cover,
                  //           ),
                  //           ),
                  //           ) ,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _box.read('name'),
                      style: const TextStyle(
                          color: AppColors.kGray700,
                          fontSize: 17,
                          fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                        onTap: () => Get.to(EditProfilePage(
                              name: _box.read('name'),
                            )),
                        child: SvgPicture.asset('assets/icons/back_menu.svg',
                            height: 16.5, width: 9.5, color: Colors.grey))
                  ],
                ),
                subtitle: const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Алматы',
                    style: TextStyle(
                        color: AppColors.kGray400,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 10.5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Пуш уведомления',
                        style: TextStyle(
                            color: AppColors.kGray900,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: isSwitchedPush,
                          onChanged: (value) {
                            setState(() {
                              isSwitchedPush = value;
                              // print(isSwitched);
                            });
                          },
                          trackColor: Colors.grey.shade200,
                          activeColor: AppColors.kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: AppColors.kGray400,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 14, bottom: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Язык приложения',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Русский',
                            style: TextStyle(
                                color: AppColors.kGray300,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      SvgPicture.asset('assets/icons/back_menu.svg',
                          height: 16.5, width: 9.5, color: Colors.grey)
                    ],
                  ),
                ),
                const Divider(
                  color: AppColors.kGray400,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Вход с Touch ID',
                        style: TextStyle(
                            color: AppColors.kGray900,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: isSwitchedTouch,
                          onChanged: (value) {
                            setState(() {
                              isSwitchedTouch = value;
                              // print(isSwitched);
                            });
                          },
                          trackColor: Colors.grey.shade200,
                          activeColor: AppColors.kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                // const Divider(
                //   color: AppColors.kGray400,
                // ),
                // Container(
                //   padding: const EdgeInsets.only(
                //       left: 16, right: 16, top: 10, bottom: 10),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: const [
                //           Text(
                //             'Изменить город',
                //             style: TextStyle(
                //                 color: AppColors.kGray900,
                //                 fontSize: 16,
                //                 fontWeight: FontWeight.w400),
                //           ),
                //         ],
                //       ),
                //       const Icon(
                //         Icons.arrow_forward_ios,
                //         size: 20,
                //         color: AppColors.kGray300,
                //       )
                //     ],
                //   ),
                // ),
                const Divider(
                  color: AppColors.kGray400,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyBankCardPage()),
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
                              'Мои карты',
                              style: TextStyle(
                                  color: AppColors.kGray900,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SvgPicture.asset('assets/icons/back_menu.svg',
                            height: 16.5, width: 9.5, color: Colors.grey)
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: AppColors.kGray400,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Мои бонусы',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      const Text(
                        '987 ₸ ',
                        style: TextStyle(
                            color: AppColors.kGray300,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: AppColors.kGray400,
                ),
                GestureDetector(
                  onTap: () {
                    GetStorage().remove('token');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ViewAuthRegisterPage(BackButton: true)),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 16.5, bottom: 16.5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Выйти',
                          style: TextStyle(
                              color: Color.fromRGBO(236, 72, 85, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        SvgPicture.asset('assets/icons/logout.svg')
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.kPrimaryColor,
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Сохранить',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}
