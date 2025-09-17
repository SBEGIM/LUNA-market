import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/auth/bloc/login_cubit.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:haji_market/src/feature/drawer/presentation/ui/about_us_page.dart';
import 'package:haji_market/src/feature/drawer/presentation/ui/top_menu.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/show_alert_cabinet_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/show_language_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../chat/presentation/chat_page.dart';
import '../../../my_order/presentation/ui/my_order_page.dart';
import '../../../profile/data/presentation/ui/edit_profile_page.dart';
import '../widgets/bonus_page.dart';

@RoutePage()
class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  bool selected = false;
  bool isSwitchedPush = false;
  bool isSwitchedTouch = false;
  bool? switchValue;

  bool isAuthUser = false;

  final _box = GetStorage();
  int index = 0;

  @override
  void initState() {
    isAuthUser = _box.read('name') != 'Не авторизированный' ? true : false;
    _box.read('avatar');
    _box.read('name');

    isSwitchedPush = _box.read('push') == '1';

    super.initState();
  }

  @override
  Widget build(BuildContext dialogContext) {
    return Scaffold(
      backgroundColor:
          isAuthUser ? AppColors.kWhite : AppColors.kBackgroundColor,
      appBar: null,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 462,
                padding: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topRight,
                      transform: GradientRotation(4.2373),
                      colors: [
                        Color(0xFFAD32F8),
                        Color(0xFF3275F8),
                      ],
                    ),
                    color: AppColors.mainPurpleColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24))),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 30),
                    isAuthUser
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              buildProfileAvatar(_box),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20),
                                  Text('${_box.read('name')}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colors.white)),
                                  const SizedBox(height: 4),
                                  Text(
                                    _box.read('city') ?? 'Алматы',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColors.kWhite,
                                    ),
                                  ),
                                  SizedBox(height: 10)
                                ],
                              )
                            ],
                          )
                        : Container(
                            margin:
                                EdgeInsets.only(left: 16, right: 16, top: 8),
                            height: 258,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColors.kLightBlackColor
                                    .withOpacity(0.15),
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                buildProfileAvatar(_box),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 20),
                                    Text('Добро пожаловать!',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                            color: Colors.white)),
                                    const SizedBox(height: 4),
                                    SizedBox(
                                      width: 320,
                                      child: Text(
                                        'Войдите или зарегистрируйтесь, чтобы открыть весь функционал',
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.categoryTextStyle
                                            .copyWith(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                height: 22 / 16,
                                                color: AppColors.kGray200),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                    isAuthUser
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TopMenu(
                                  text: 'Мои бонусы',
                                  icon: 'assets/icons/ep_money.svg',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BonusUserPage()),
                                    );
                                  }),
                              TopMenu(
                                  text: 'Мои заказы',
                                  icon: 'assets/icons/my_user_orders.svg',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyOrderPage()),
                                    );
                                    // print('123231');
                                  }),
                              TopMenu(
                                text: 'Мои чаты',
                                icon: 'assets/icons/chat_2.svg',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const ChatPage()),
                                  );
                                },
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                    SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: DefaultButton(
                          text: isAuthUser ? 'Другой кабинет' : 'Начать',
                          press: () {
                            showRolePicker(context,
                                isAuthUser ? 'change_cabinet' : 'auth_user');
                          },
                          color: AppColors.kLightBlackColor,
                          backgroundColor: AppColors.kWhite,
                          textStyle: AppTextStyles.aboutTextStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w600),
                          width: double.infinity),
                    )
                  ],
                ),
              ),

              Container(
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                    color: AppColors.kWhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    isAuthUser
                        ? buildProfileItem(
                            onTap: () async {
                              if (!isAuthUser) {
                                GetStorage().remove('token');
                                BlocProvider.of<AppBloc>(context)
                                    .add(const AppEvent.exiting());
                              } else {
                                final data = await Get.to(EditProfilePage(
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
                                ));

                                if (data != null) {
                                  setState(() {});
                                }
                              }
                            },
                            title: 'Мои данные',
                            iconPath: Assets.icons.sellerProfileDataIcon.path,
                          )
                        : SizedBox.shrink(),

                    isAuthUser
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16, top: 8),
                            child: const Divider(
                              thickness: 0.3,
                              height: 0,
                              color: AppColors.kGray200,
                            ),
                          )
                        : SizedBox.shrink(),

                    buildProfileItem(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutUsPage()),
                        );
                      },
                      title: 'О нас',
                      iconPath: Assets.icons.about.path,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                      child: const Divider(
                        thickness: 0.2,
                        height: 0,
                        color: AppColors.kGray200,
                      ),
                    ),

                    buildProfileItem(
                      onTap: () => launch("https://t.me/LUNAmarketAdmin",
                          forceSafariVC: false),
                      title: 'Техподдержка',
                      iconPath: Assets.icons.supportCenter.path,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                      child: const Divider(
                        thickness: 0.2,
                        height: 0,
                        color: AppColors.kGray200,
                      ),
                    ),
                    buildProfileItem(
                      onTap: () {},
                      switchWidget: true,
                      switchValue: switchValue,
                      onSwitchChanged: (value) {
                        switchValue = value;
                        print(value);
                        setState(() {});
                      },
                      title: 'Уведомления',
                      iconPath: Assets.icons.sellerNotification.path,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                      child: const Divider(
                        thickness: 0.2,
                        height: 0,
                        color: AppColors.kGray200,
                      ),
                    ),

                    buildProfileItem(
                      onTap: () {
                        final List<String> languages = [
                          'Русский',
                          'Қазақша',
                          'Английский',
                        ];

                        showLanguageOptions(context, 'Язык', languages,
                            (value) {
                          setState(() {});
                        });
                      },
                      title: 'Язык',
                      text: _box.read('language') ?? 'Рус',
                      iconPath: Assets.icons.sellerLanguageIcon.path,
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     _box.read('seller_token') != null
                    //         ? BlocProvider.of<AppBloc>(context).add(
                    //             const AppEvent.chageState(
                    //                 state: AppState.inAppAdminState()))
                    //         : context.router.push(AuthSellerRoute());
                    //   },
                    //   child: const DrawerListTile(
                    //     text: 'Кабинет продавца',
                    //   ),
                    // ),
                    // const Divider(
                    //   color: AppColors.kGray200,
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     _box.read('blogger_token') != null
                    //         ? BlocProvider.of<AppBloc>(context).add(
                    //             const AppEvent.chageState(
                    //                 state: AppState.inAppBlogerState()))
                    //         : context.router.push(BlogAuthRegisterRoute());
                    //   },
                    //   child: const DrawerListTile(
                    //     text: 'Кабинет блогера',
                    //   ),
                    // ),

                    // const Divider(
                    //   color: AppColors.kGray200,
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     _box.read('blogger_token') != null
                    //         ? BlocProvider.of<AppBloc>(context)
                    //             .add(const AppEvent.chageState(state: AppState.inAppManagerState()))
                    //         : context.router.push(BlogAuthRegisterRoute());
                    //   },
                    //   child: const DrawerListTile(
                    //     text: 'Кабинет менеджера',
                    //   ),
                    // ),
                    // const Divider(
                    //   color: AppColors.kGray200,
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => const CreditInfoPage()),
                    //     );
                    //   },
                    //   child: const DrawerListTile(
                    //     text: 'Рассрочка',
                    //   ),
                    // ),

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

                    // SizedBox(
                    //   height: 55,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(13.0),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       mainAxisSize: MainAxisSize.max,
                    //       children: [
                    //         const Text(
                    //           'Вход с Touch ID',
                    //           style: AppTextStyles.drawer2TextStyle,
                    //         ),
                    //         SizedBox(
                    //           height: 8,
                    //           child: Transform.scale(
                    //             scale: 0.9,
                    //             child: CupertinoSwitch(
                    //               value: isSwitchedTouch,
                    //               onChanged: (value) {
                    //                 setState(() {
                    //                   isSwitchedTouch = value;
                    //                   // print(isSwitched);
                    //                 });
                    //               },
                    //               trackColor: Colors.grey.shade200,
                    //               activeColor: AppColors.kPrimaryColor,
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const Divider(
                    //   color: AppColors.kGray200,
                    //   height: 0,
                    // ),
                    isAuthUser
                        ? buildProfileItem(
                            onTap: () {
                              final deviceToken = _box.read('device_token');
                              GetStorage().erase();
                              _box.write('device_token', deviceToken);
                              // Get.offAll(() => const ViewAuthRegisterPage(BackButton: true));
                              BlocProvider.of<AppBloc>(context)
                                  .add(const AppEvent.exiting());
                            },
                            title: 'Выйти',
                            text: null,
                            iconPath: Assets.icons.sellerBack.path,
                          )
                        : SizedBox.shrink(),

                    // GestureDetector(
                    //   onTap: () {
                    //     // Navigator.push(
                    //     //   context,
                    //     //   MaterialPageRoute(
                    //     //       builder: (context) =>
                    //     //           const ViewAuthRegisterPage(BackButton: true)),
                    //     // );
                    //   },
                    //   child: SizedBox(
                    //     height: 55,
                    //     child: Padding(
                    //       padding: const EdgeInsets.only(
                    //           left: 13.0, right: 20, top: 13, bottom: 13),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         mainAxisSize: MainAxisSize.max,
                    //         children: [
                    //           const Text(
                    //             'Выйти',
                    //             style: TextStyle(
                    //               fontSize: 16,
                    //               color: Color(0xffFF3347),
                    //               fontWeight: FontWeight.w400,
                    //             ),
                    //           ),
                    //           SvgPicture.asset('assets/icons/logout.svg')
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // const Divider(
                    //   //height: 0,
                    //   color: AppColors.kGray200,
                    // ),
                    // GestureDetector(

                    //   onTap: () async {
                    //     await BlocProvider.of<LoginCubit>(context).delete();
                    //     GetStorage().erase();
                    //     BlocProvider.of<AppBloc>(context)
                    //         .add(const AppEvent.exiting());
                    //     // Get.offAll(() => const ViewAuthRegisterPage(BackButton: true));

                    //     Get.snackbar('Аккаунт удален', 'Account delete',
                    //         backgroundColor: Colors.redAccent);

                    //     // Navigator.push(
                    //     //   context,
                    //     //   MaterialPageRoute(
                    //     //       builder: (context) =>
                    //     //           const ViewAuthRegisterPage(BackButton: true)),
                    //     // );
                    //   },
                    //   child: const SizedBox(
                    //     height: 55,
                    //     child: Padding(
                    //       padding: EdgeInsets.only(
                    //           left: 13.0, right: 20, top: 13, bottom: 13),
                    //       child: Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         mainAxisSize: MainAxisSize.max,
                    //         children: [
                    //           Text(
                    //             'Удалить',
                    //             style: TextStyle(
                    //               fontSize: 16,
                    //               color: Color(0xffFF3347),
                    //               fontWeight: FontWeight.w400,
                    //             ),
                    //           ),
                    //           Icon(
                    //             Icons.delete,
                    //             color: Color(0xffFF3347),
                    //             size: 25,
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),

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
              ),
              //const Divider(
              //   color: AppColors.kGray200,
              // ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              // InkWell(
              //   onTap: () {
              //     GetStorage().write('app_lang', 'kz');
              //     selected = true;
              //     setState(() {});
              //   },
              //   child: Container(
              //     height: 34,
              //     width: 54,
              //     decoration: BoxDecoration(
              //         color: selected == false ? Colors.white : Colors.black,
              //         border: Border.all(
              //           color: AppColors.kGray900,
              //         ),
              //         borderRadius: const BorderRadius.all(Radius.circular(10))),
              //     child: Center(
              //         child: Text(
              //       'Қаз',
              //       style: TextStyle(
              //         fontSize: 17,
              //         color: selected == false ? Colors.black : Colors.white,
              //         // AppColors.kLightBlackColor,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     )),
              //   ),
              // ),
              // const SizedBox(
              //   width: 8,
              // ),
              //   InkWell(
              //     onTap: () {
              //       GetStorage().write('app_lang', 'ru');
              //       selected = false;
              //       setState(() {});
              //     },
              //     child: Container(
              //       height: 34,
              //       width: 54,
              //       decoration: BoxDecoration(
              //           color: selected == true ? Colors.white : Colors.black,
              //           border: Border.all(
              //             color: AppColors.kGray900,
              //           ),
              //           borderRadius: const BorderRadius.all(Radius.circular(10))),
              //       child: Center(
              //           child: Text(
              //         'Рус',
              //         style: TextStyle(
              //           fontSize: 17,
              //           color: selected == true ? Colors.black : Colors.white,
              //           // AppColors.kLightBlackColor,
              //           fontWeight: FontWeight.w500,
              //         ),
              //       )),
              //     ),
              //   ),
              //   ],
              // )
            ],
          ),
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

