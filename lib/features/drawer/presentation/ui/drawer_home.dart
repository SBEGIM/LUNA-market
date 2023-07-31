import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/bloc/app_bloc.dart';
import 'package:haji_market/features/app/router/app_router.dart';
import 'package:haji_market/features/auth/data/bloc/login_cubit.dart';
import 'package:haji_market/features/drawer/presentation/ui/about_us_page.dart';
import 'package:haji_market/features/drawer/presentation/ui/credit_info_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../admin/admin_app/presentation/base_admin.dart';
import '../../../../admin/auth/presentation/ui/admin_auth_page.dart';
import '../../../../bloger/admin_app/presentation/base_blogger.dart';
import '../../../../bloger/auth/presentation/ui/blog_auth_register_page.dart';
import '../../../auth/presentation/ui/view_auth_register_page.dart';
import '../../../chat/presentation/chat_page.dart';
import '../../../my_order/presentation/ui/my_order_page.dart';
import '../../../profile/data/presentation/ui/edit_profile_page.dart';
import '../widgets/bonus_page.dart';

@RoutePage()
class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  bool selected = false;
  bool isSwitchedPush = false;
  bool isSwitchedTouch = false;

  final _box = GetStorage();
  int index = 0;

  @override
  void initState() {
    _box.read('avatar');

    final lang = GetStorage().read('app_lang');

    if (lang != null) {
      if (lang == 'kz') {
        selected = true;
      } else {
        selected = false;
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return // Drawer(
        // backgroundColor: Colors.white,
        // elevation: 0,
        // child:
        ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: _box.read('name') != 'Не авторизированный' ? 224 : 96,
              // alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 16, right: 16, top: 30),
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
                        BlocProvider.of<AppBloc>(context).add(const AppEvent.exiting());
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const ViewAuthRegisterPage(BackButton: true)),
                        // );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfilePage(
                                    name: _box.read('name'),
                                    phone: _box.read('phone') ?? '',
                                    gender: _box.read('gender') ?? '',
                                    birthday: _box.read('birthday') ?? '',
                                    country: _box.read('country') ?? '',
                                    city: _box.read('city') ?? '',
                                    street: _box.read('street') ?? '',
                                    home: _box.read('home') ?? '',
                                    porch: _box.read('porch') ?? '',
                                    floor: _box.read('floor') ?? '',
                                    room: _box.read('room') ?? '',
                                    email: _box.read('email') ?? '',
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
                                          image: (_box.read('avatar') != null && _box.read('avatar') != "null")
                                              ? NetworkImage("http://185.116.193.73/storage/${_box.read('avatar')}")
                                              : const AssetImage('assets/icons/profile2.png') as ImageProvider,
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
                              width: _box.read('name') != 'Не авторизированный' ? 10 : 0,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${_box.read('name') == 'Не авторизированный' ? 'Вход/Регистрация' : _box.read('name')}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color:
                                            _box.read('name') == 'Не авторизированный' ? Colors.white : Colors.black)),
                                const SizedBox(height: 4),
                                Text(_box.read('name') == 'Не авторизированный' ? '' : _box.read('city') ?? 'Алматы',
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
                          color: _box.read('name') != 'Не авторизированный'
                              ? const Color.fromRGBO(170, 174, 179, 1)
                              : Colors.white,
                          height: 16.5,
                          width: 9.5,
                        )
                      ],
                    ),
                  ),
                  _box.read('name') != 'Не авторизированный'
                      ? const SizedBox(
                          height: 6,
                        )
                      : Container(),
                  _box.read('name') != 'Не авторизированный'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            topMenu(
                                text: 'Мои бонусы',
                                icon: 'assets/icons/ep_money.svg',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const BonusUserPage()),
                                  );
                                }),
                            topMenu(
                                text: 'Мои заказы',
                                icon: 'assets/icons/my_user_orders.svg',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const MyOrderPage()),
                                  );
                                  // print('123231');
                                }),
                            topMenu(
                              text: 'Мои чаты',
                              icon: 'assets/icons/chat_2.svg',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ChatPage()),
                                );
                              },
                            ),
                          ],
                        )
                      : Container()
                ],
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    _box.read('seller_token') != null
                        ? BlocProvider.of<AppBloc>(context)
                            .add(const AppEvent.chageState(state: AppState.inAppAdminState()))
                        : context.router.push(AdminAuthRoute());
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
                    _box.read('blogger_token') != null
                        ? BlocProvider.of<AppBloc>(context)
                            .add(const AppEvent.chageState(state: AppState.inAppBlogerState()))
                        : context.router.push(BlogAuthRegisterRoute());
                  },
                  child: const DrawerListTile(
                    text: 'Кабинет блогера',
                  ),
                ),
                const Divider(
                  color: AppColors.kGray200,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CreditInfoPage()),
                    );
                  },
                  child: const DrawerListTile(
                    text: 'Рассрочка',
                  ),
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
                // const DrawerListTile(
                //   text: 'Рассрочка',
                // ),
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
                  onTap: () => launch("https://t.me/LUNAmarketAdmin", forceSafariVC: false),
                  child: const SizedBox(
                    height: 55,
                    child: DrawerListTile(
                      text: 'Связаться с администрацией',
                    ),
                  ),
                ),
                const Divider(
                  color: AppColors.kGray200,
                ),

                SizedBox(
                  height: 55,
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text(
                          'Пуш уведомления',
                          style: AppTextStyles.drawer2TextStyle,
                        ),
                        SizedBox(
                          height: 8,
                          child: Transform.scale(
                            scale: 0.9,
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
                        ),
                      ],
                    ),
                  ),
                ),

                const Divider(
                  //height: 0,
                  color: AppColors.kGray200,
                ),
                SizedBox(
                  height: 55,
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text(
                          'Вход с Touch ID',
                          style: AppTextStyles.drawer2TextStyle,
                        ),
                        SizedBox(
                          height: 8,
                          child: Transform.scale(
                            scale: 0.9,
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
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  color: AppColors.kGray200,
                  height: 0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AboutUsPage()),
                    );
                  },
                  child: const SizedBox(
                    height: 55,
                    child: DrawerListTile(
                      text: 'О нас',
                    ),
                  ),
                ),
                const Divider(
                  height: 0,
                  color: AppColors.kGray200,
                ),

                GestureDetector(
                  onTap: () {
                    GetStorage().erase();
                    // Get.offAll(() => const ViewAuthRegisterPage(BackButton: true));
                    BlocProvider.of<AppBloc>(context).add(const AppEvent.exiting());

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           const ViewAuthRegisterPage(BackButton: true)),
                    // );
                  },
                  child: SizedBox(
                    height: 55,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 13.0, right: 20, top: 13, bottom: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text(
                            'Выйти',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xffFF3347),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SvgPicture.asset('assets/icons/logout.svg')
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(
                  //height: 0,
                  color: AppColors.kGray200,
                ),
                GestureDetector(
                  onTap: () async {
                    await BlocProvider.of<LoginCubit>(context).delete();
                    GetStorage().erase();
                    BlocProvider.of<AppBloc>(context).add(const AppEvent.exiting());
                    // Get.offAll(() => const ViewAuthRegisterPage(BackButton: true));

                    Get.snackbar('Аккаунт удален', 'Account delete', backgroundColor: Colors.redAccent);

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           const ViewAuthRegisterPage(BackButton: true)),
                    // );
                  },
                  child: const SizedBox(
                    height: 55,
                    child: Padding(
                      padding: EdgeInsets.only(left: 13.0, right: 20, top: 13, bottom: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Удалить',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xffFF3347),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Icon(
                            Icons.delete,
                            color: Color(0xffFF3347),
                            size: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     GetStorage().remove('token');
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) =>
                //               const ViewAuthRegisterPage(BackButton: true)),
                //     );
                //   },
                //   child: Container(
                //     padding: const EdgeInsets.only(
                //         left: 16, right: 16, top: 16.5, bottom: 16.5),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         const Text(
                //           'Выйти',
                //           style: TextStyle(
                //               color: Color.fromRGBO(236, 72, 85, 1),
                //               fontSize: 16,
                //               fontWeight: FontWeight.w400),
                //         ),
                //         SvgPicture.asset('assets/icons/logout.svg')
                //       ],
                //     ),
                //   ),
                // ),
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
                      GetStorage().write('app_lang', 'kz');
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
                          borderRadius: const BorderRadius.all(Radius.circular(10))),
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
                      GetStorage().write('app_lang', 'ru');
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
                          borderRadius: const BorderRadius.all(Radius.circular(10))),
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
      ],
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
        margin: const EdgeInsets.only(right: 8, top: 10),
        padding: const EdgeInsets.only(left: 12),
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
              height: 30,
            ),
            const SizedBox(
              height: 23,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
