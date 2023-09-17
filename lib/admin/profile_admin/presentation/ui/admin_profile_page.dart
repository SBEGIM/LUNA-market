import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/admin/profile_admin/presentation/widgets/admin_cards_page.dart';
import 'package:haji_market/admin/profile_admin/presentation/widgets/statistics_admin_show_page.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/bloc/app_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../features/drawer/presentation/ui/about_us_page.dart';
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

  @override
  void initState() {
    BlocProvider.of<ProfileStaticsAdminCubit>(context).statics();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
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
          'Профиль продавца',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(padding: const EdgeInsets.only(right: 16.0), child: SvgPicture.asset('assets/icons/notification.svg'))
        ],
      ),
      body: Column(
        children: [
          ListTile(
            horizontalTitleGap: 12,
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                "http://185.116.193.73/storage/${GetStorage().read('seller_image')}",
              ),
              radius: 34,

              // child: Align(
              //   alignment: Alignment.bottomRight,
              //   child: SvgPicture.asset(
              //     'assets/icons/camera.svg',
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ),
            title: Text(
              '${GetStorage().read('seller_name')}',
              style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.kGray900, fontSize: 16),
            ),
            subtitle: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReqirectProfilePage()),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  const Text(
                    'Редактирование',
                    style: TextStyle(color: AppColors.kPrimaryColor, fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 5),
                  GetStorage().read('seller_partner') == '1'
                      ? const Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Color(0xff42BB5D),
                              size: 18,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Партнер',
                              style: TextStyle(color: Color(0xff42BB5D), fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            width: 500,
            height: 76,
            child: BlocConsumer<ProfileStaticsAdminCubit, ProfileStaticsAdminState>(
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
                                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              const Text(
                                'Видео обзоров',
                                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(width: 40),
                          Column(
                            children: [
                              Text(
                                state.loadedProfile.subscribers.toString(),
                                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              const Text(
                                'Подписчиков',
                                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(width: 40),
                          Column(
                            children: [
                              Text(
                                state.loadedProfile.sales.toString(),
                                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              const Text(
                                'Продаж',
                                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ]),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
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

          const Divider(
            color: AppColors.kGray400,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StatisticsAdminShowPage()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15, right: 15, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Мой заработок',
                    style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w400),
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
                    builder: (context) => AdminCardPage(
                          check: _box.read('seller_check'),
                          card: _box.read('seller_card'),
                        )),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15, right: 15, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Способ оплаты',
                    style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w400),
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
            onTap: () => launch("https://t.me/LUNAmarketAdmin", forceSafariVC: false),
            child: const Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15, right: 15, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Связаться с администрацией',
                    style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w400),
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
                MaterialPageRoute(builder: (context) => const AboutUsPage()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15, right: 15, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'О нас',
                    style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w400),
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
              BlocProvider.of<AppBloc>(context)
                  .add(const AppEvent.chageState(state: AppState.inAppUserState(index: 1)));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const Base(index: 1)),
              // );
            },
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Вернуться на маркет',
                        style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Icon(
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
              GetStorage().remove('seller_token');
              GetStorage().remove('seller_id');
              GetStorage().remove('seller_name');
              GetStorage().remove('seller_image');

              BlocProvider.of<AppBloc>(context)
                  .add(const AppEvent.chageState(state: AppState.inAppUserState(index: 1)));
            },
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Выйти',
                        style: TextStyle(color: Color(0xffff3347c), fontSize: 16, fontWeight: FontWeight.w400),
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
