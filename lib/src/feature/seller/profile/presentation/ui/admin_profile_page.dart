import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/bloger/profile/presentation/widgets/show_module_profile_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/client_show_image_list_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/show_alert_account_widget.dart';
import 'package:haji_market/src/feature/seller/profile/data/bloc/profile_edit_admin_cubit.dart'
    as edit_cubit;
import 'package:haji_market/src/feature/seller/profile/presentation/ui/seller_show_list_widget.dart';
import 'package:haji_market/src/feature/seller/profile/presentation/widgets/edit_profile_page.dart';
import 'package:haji_market/src/feature/seller/profile/presentation/widgets/seller_service_page.dart';
import 'package:haji_market/src/feature/seller/profile/presentation/widgets/seller_visit_card_page.dart';
import 'package:haji_market/src/feature/seller/profile/presentation/widgets/statistics_admin_show_page.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:haji_market/src/feature/drawer/presentation/ui/about_us_page.dart';
import 'package:haji_market/src/feature/seller/profile/data/bloc/profile_statics_admin_cubit.dart';

@RoutePage()
class ProfileAdminPage extends StatefulWidget {
  const ProfileAdminPage({super.key});

  @override
  State<ProfileAdminPage> createState() => _ProfileAdminPageState();
}

class _ProfileAdminPageState extends State<ProfileAdminPage> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  bool change = false;

  Future<void> _getImage(context) async {
    final image = change == true
        ? await _picker.pickImage(source: ImageSource.camera)
        : await _picker.pickImage(source: ImageSource.gallery);

    print(' ${image!.path}');
    BlocProvider.of<edit_cubit.ProfileEditAdminCubit>(context).edit(
      '',
      '',
      image.path,
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      null,
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
    );

    setState(() {
      _image = image;
    });
  }

  bool? switchValue;
  @override
  void initState() {
    BlocProvider.of<ProfileStaticsAdminCubit>(context).statics();
    switchValue = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kGray1,
      resizeToAvoidBottomInset: false,
      // backgroundColor: AppColors.kBackgroundColor,
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // leading: IconButton(
      //   onPressed: () {
      //     BlocProvider.of<AppBloc>(context).add(const AppEvent.chageState(
      //         state: AppState.inAppUserState(index: 1)));
      //   },
      //   icon: const Icon(
      //     Icons.arrow_back_ios,
      //     color: AppColors.kPrimaryColor,
      //   ),
      // ),
      // centerTitle: true,
      // title: const Text(
      //   'Профиль продавца',
      //   style: TextStyle(
      //     color: Colors.black,
      //   ),
      // ),
      // actions: [
      //   Padding(
      //       padding: const EdgeInsets.only(right: 16.0),
      //       child: SvgPicture.asset('assets/icons/notification.svg'))
      // ],
      // ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
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
                    SizedBox(height: 24),
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
                                            'https://lunamarket.ru/storage/${GetStorage().read('seller_image')}',
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

                    Text(
                      '${GetStorage().read('seller_name')}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.kGray900,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    GetStorage().read('seller_partner') == '1'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Партнер', style: AppTextStyles.sellerNameTextStyle),
                              SizedBox(width: 5),
                              SvgPicture.asset(Assets.icons.sellerIcon.path),
                            ],
                          )
                        : const SizedBox(),

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
                    SizedBox(height: 12),
                    InkWell(
                      onTap: () {
                        BlocProvider.of<AppBloc>(
                          context,
                        ).add(const AppEvent.chageState(state: AppState.inAppUserState(index: 1)));
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
                          border: Border.all(color: AppColors.kGray200, width: 0.2),
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
                            Image.asset(Assets.icons.backClientIcon.path, height: 18, width: 18),
                            SizedBox(width: 9),
                            Text('Вернутся в маркет', style: AppTextStyles.size16Weight500),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 22),
                  ],
                ),
              ),
              Container(height: 12, color: AppColors.kGray1),
              // BlocConsumer<ProfileStaticsAdminCubit, ProfileStaticsAdminState>(
              //   listener: (context, state) {},
              //   builder: (context, state) {
              //     if (state is LoadedState) {
              //       return
              //     } else {
              //       return const Center(
              //           child: CircularProgressIndicator(
              //               color: Colors.indigoAccent));
              //     }
              //   },
              // ),
              Container(
                height: 114,
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        context.pushRoute(TapeSellerRoute());
                      },
                      child: SizedBox(
                        height: 82,
                        width: 175,
                        child: Image.asset(Assets.icons.frameVideoReview.path, scale: 2),
                      ),
                    ),
                    SizedBox(
                      height: 82,
                      width: 175,
                      child: Image.asset(Assets.icons.framePromotion.path, scale: 2),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    buildProfileItem(
                      onTap: () async {
                        final data = await Get.to(EditProfilePage());
                        if (data != null) {
                          setState(() {});
                        }
                      },
                      title: 'Мои данные',
                      iconPath: Assets.icons.sellerProfileDataIcon.path,
                    ),
                    buildProfileItem(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const StatisticsAdminShowPage()),
                        );
                      },
                      title: 'Аналитика продаж',
                      iconPath: Assets.icons.sellerTransaction.path,
                    ),
                    buildProfileItem(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SellerVisitCardPage()),
                        );
                      },
                      title: 'Визитная карточка',
                      iconPath: Assets.icons.visitCardIcon.path,
                    ),
                    buildProfileItem(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SellerServicePage()),
                        );
                      },
                      title: 'Сервисы',
                      iconPath: Assets.icons.sellerService.path,
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
                      onTap: () {
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
                              launch("http://Lunamarket@inbox.ru", forceSafariVC: false);
                              break;
                          }
                        });
                      },
                      title: 'Техподдержка',
                      iconPath: Assets.icons.supportCenter.path,
                    ),

                    buildProfileItem(
                      onTap: () => showSellerSettingOptions(context, 'Настройка', () {}),
                      title: 'Настройка',
                      count: 4,
                      iconPath: Assets.icons.settingIcon.path,
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),

              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => AdminCardPage(
              //                 check: _box.read('seller_check'),
              //                 card: _box.read('seller_card'),
              //               )),
              //     );
              //   },
              //   child: Padding(
              //     padding: EdgeInsets.only(top: 16.0, right: 15, left: 15),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Row(
              //           children: [
              //             Image.asset(
              //               Assets.icons.sellerProfileDataIcon.path,
              //               height: 40,
              //               width: 40,
              //             ),
              //             SizedBox(width: 12),
              //             Text(
              //               'Способ оплаты',
              //               style: TextStyle(
              //                   color: AppColors.kGray900,
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.w400),
              //             ),
              //           ],
              //         ),
              //         Icon(
              //           Icons.arrow_forward_ios,
              //           size: 14,
              //           color: AppColors.arrowColor,
              //         )
              //       ],
              //     ),
              //   ),
              // ),

              // GestureDetector(
              //   onTap: () {},
              //   child: Container(
              //     padding: const EdgeInsets.only(
              //         left: 16, right: 16, top: 10, bottom: 10),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         const Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               'Выйти',
              //               style: TextStyle(
              //                   color: Color(0xffff3347c),
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.w400),
              //             ),
              //           ],
              //         ),
              //         SvgPicture.asset('assets/icons/logout.svg')
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
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
