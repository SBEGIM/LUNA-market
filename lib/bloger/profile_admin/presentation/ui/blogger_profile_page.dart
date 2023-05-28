import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/admin/profile_admin/presentation/widgets/about_shop_admin_page.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/auth/presentation/ui/view_auth_register_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../features/app/presentaion/base.dart';
import '../../../auth/presentation/ui/view_auth_register_page.dart';
import '../../../my_products_admin/presentation/widgets/statistics_blogger_show_page.dart';
import '../../../my_products_admin/presentation/widgets/statistics_page.dart';
import '../data/bloc/profile_statics_blogger_cubit.dart';
import '../data/bloc/profile_statics_blogger_state.dart';
import '../widgets/reqirect_profile_page.dart';
import 'blogger_cards_page.dart';

class ProfileBloggerPage extends StatefulWidget {
  const ProfileBloggerPage({Key? key}) : super(key: key);

  @override
  State<ProfileBloggerPage> createState() => _ProfileBloggerPageState();
}

class _ProfileBloggerPageState extends State<ProfileBloggerPage> {
  final _box = GetStorage();

  @override
  void initState() {
    BlocProvider.of<ProfileStaticsBloggerCubit>(context).statics();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        // iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
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
          'Профиль блогера',
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        // actions: [
        //   Padding(
        //       padding: const EdgeInsets.only(right: 16.0),
        //       child: SvgPicture.asset('assets/icons/notification.svg'))
        // ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            horizontalTitleGap: 12,
            leading: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  image: DecorationImage(
                    image: _box.read('blogger_avatar') != null
                        ? NetworkImage(
                            "http://185.116.193.73/storage/${_box.read('blogger_avatar')}")
                        : const AssetImage('assets/icons/profile2.png')
                            as ImageProvider,
                    fit: BoxFit.cover,
                  )),
            ),
            title: Text(
              _box.read('blogger_name'),
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.kGray900,
                  fontSize: 16),
            ),
            subtitle: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ReqirectProfilePage()),
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
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            width: 500,
            height: 76,
            child: BlocConsumer<ProfileStaticsBloggerCubit,
                ProfileStaticsBloggerState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is LoadedState) {
                  return Container(
                    padding: const EdgeInsets.only(top: 16, left: 16),
                    alignment: Alignment.center,
                    //  height: 76,
                    // width: 343,
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                state.loadedProfile.videoReview.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              const Text(
                                'Видео обзоров',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(width: 40),
                          Column(
                            children: [
                              Text(
                                state.loadedProfile.subscribers.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              const Text(
                                'Подписчиков',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(width: 40),
                          Column(
                            children: [
                              Text(
                                state.loadedProfile.sales.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              const Text(
                                'Продаж',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ]),
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: Colors.indigoAccent));
                }
              },
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

          // const Divider(
          //   color: AppColors.kGray400,
          // ),
          const SizedBox(height: 12),

          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const StatisticsBloggerShowPage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, bottom: 15, right: 15, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Мой заработок',
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
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BloggerCardPage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, bottom: 15, right: 15, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Способ оплаты',
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
            onTap: () {
              onTap:
              () => launch("https://t.me/LUNAmarketru", forceSafariVC: false);
            },
            child: Padding(
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
          ),
          const Divider(
            color: AppColors.kGray400,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Base(index: 1)),
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
                        'Вернуться на маркет',
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
          GestureDetector(
            onTap: () {
              GetStorage().remove('blogger_token');
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BlogAuthRegisterPage()),
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
                            color: Color(0xffff3347c),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SvgPicture.asset('assets/icons/logout.svg')
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
