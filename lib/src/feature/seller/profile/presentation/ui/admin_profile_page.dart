import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:haji_market/src/feature/seller/profile/presentation/widgets/admin_cards_page.dart';
import 'package:haji_market/src/feature/seller/profile/presentation/widgets/edit_profile_page.dart';
import 'package:haji_market/src/feature/seller/profile/presentation/widgets/seller_service_page.dart';
import 'package:haji_market/src/feature/seller/profile/presentation/widgets/statistics_admin_show_page.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../drawer/presentation/ui/about_us_page.dart';
import '../../data/bloc/profile_statics_admin_cubit.dart';
import '../../data/bloc/profile_statics_admin_state.dart';
import '../widgets/reqirect_profile_page.dart';

@RoutePage()
class ProfileAdminPage extends StatefulWidget {
  const ProfileAdminPage({Key? key}) : super(key: key);

  @override
  State<ProfileAdminPage> createState() => _ProfileAdminPageState();
}

class _ProfileAdminPageState extends State<ProfileAdminPage> {
  final _box = GetStorage();
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
        backgroundColor: AppColors.kWhite,
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
        body: ListView(children: [
          Column(
            children: [
              SizedBox(height: 24),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_image == null) {
                        Get.defaultDialog(
                          title: "Изменить фото",
                          middleText: '',
                          textConfirm: 'Камера',
                          textCancel: 'Галерея',
                          titlePadding: const EdgeInsets.only(top: 40),
                          onConfirm: () {
                            change = true;
                            _getImage();
                          },
                          onCancel: () {
                            change = false;
                            _getImage();
                          },
                        );
                      }
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: AppColors.kAlpha12,
                          child: CircleAvatar(
                            radius: 59.5,
                            backgroundColor: AppColors.kGray200,
                            backgroundImage: NetworkImage(
                              'https://lunamarket.ru/storage/${GetStorage().read('seller_image')}',
                            ),
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

                  Text(
                    '${GetStorage().read('seller_name')}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.kGray900,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  GetStorage().read('seller_partner') == '1'
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Партнер',
                              style: AppTextStyles.sellerNameTextStyle,
                            ),
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
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              BlocConsumer<ProfileStaticsAdminCubit, ProfileStaticsAdminState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is LoadedState) {
                    return Container(
                      height: 96,
                      decoration: BoxDecoration(
                        color: AppColors.kGray1,
                        borderRadius: BorderRadius.zero,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 72,
                              width: 120,
                              decoration: BoxDecoration(
                                color: AppColors.kWhite,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    state.loadedProfile.videoReview.toString(),
                                    style: AppTextStyles
                                        .counterSellerProfileTextStyle,
                                  ),
                                  const Text(
                                    'Видео обзоры',
                                    style: AppTextStyles
                                        .counterSellerTitleTextStyle,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              height: 72,
                              width: 120,
                              margin: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                color: AppColors.kWhite,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    state.loadedProfile.subscribers.toString(),
                                    style: AppTextStyles
                                        .counterSellerProfileTextStyle,
                                  ),
                                  const Text(
                                    'Товары',
                                    style: AppTextStyles
                                        .counterSellerTitleTextStyle,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              height: 72,
                              width: 120,
                              margin: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                color: AppColors.kWhite,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    state.loadedProfile.sales.toString(),
                                    style: AppTextStyles
                                        .counterSellerProfileTextStyle,
                                  ),
                                  const Text(
                                    'Продажи',
                                    style: AppTextStyles
                                        .counterSellerTitleTextStyle,
                                  ),
                                ],
                              ),
                            )
                          ]),
                    );
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: Colors.indigoAccent));
                  }
                },
              ),
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
                    MaterialPageRoute(
                        builder: (context) => const StatisticsAdminShowPage()),
                  );
                },
                title: 'Мой заработок',
                iconPath: Assets.icons.sellerTransaction.path,
              ),
              buildProfileItem(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SellerServicePage()),
                  );
                },
                title: 'Список сервисов',
                iconPath: Assets.icons.sellerService.path,
              ),
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
              buildProfileItem(
                onTap: () => launch("https://t.me/LUNAmarketAdmin",
                    forceSafariVC: false),
                title: 'Техподдержка',
                iconPath: Assets.icons.supportCenter.path,
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
              buildProfileItem(
                onTap: () {
                  BlocProvider.of<AppBloc>(context).add(
                      const AppEvent.chageState(
                          state: AppState.inAppUserState(index: 1)));
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const Base(index: 1)),
                  // );
                },
                title: 'Вернутся в маркет',
                iconPath: Assets.icons.sellerBack.path,
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

              SizedBox(height: 38),
              DefaultButton(
                  text: 'Выйти из аккаунта ',
                  textStyle: AppTextStyles.defaultButtonTextStyle,
                  press: () {
                    GetStorage().remove('seller_token');
                    GetStorage().remove('seller_id');
                    GetStorage().remove('seller_name');
                    GetStorage().remove('seller_image');

                    BlocProvider.of<AppBloc>(context).add(
                        const AppEvent.chageState(
                            state: AppState.inAppUserState(index: 1)));
                  },
                  color: Colors.black,
                  backgroundColor: AppColors.kButtonColor,
                  width: 358),
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
        ]));
  }
}

Widget buildProfileItem({
  required String title,
  required String iconPath,
  required VoidCallback onTap,
  bool? switchWidget,
  ValueChanged<bool>? onSwitchChanged,
  bool? switchValue,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 15, left: 15),
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
                  fontWeight: FontWeight.w400,
                ),
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
              : const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: AppColors.arrowColor,
                )
        ],
      ),
    ),
  );
}