Widget buildProfileItem({
  required String title,
  String? text,
  required String iconPath,
  required VoidCallback onTap,
  bool? switchWidget,
  ValueChanged<bool>? onSwitchChanged,
  bool? switchValue,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 18, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                iconPath,
                height: 40,
                width: 40,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                    color: AppColors.kGray900,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0),
              ),
            ],
          ),
          switchWidget == true
              ? Transform.scale(
                  scale: 0.9,
                  child: Switch(
                    value: switchValue ?? false,
                    onChanged: onSwitchChanged,
                    inactiveThumbColor: Colors.white,
                    activeTrackColor: AppColors.mainPurpleColor,
                    trackOutlineWidth: MaterialStateProperty.all(0.01),
                  ),
                )
              : Row(
                  children: [
                    if (text != null)
                      Text(
                        text,
                        style: AppTextStyles.size14Weight400,
                      ),
                    if (text != null) SizedBox(width: 14),
                    Image.asset(Assets.icons.defaultArrowForwardIcon.path,
                        scale: 1.9),
                  ],
                )
        ],
      ),
    ),
  );
}

Widget buildProfileAvatar(_box) {
  final String? avatar = _box.read('avatar');
  final String? name = _box.read('name');

  final bool isAuthorized = avatar != null &&
      avatar != 'null' &&
      name != null &&
      name != 'Не авторизированный';

  return isAuthorized
      ? ClipRRect(
          borderRadius: BorderRadius.circular(120),
          child: Image.network(
            'https://lunamarket.ru/storage/$avatar',
            height: 94,
            width: 94,
            fit: BoxFit.cover,
          ),
        )
      : Container(
          height: 94,
          width: 94,
          padding: isAuthorized ? EdgeInsets.zero : const EdgeInsets.all(29.5),
          decoration: BoxDecoration(
            color: AppColors.kWhite.withOpacity(0.1),
            borderRadius: BorderRadius.circular(51),
          ),
          child: Image(
            image: AssetImage(Assets.icons.accountHead.path),
            fit: isAuthorized ? BoxFit.cover : BoxFit.contain,
            alignment: Alignment.center,
          ),
        );
}
