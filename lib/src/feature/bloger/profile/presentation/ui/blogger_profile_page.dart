import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:haji_market/src/feature/bloger/profile/presentation/ui/blogger_visit_card_page.dart';
import 'package:haji_market/src/feature/bloger/profile/presentation/widgets/blogger_show_list_widget.dart';
import 'package:haji_market/src/feature/bloger/profile/presentation/widgets/edit_profile_page.dart';
import 'package:haji_market/src/feature/bloger/profile/presentation/widgets/show_module_profile_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/ui/about_us_page.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/client_show_image_list_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/show_alert_account_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/bloger/shop/presentation/widgets/statistics_blogger_show_page.dart';
import 'package:haji_market/src/feature/bloger/profile/bloc/profile_statics_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/profile/bloc/profile_statics_blogger_state.dart';

@RoutePage()
class ProfileBloggerPage extends StatefulWidget {
  const ProfileBloggerPage({super.key});

  @override
  State<ProfileBloggerPage> createState() => _ProfileBloggerPageState();
}

class _ProfileBloggerPageState extends State<ProfileBloggerPage> {
  final _box = GetStorage();
  bool? switchValue;
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

  final avatarPath = GetStorage().read('blogger_avatar');
  final avatarUrl = 'https://lunamarket.ru/storage/${GetStorage().read('blogger_avatar')}';

  @override
  void initState() {
    BlocProvider.of<ProfileStaticsBloggerCubit>(
      context,
    ).statics(int.parse(_box.read('blogger_id')));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundModuleColor,
      appBar: null,
      body: SingleChildScrollView(
        child: Column(
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
                children: [
                  SizedBox(height: 80),
                  GestureDetector(
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
                            _getImage();
                          } else {
                            change = false;
                            _getImage();
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
                      alignment: Alignment.center,
                      children: [
                        ClipOval(
                          child: _image != null
                              ? Image.file(
                                  File(_image!.path), // <— XFile -> File
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  avatarUrl, // аватар с сети
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover, // не искажает, в отличие от fill
                                  // индикатор загрузки
                                  loadingBuilder: (ctx, child, progress) {
                                    if (progress == null) return child;
                                    return Container(
                                      width: 90,
                                      height: 90,
                                      color: const Color(0xFFE9ECEF),
                                      alignment: Alignment.center,
                                      child: const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      ),
                                    );
                                  },
                                  // fallback если ошибка/битая ссылка
                                  errorBuilder: (ctx, error, stack) {
                                    return Container(
                                      width: 90,
                                      height: 90,
                                      color: const Color(0xFFE9ECEF),
                                      alignment: Alignment.center,
                                      child: Icon(Icons.person, size: 36, color: Colors.grey[500]),
                                    );
                                  },
                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image.asset(
                            Assets.icons.sellerCameraIcon.path,
                            height: 28,
                            width: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${GetStorage().read('blogger_nick_name')}',
                    style: AppTextStyles.size18Weight600,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Блогер', style: AppTextStyles.size16Weight500),
                      SizedBox(width: 5),
                      SizedBox(
                        height: 21,
                        width: 21,
                        child: SvgPicture.asset(Assets.icons.sellerIcon.path),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<AppBloc>(
                        context,
                      ).add(const AppEvent.chageState(state: AppState.inAppUserState(index: 1)));
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
                  SizedBox(height: 24),
                ],
              ),
            ),
            SizedBox(height: 12),
            BlocConsumer<ProfileStaticsBloggerCubit, ProfileStaticsBloggerState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is LoadedState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 72,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.kWhite,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.loadedProfile.videoReview.toString(),
                                style: AppTextStyles.counterSellerProfileTextStyle,
                              ),
                              const Text(
                                'Видео обзоры',
                                style: AppTextStyles.counterSellerTitleTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          height: 72,
                          width: double.infinity,
                          margin: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: AppColors.kWhite,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.loadedProfile.subscribers.toString(),
                                style: AppTextStyles.counterSellerProfileTextStyle,
                              ),
                              const Text(
                                'Подписчики',
                                style: AppTextStyles.counterSellerTitleTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          height: 72,
                          width: double.infinity,
                          margin: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: AppColors.kWhite,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.loadedProfile.sales.toString(),
                                style: AppTextStyles.counterSellerProfileTextStyle,
                              ),
                              const Text(
                                'Продажи',
                                style: AppTextStyles.counterSellerTitleTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
                }
              },
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
                      final data = await Get.to(EditProfileBloggerPage());

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
                        MaterialPageRoute(builder: (context) => BloggerVisitCardPage()),
                      );
                    },
                    title: 'Визитная карточка',
                    iconPath: Assets.icons.visitCardIcon.path,
                  ),
                  buildProfileItem(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const StatisticsBloggerShowPage()),
                      );
                    },
                    title: 'Аналитика продаж',
                    iconPath: Assets.icons.sellerTransaction.path,
                  ),
                  buildProfileItem(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AboutUsPage()),
                      );
                    },
                    title: 'О нас',
                    iconPath: Assets.icons.about.path,
                  ),
                  buildProfileItem(
                    onTap: () {
                      // launch("https://t.me/LUNAmarketAdmin",
                      //                       forceSafariVC: false);

                      final List<String> options = ['Whats App', 'Telegram', 'Email'];
                      showModuleProfile(context, 'Техподдержка', '', options, (value) {
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
                  buildProfileItem(
                    onTap: () => showBloggerSettingOptions(context, 'Настройка', () {}),
                    title: 'Настройка',
                    count: 4,
                    iconPath: Assets.icons.settingIcon.path,
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
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
