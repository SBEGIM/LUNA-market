import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:haji_market/src/feature/bloger/profile/presentation/widgets/show_module_profile_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/ui/about_us_page.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/client_show_image_list_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/client_show_list_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/show_alert_account_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/show_alert_cabinet_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/show_language_widget.dart';
import 'package:haji_market/src/feature/home/data/model/city_model.dart';
import 'package:image_picker/image_picker.dart';
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
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  bool change = false;
  int index = 0;

  Future<void> _getImage(context) async {
    final image = change == true
        ? await _picker.pickImage(source: ImageSource.camera)
        : await _picker.pickImage(source: ImageSource.gallery);

    print(' ${image!.path}');
    // BlocProvider.of<>(context).edit(
    //   '',
    //   '',
    //   image.path,
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   null,
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    //   '',
    // );

    setState(() {
      _image = image;
    });
  }

  CityModel? city;

  CityModel? loadCity() {
    final data = GetStorage().read('city');
    if (data == null) return null;

    if (data is! Map<String, dynamic>) {
      return null;
    }
    return CityModel.fromJson(Map<String, dynamic>.from(data));
  }

  @override
  void initState() {
    city = loadCity();
    isAuthUser = _box.read('active') == '1' ? true : false;
    _box.read('avatar');
    _box.read('name');
    isSwitchedPush = _box.read('push') == '1';
    super.initState();
  }

  @override
  Widget build(BuildContext dialogContext) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: null,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              isAuthUser
                  ? Container(
                      decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 60),
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: GestureDetector(
                              onTap: () {
                                showClientImageOptions(context, false, 'Изменить фото профиля', (
                                  value,
                                ) async {
                                  if (value == 'image') {
                                    final ok = await showAccountAlert(
                                      context,
                                      title: 'Изменить фото',
                                      message: 'Изменить фото',
                                      mode: AccountAlertMode.confirm,
                                      cancelText: 'Галерея',
                                      primaryText: 'Камера',
                                      primaryColor: Colors.red,
                                    );

                                    if (ok == true) {
                                      change = true;
                                      _getImage(context);
                                    } else {
                                      change = false;
                                      _getImage(context);
                                    }
                                    // Get.defaultDialog(
                                    //   title: "Изменить фото",
                                    //   middleText: '',
                                    //   textConfirm: 'Камера',
                                    //   textCancel: 'Галерея',
                                    //   titlePadding:
                                    //       const EdgeInsets.only(top: 40),
                                    //   onConfirm: () {
                                    //     change = true;
                                    //     _getImage(context);
                                    //   },
                                    //   onCancel: () {
                                    //     change = false;
                                    //     _getImage(context);
                                    //   },
                                    // );
                                  } else {
                                    Navigator.of(context).pop();
                                  }
                                });
                              },
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundColor: AppColors.kAlpha12,
                                    child: CircleAvatar(
                                      radius: 59.5,
                                      backgroundColor: AppColors.kGray200,
                                      backgroundImage: _image != null
                                          ? FileImage(File(_image!.path))
                                          : NetworkImage(
                                                  'https://lunamarket.ru/storage/${GetStorage().read('avatar')}',
                                                )
                                                as ImageProvider,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Image.asset(
                                      Assets.icons.sellerCameraIcon.path,
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            '${GetStorage().read('first_name') ?? ''} ${GetStorage().read('last_name') ?? ''}',
                            style: AppTextStyles.size18Weight600,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                city?.city ?? 'Алматы',
                                style: AppTextStyles.size14Weight500.copyWith(
                                  color: Color(0xff959595),
                                ),
                              ),
                            ],
                          ),

                          // InkWell(
                          //   onTap: () async {
                          //     final data = await Get.to(ReqirectProfilePage());

                          //     if (data != null) {
                          //       setState(() {});
                          //     }
                          //   },
                          //   child: const Text(
                          //     'Редактирование',
                          //     style: TextStyle(
                          //         color: AppColors.kPrimaryColor,
                          //         fontSize: 14,
                          //         fontWeight: FontWeight.w400),
                          //   ),
                          // ),
                          SizedBox(height: 16),
                          InkWell(
                            onTap: () {
                              showRolePicker(context, isAuthUser ? 'change_cabinet' : 'auth_user');
                            },
                            child: Container(
                              height: 36,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: AppColors.kWhite,
                                border: Border.all(color: Color(0xffEDEDED), width: 0.5),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x0A000000),
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    Assets.icons.backClientIcon.path,
                                    height: 18,
                                    width: 18,
                                  ),
                                  SizedBox(width: 5),
                                  Text('Сменить кабинет', style: AppTextStyles.size16Weight500),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 22),
                        ],
                      ),
                    )
                  : Container(
                      height: 462,
                      padding: const EdgeInsets.only(top: 40),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topRight,
                          transform: GradientRotation(4.2373),
                          colors: [Color(0xFFAD32F8), Color(0xFF3275F8)],
                        ),
                        color: AppColors.mainPurpleColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                      ),
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
                                        Text(
                                          '${_box.read('name')}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: AppColors.kLightBlackColor,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          _box.read('city') ?? 'Алматы',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: AppColors.kGray300,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        InkWell(
                                          onTap: () {
                                            showRolePicker(
                                              context,
                                              isAuthUser ? 'change_cabinet' : 'auth_user',
                                            );
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(builder: (context) => const Base(index: 1)),
                                            // );
                                          },
                                          child: Container(
                                            height: 36,
                                            width: 190,
                                            decoration: BoxDecoration(
                                              color: AppColors.kWhite,
                                              border: Border.all(
                                                color: AppColors.kGray200,
                                                width: 0.2,
                                              ),
                                              borderRadius: BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color(0x0A000000),
                                                  offset: Offset(0, 2),
                                                  blurRadius: 4,
                                                  spreadRadius: 0,
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(width: 13),
                                                Image.asset(
                                                  Assets.icons.backClientIcon.path,
                                                  height: 18,
                                                  width: 18,
                                                ),
                                                SizedBox(width: 9),
                                                Text(
                                                  'Сменить кабинет',
                                                  style: AppTextStyles.size16Weight500,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 24),
                                      ],
                                    ),
                                  ],
                                )
                              : Container(
                                  margin: EdgeInsets.only(left: 16, right: 16, top: 8),
                                  height: 258,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColors.kLightBlackColor.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
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
                                          Text(
                                            'Добро пожаловать!',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 22,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          SizedBox(
                                            width: 320,
                                            child: Text(
                                              'Войдите или зарегистрируйтесь, чтобы открыть весь функционал',
                                              textAlign: TextAlign.center,
                                              style: AppTextStyles.categoryTextStyle.copyWith(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                height: 22 / 16,
                                                color: AppColors.kGray200,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                          isAuthUser ? SizedBox.shrink() : SizedBox(height: 24),
                          isAuthUser
                              ? SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: DefaultButton(
                                    text: isAuthUser ? 'Сменить кабинет' : 'Начать',
                                    press: () {
                                      showRolePicker(
                                        context,
                                        isAuthUser ? 'change_cabinet' : 'auth_user',
                                      );
                                    },
                                    color: AppColors.kLightBlackColor,
                                    backgroundColor: AppColors.kWhite,
                                    textStyle: AppTextStyles.aboutTextStyle.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    width: double.infinity,
                                  ),
                                ),
                        ],
                      ),
                    ),

              isAuthUser
                  ? Container(
                      height: 114,
                      margin: EdgeInsets.symmetric(vertical: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const BonusUserPage()),
                              );
                            },
                            child: Image.asset(
                              Assets.icons.profileClientBonusIcon.path,
                              height: 82,
                              width: 114,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const MyOrderPage()),
                              );
                            },
                            child: Image.asset(
                              Assets.icons.profileClientOrderIcon.path,
                              height: 82,
                              width: 114,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ChatPage()),
                              );
                            },
                            child: Image.asset(
                              Assets.icons.profileClientChatIcon.path,
                              height: 82,
                              width: 114,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),

              Container(
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(top: isAuthUser ? 0 : 16),
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    isAuthUser
                        ? buildProfileItem(
                            onTap: () async {
                              if (!isAuthUser) {
                                GetStorage().remove('token');
                                BlocProvider.of<AppBloc>(context).add(const AppEvent.exiting());
                              } else {
                                final data = await Get.to(
                                  EditProfilePage(
                                    firstName: _box.read('first_name'),
                                    lastName: _box.read('last_name'),
                                    surName: _box.read('sur_name'),
                                    phone: _box.read('phone') ?? '',
                                    gender: _box.read('gender') ?? '',
                                    birthday: _box.read('birthday') ?? '',
                                    email: _box.read('email') ?? '',
                                  ),
                                );

                                if (data != null) {
                                  setState(() {});
                                }
                              }
                            },
                            title: 'Мои данные',
                            iconPath: Assets.icons.sellerProfileDataIcon.path,
                          )
                        : SizedBox.shrink(),

                    buildProfileItem(
                      onTap: () {
                        context.router.push(AddressRoute());
                      },
                      title: 'Cохраненные адреса',
                      iconPath: Assets.icons.locationProfileIcon.path,
                    ),

                    buildProfileItem(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AboutUsPage()),
                        );
                      },
                      title: 'LUNA market',
                      iconPath: Assets.icons.about.path,
                    ),

                    buildProfileItem(
                      onTap: () async {
                        final List<String> options = ['Whats App', 'Telegram', 'Email'];
                        showModuleProfile(context, 'Техподдержка', options, (value) {
                          switch (value) {
                            case 'Whats App':
                              launch("https://t.me/LUNAmarketAdmin", forceSafariVC: false);
                              // do something
                              break;
                            case 'Telegram':
                              launch("https://t.me/LUNAmarketAdmin", forceSafariVC: false);
                              // do something else
                              break;
                            case 'Email':
                              launch("https://t.me/LUNAmarketAdmin", forceSafariVC: false);
                              break;
                          }
                        });
                      },
                      title: 'Техподдержка',
                      iconPath: Assets.icons.supportCenter.path,
                    ),

                    // buildProfileItem(
                    //   onTap: () {},
                    //   switchWidget: true,
                    //   switchValue: switchValue,
                    //   onSwitchChanged: (value) {
                    //     switchValue = value;
                    //     print(value);
                    //     setState(() {});
                    //   },
                    //   title: 'Уведомления',
                    //   iconPath: Assets.icons.sellerNotification.path,
                    // ),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                    //   child: const Divider(
                    //     thickness: 0.2,
                    //     height: 0,
                    //     color: AppColors.kGray200,
                    //   ),
                    // ),

                    // buildProfileItem(
                    //   onTap: () {
                    //     final List<String> languages = [
                    //       'Русский',
                    //       'Қазақша',
                    //       'Английский',
                    //     ];

                    //     showLanguageOptions(context, 'Язык', languages,
                    //         (value) {
                    //       setState(() {});
                    //     });
                    //   },
                    //   title: 'Язык',
                    //   iconPath: Assets.icons.sellerLanguageIcon.path,
                    // ),
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(left: 16.0, right: 16, top: 8),
                    //   child: const Divider(
                    //     thickness: 0.2,
                    //     height: 0,
                    //     color: AppColors.kGray200,
                    //   ),
                    // ),
                    buildProfileItem(
                      onTap: () =>
                          showClientSettingOptions(context, isAuthUser, 'Настройки', () {}),
                      title: 'Настройки',
                      count: 4,
                      iconPath: Assets.icons.settingIcon.path,
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
  const DrawerListTile({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: AppTextStyles.drawer2TextStyle),
          SvgPicture.asset('assets/icons/back_menu.svg'),
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
  required String iconPath,
  required VoidCallback onTap,
  bool? switchWidget,
  int? count,
  ValueChanged<bool>? onSwitchChanged,
  bool? switchValue,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(top: 16.0, right: 16, left: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(iconPath, height: 40, width: 40),
              const SizedBox(width: 12),
              Text(title, style: AppTextStyles.size16Weight600.copyWith(color: Color(0xFF3A3A3C))),
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
                    trackOutlineWidth: WidgetStateProperty.all(0.01),
                  ),
                )
              : (count == null
                    ? SizedBox(
                        width: 8,
                        height: 14,
                        child: Image.asset(Assets.icons.defaultArrowForwardIcon.path),
                      )
                    : Row(
                        children: [
                          Text(
                            '$count',
                            style: AppTextStyles.size16Weight400.copyWith(color: Color(0xFF3A3A3C)),
                          ),
                          SizedBox(width: 16),
                          SizedBox(
                            width: 8,
                            height: 14,
                            child: Image.asset(Assets.icons.defaultArrowForwardIcon.path),
                          ),
                        ],
                      )),
        ],
      ),
    ),
  );
}

Widget buildProfileAvatar(_box) {
  final String? avatar = _box.read('avatar');
  final String? name = _box.read('name');

  final bool isAuthorized =
      avatar != null && avatar != 'null' && name != null && name != 'Не авторизированный';

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
