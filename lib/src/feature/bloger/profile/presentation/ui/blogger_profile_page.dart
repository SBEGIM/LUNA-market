import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/bloc/app_bloc.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:haji_market/src/feature/bloger/profile/presentation/ui/blogger_visit_card_page.dart';
import 'package:haji_market/src/feature/bloger/profile/presentation/widgets/blogger_show_list_widget.dart';
import 'package:haji_market/src/feature/bloger/profile/presentation/widgets/edit_profile_page.dart';
import 'package:haji_market/src/feature/drawer/presentation/ui/about_us_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/constant/generated/assets.gen.dart';
import '../../../shop/presentation/widgets/statistics_blogger_show_page.dart';
import '../../bloc/profile_statics_blogger_cubit.dart';
import '../../bloc/profile_statics_blogger_state.dart';
import '../widgets/reqirect_profile_page.dart';
import 'blogger_cards_page.dart';

@RoutePage()
class ProfileBloggerPage extends StatefulWidget {
  const ProfileBloggerPage({Key? key}) : super(key: key);

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
  final avatarUrl =
      'https://lunamarket.ru/storage/${GetStorage().read('blogger_avatar')}';
  RefreshController _controller = RefreshController();

  @override
  void initState() {
    BlocProvider.of<ProfileStaticsBloggerCubit>(context)
        .statics(int.parse(_box.read('blogger_id')));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 80),
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
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(120),
                  child: Image.network(
                    avatarUrl,
                    fit: BoxFit.fill,
                    height: 90,
                    width: 90,
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
            style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.kGray900,
                fontSize: 16),
          ),
          const SizedBox(height: 5),
          // GetStorage().read('seller_partner') == '1'
          //     ?

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Блогер',
                style: AppTextStyles.sellerNameTextStyle,
              ),
              SizedBox(width: 5),
              SvgPicture.asset(Assets.icons.sellerIcon.path),
            ],
          ),

          SizedBox(height: 12),
          InkWell(
            onTap: () {
              BlocProvider.of<AppBloc>(context).add(const AppEvent.chageState(
                  state: AppState.inAppUserState(index: 1)));
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
                    'Вернутся в маркет',
                    style: AppTextStyles.size16Weight500,
                  )
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 24,
          ),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   alignment: Alignment.center,
          //   width: 500,
          //   height: 76,
          //   child: BlocConsumer<ProfileStaticsBloggerCubit,
          //       ProfileStaticsBloggerState>(
          //     listener: (context, state) {},
          //     builder: (context, state) {
          //       if (state is LoadedState) {
          //         return Container(
          //           padding: const EdgeInsets.only(top: 16, left: 16),
          //           alignment: Alignment.center,
          //           //  height: 76,
          //           // width: 343,
          //           decoration: BoxDecoration(
          //             color: AppColors.kPrimaryColor,
          //             borderRadius: BorderRadius.circular(8),
          //           ),
          //           child: Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               // crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //                 Column(
          //                   children: [
          //                     Text(
          //                       state.loadedProfile.videoReview.toString(),
          //                       style: const TextStyle(
          //                           color: Colors.white,
          //                           fontSize: 20,
          //                           fontWeight: FontWeight.w600),
          //                     ),
          //                     const Text(
          //                       'Видео обзоров',
          //                       style: TextStyle(
          //                           color: Colors.white,
          //                           fontSize: 12,
          //                           fontWeight: FontWeight.w500),
          //                     ),
          //                   ],
          //                 ),
          //                 const SizedBox(width: 40),
          //                 Column(
          //                   children: [
          //                     Text(
          //                       state.loadedProfile.subscribers.toString(),
          //                       style: const TextStyle(
          //                           color: Colors.white,
          //                           fontSize: 20,
          //                           fontWeight: FontWeight.w600),
          //                     ),
          //                     const Text(
          //                       'Подписчиков',
          //                       style: TextStyle(
          //                           color: Colors.white,
          //                           fontSize: 12,
          //                           fontWeight: FontWeight.w500),
          //                     ),
          //                   ],
          //                 ),
          //                 const SizedBox(width: 40),
          //                 Column(
          //                   children: [
          //                     Text(
          //                       state.loadedProfile.sales.toString(),
          //                       style: const TextStyle(
          //                           color: Colors.white,
          //                           fontSize: 20,
          //                           fontWeight: FontWeight.w600),
          //                     ),
          //                     const Text(
          //                       'Продаж',
          //                       style: TextStyle(
          //                           color: Colors.white,
          //                           fontSize: 12,
          //                           fontWeight: FontWeight.w500),
          //                     ),
          //                   ],
          //                 ),
          //               ]),
          //         );
          //       } else {
          //         return const Center(
          //             child: CircularProgressIndicator(
          //                 color: Colors.indigoAccent));
          //       }
          //     },
          //   ),
          // ),

          BlocConsumer<ProfileStaticsBloggerCubit, ProfileStaticsBloggerState>(
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 72,
                          width: 130,
                          decoration: BoxDecoration(
                            color: AppColors.kWhite,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.loadedProfile.videoReview.toString(),
                                style:
                                    AppTextStyles.counterSellerProfileTextStyle,
                              ),
                              const Text(
                                'Видео обзоры',
                                style:
                                    AppTextStyles.counterSellerTitleTextStyle,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          height: 72,
                          width: 130,
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
                                style:
                                    AppTextStyles.counterSellerProfileTextStyle,
                              ),
                              const Text(
                                'Подписчики',
                                style:
                                    AppTextStyles.counterSellerTitleTextStyle,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          height: 72,
                          width: 130,
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
                                style:
                                    AppTextStyles.counterSellerProfileTextStyle,
                              ),
                              const Text(
                                'Продажи',
                                style:
                                    AppTextStyles.counterSellerTitleTextStyle,
                              ),
                            ],
                          ),
                        )
                      ]),
                );
              } else {
                return const Center(
                    child:
                        CircularProgressIndicator(color: Colors.indigoAccent));
              }
            },
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

          // const Divider(
          //   color: AppColors.kGray400,
          // ),
          const SizedBox(height: 12),
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
                MaterialPageRoute(
                    builder: (context) => const StatisticsBloggerShowPage()),
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
          // buildProfileItem(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => BloggerCardPage(
          //                 check: _box.read('blogger_invoice') ?? '',
          //                 card: _box.read('blogger_card') ?? '',
          //               )),
          //     );
          //   },
          //   title: 'Cпособ оплаты',
          //   iconPath: Assets.icons.about.path,
          // ),
          buildProfileItem(
            onTap: () =>
                launch("https://t.me/LUNAmarketAdmin", forceSafariVC: false),
            title: 'Техподдержка',
            iconPath: Assets.icons.supportCenter.path,
          ),

          buildProfileItem(
            onTap: () => showBloggerSettingOptions(context, 'Настройка', () {}),
            title: 'Настройка',
            count: 3,
            iconPath: Assets.icons.settingIcon.path,
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
          // buildProfileItem(
          //   onTap: () {
          //     BlocProvider.of<AppBloc>(context).add(const AppEvent.chageState(
          //         state: AppState.inAppUserState(index: 1)));
          //     // Navigator.push(
          //     //   context,
          //     //   MaterialPageRoute(builder: (context) => const Base(index: 1)),
          //     // );
          //   },
          //   title: 'Вернутся в маркет',
          //   iconPath: Assets.icons.sellerBack.path,
          // ),
          Spacer(),
          // SafeArea(
          //   top: false,
          //   child: Padding(
          //     padding: const EdgeInsets.all(12.0),
          //     child: DefaultButton(
          //       width: double.infinity,
          //       text: 'Выйти из аккаунта ',
          //       textStyle: AppTextStyles.defaultButtonTextStyle,
          //       press: () {
          //         GetStorage().remove('blogger_token');
          //         BlocProvider.of<AppBloc>(context).add(
          //             const AppEvent.chageState(
          //                 state: AppState.inAppUserState(index: 1)));
          //       },
          //       color: Colors.black,
          //       backgroundColor: AppColors.kButtonColor,
          //     ),
          //   ),
          // ),
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
              : (count == null
                  ? const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: AppColors.arrowColor,
                    )
                  : Row(
                      children: [
                        Text(
                          '$count',
                          style: AppTextStyles.size16Weight400,
                        ),
                        SizedBox(width: 6),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: AppColors.arrowColor,
                        )
                      ],
                    ))
        ],
      ),
    ),
  );
}
