import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/presentaion/base.dart';
import 'package:haji_market/features/drawer/presentation/ui/about_us_page.dart';
import 'package:haji_market/features/drawer/presentation/ui/catalog_page.dart';
import 'package:haji_market/features/drawer/presentation/ui/city_page.dart';
import 'package:haji_market/features/profile/data/presentation/ui/notification_page.dart';
import 'package:haji_market/features/profile/data/presentation/ui/profile_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../admin/auth/presentation/ui/view_auth_register_page.dart';
import '../../../../admin/coop_request/presentation/ui/coop_request_page.dart';
import '../../../../bloger/auth/presentation/ui/view_auth_register_page.dart';
import '../../../../bloger/coop_request/presentation/ui/coop_request_page.dart';
import '../../../auth/presentation/ui/view_auth_register_page.dart';
import '../../../my_order/presentation/ui/my_order_page.dart';
import '../../../profile/data/presentation/ui/edit_profile_page.dart';
import '../../../profile/data/presentation/ui/my_bank_card_page.dart';
import '../widgets/country_widget.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({Key? key}) : super(key: key);

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  bool selected = false;
  bool isSwitchedPush = false;
  bool isSwitchedTouch = false;

  final _box = GetStorage();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return // Drawer(
        // backgroundColor: Colors.white,
        // elevation: 0,
        // child:
        Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 258,
            // alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 80),
            color: _box.read('name') == 'Не авторизированный'
                ? AppColors.kPrimaryColor
                : const Color.fromRGBO(241, 241, 241, 1),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                  onTap: () {
                    if (_box.read('name') == 'Не авторизированный') {
                      GetStorage().remove('token');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ViewAuthRegisterPage(BackButton: true)),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfilePage(
                                  name: _box.read('name'),
                                )),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        /// mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _box.read('name') != 'Не авторизированный'
                              ? Container(
                                  height: 64,
                                  width: 64,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(31),
                                      image: DecorationImage(
                                        image: _box.read('avatar') != null
                                            ? NetworkImage(
                                                "http://80.87.202.73:8001/storage/${_box.read('avatar')}")
                                            : const AssetImage(
                                                    'assets/icons/profile2.png')
                                                as ImageProvider,
                                        fit: BoxFit.cover,
                                      )),
                                )
                              : Container(),
                          // CircleAvatar(
                          //   backgroundColor: Colors.white,
                          //   radius: 21,
                          //   child: CircleAvatar(
                          //     radius: 20,
                          //     child: SvgPicture.asset('assets/icons/phone.svg'),
                          //   ),
                          // ),

                          SizedBox(
                            width: _box.read('name') != 'Не авторизированный'
                                ? 10
                                : 0,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${_box.read('name') == 'Не авторизированный' ? 'Вход/Регистрация' : _box.read('name')}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.black)),
                              Text(
                                  '${_box.read('name') == 'Не авторизированный' ? '' : 'Алматы'}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Color.fromRGBO(145, 145, 145, 1))),
                            ],
                          )
                        ],
                      ),
                      SvgPicture.asset(
                        'assets/icons/back_menu.svg',
                        color: const Color.fromRGBO(170, 174, 179, 1),
                        height: 16.5,
                        width: 9.5,
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    topMenu(
                        text: 'Мои карты',
                        icon: 'assets/icons/card.svg',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyBankCardPage()),
                          );
                        }),
                    topMenu(
                        text: 'Мои бонусы',
                        icon: 'assets/icons/bank_card.svg',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CityPage()),
                          );
                        }),
                    topMenu(
                        text: 'Мои заказы',
                        icon: 'assets/icons/bank_card.svg',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyOrderPage()),
                          );
                          // print('123231');
                        }),
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminAuthPage()),
                  );
                },
                child: const DrawerListTile(
                  text: 'Кабинет продавца',
                ),
              ),
              const Divider(
                color: AppColors.kGray200,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BlogAuthRegisterPage()),
                  );
                },
                child: const DrawerListTile(
                  text: 'Кабинет блогера',
                ),
              ),
              const Divider(
                color: AppColors.kGray200,
              ),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => CityPage()),
              //     );
              //   },
              //   child: const DrawerListTile(
              //     text: 'Алматы',
              //   ),
              // ),
              // const Divider(
              //   color: AppColors.kGray200,
              // ),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => NotificationPage()),
              //     );
              //   },
              //   child: const DrawerListTile(
              //     text: 'Уведомления',
              //   ),
              // ),
              // const Divider(
              //   color: AppColors.kGray200,
              // ),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => CatalogPage()),
              //     );
              //   },
              //   child: const DrawerListTile(
              //     text: 'Каталог',
              //   ),
              // ),
              // const Divider(
              //   color: AppColors.kGray200,
              // ),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => CoopRequestPage()),
              //     );
              //   },
              //   child: const DrawerListTile(
              //     text: 'Продавать на Luna market',
              //   ),
              // ),
              // const Divider(
              //   color: AppColors.kGray200,
              // ),
              // InkWell(
              //   onTap: () {
              //     Navigator.pushAndRemoveUntil(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => const Base(
              //           index: 1,
              //         ),
              //       ),
              //       (route) => false,
              //     );
              //   },
              //   child: const DrawerListTile(
              //     text: 'Маркет',
              //   ),
              // ),
              // const Divider(
              //   color: AppColors.kGray200,
              // ),
              const DrawerListTile(
                text: 'Рассрочка',
              ),
              const Divider(
                color: AppColors.kGray200,
              ),
              InkWell(
                // onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AboutUsPage()),
                // );
                // },
                onTap: () =>
                    launch("https://t.me/LUNAmarketru", forceSafariVC: false),
                child: const DrawerListTile(
                  text: 'Связаться с администрацией',
                ),
              ),
              const Divider(
                //height: 0,
                color: AppColors.kGray200,
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 13,
                  right: 13,
                  // top: 10.5,
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
              Container(
                padding: const EdgeInsets.only(
                  left: 13,
                  right: 13,
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
              ),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => AboutUsPage()),
              //     );
              //   },
              //   child: Container(
              //     padding: const EdgeInsets.only(
              //         left: 13,
              //         // right: 16,
              //         top: 10,
              //         bottom: 16),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: const [
              //         Text(
              //           'Удалить аккаунт',
              //           style: TextStyle(
              //               color: Colors.red,
              //               fontSize: 15,
              //               fontWeight: FontWeight.w400),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              const Divider(
                color: AppColors.kGray200,
                height: 0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUsPage()),
                  );
                },
                child: const DrawerListTile(
                  text: 'О нас',
                ),
              ),
              const Divider(
                height: 0,
                color: AppColors.kGray200,
              ),
              // GestureDetector(
              //   onTap: () async {
              //     Get.to(const CountryWidget());
              //     GetStorage().listen(() {
              //       if (GetStorage().read('country_index') != null) {
              //         setState(() {
              //           index = GetStorage().read('country_index');
              //         });
              //       }
              //     });
              //   },
              //   child: Container(
              //     height: 45,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Row(
              //           children: [
              //             const SizedBox(
              //               width: 12,
              //             ),
              //             if (index == 1 || index == 0)
              //               SvgPicture.asset('assets/temp/kaz.svg')
              //             else if (index == 2)
              //               SvgPicture.asset('assets/temp/rus.svg')
              //             else if (index == 3)
              //               SvgPicture.asset('assets/temp/ukr.svg')
              //             else if (index == 4)
              //               SvgPicture.asset('assets/temp/bel.svg'),
              //             const SizedBox(
              //               width: 12,
              //             ),
              //             if (index == 1 || index == 0)
              //               const Text(
              //                 'Казахстан',
              //                 style: AppTextStyles.drawer2TextStyle,
              //               )
              //             else if (index == 2)
              //               const Text(
              //                 'Россия',
              //                 style: AppTextStyles.drawer2TextStyle,
              //               )
              //             else if (index == 3)
              //               const Text(
              //                 'Украина',
              //                 style: AppTextStyles.drawer2TextStyle,
              //               )
              //             else if (index == 4)
              //               const Text(
              //                 'Беларус',
              //                 style: AppTextStyles.drawer2TextStyle,
              //               ),
              //           ],
              //         ),
              //         Row(
              //           children: [
              //             SvgPicture.asset('assets/icons/back_menu.svg'),
              //             const SizedBox(
              //               width: 16,
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
          //const Divider(
          //   color: AppColors.kGray200,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    selected = true;
                    setState(() {});
                  },
                  child: Container(
                    height: 34,
                    width: 54,
                    decoration: BoxDecoration(
                        color: selected == false ? Colors.white : Colors.black,
                        border: Border.all(
                          color: AppColors.kGray900,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Text(
                      'Қаз',
                      style: TextStyle(
                        fontSize: 17,
                        color: selected == false ? Colors.black : Colors.white,
                        // AppColors.kLightBlackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {
                    selected = false;
                    setState(() {});
                  },
                  child: Container(
                    height: 34,
                    width: 54,
                    decoration: BoxDecoration(
                        color: selected == true ? Colors.white : Colors.black,
                        border: Border.all(
                          color: AppColors.kGray900,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Text(
                      'Рус',
                      style: TextStyle(
                        fontSize: 17,
                        color: selected == true ? Colors.black : Colors.white,
                        // AppColors.kLightBlackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String text;
  const DrawerListTile({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: AppTextStyles.drawer2TextStyle,
          ),
          SvgPicture.asset('assets/icons/back_menu.svg')
        ],
      ),
    );
    // ListTile(
    //   title: Text(
    //     text,
    //     style: AppTextStyles.drawer2TextStyle,
    //   ),
    //   trailing: const Icon(
    //     Icons.arrow_forward_ios,
    //     color: AppColors.kPrimaryColor,
    //   ),
    // );
  }
}

class topMenu extends StatelessWidget {
  final String text;
  final String icon;
  void Function()? onTap;
  topMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 8, top: 10),
        padding: EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
          color: AppColors.kBlueColor,
          borderRadius: BorderRadius.circular(12),
        ),
        //  color: AppColors.kBlueColor,
        height: 94,
        width: 107,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              icon,
              color: Colors.white,
            ),
            SizedBox(
              height: 23,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
