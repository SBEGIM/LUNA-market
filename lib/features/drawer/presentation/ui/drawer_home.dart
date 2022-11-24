import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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

import '../../../../admin/coop_request/presentation/ui/coop_request_page.dart';
import '../widgets/country_widget.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({Key? key}) : super(key: key);

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  bool selected = false;
  final _box = GetStorage();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      // elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 140,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 60),
            color: AppColors.kPrimaryColor,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: Row(
                    children: [
                      Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(21),
                            image: DecorationImage(
                              image: _box.read('avatar') != null
                                  ? NetworkImage(
                                      "http://80.87.202.73:8001/storage/${_box.read('avatar')}")
                                  : AssetImage('assets/icons/profile2.png')
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            )),
                      ),
                      // CircleAvatar(
                      //   backgroundColor: Colors.white,
                      //   radius: 21,
                      //   child: CircleAvatar(
                      //     radius: 20,
                      //     child: SvgPicture.asset('assets/icons/phone.svg'),
                      //   ),
                      // ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('${_box.read('name')}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.white)),
                    ],
                  )),
                  SvgPicture.asset(
                    'assets/icons/back_menu.svg',
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CityPage()),
                  );
                },
                child: const DrawerListTile(
                  text: 'Алматы',
                ),
              ),
              const Divider(
                color: AppColors.kGray200,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationPage()),
                  );
                },
                child: const DrawerListTile(
                  text: 'Уведомления',
                ),
              ),
              const Divider(
                color: AppColors.kGray200,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CatalogPage()),
                  );
                },
                child: const DrawerListTile(
                  text: 'Каталог',
                ),
              ),
              const Divider(
                color: AppColors.kGray200,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CoopRequestPage()),
                  );
                },
                child: const DrawerListTile(
                  text: 'Продавать на Luna market',
                ),
              ),
              const Divider(
                color: AppColors.kGray200,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Base(
                        index: 1,
                      ),
                    ),
                    (route) => false,
                  );
                },
                child: const DrawerListTile(
                  text: 'Маркет',
                ),
              ),
              const Divider(
                color: AppColors.kGray200,
              ),
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
                color: AppColors.kGray200,
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
                color: AppColors.kGray200,
              ),
              GestureDetector(
                onTap: () async {
                  Get.to(const CountryWidget());
                  GetStorage().listen(() {
                    if (GetStorage().read('country_index') != null) {
                      setState(() {
                        index = GetStorage().read('country_index');
                      });
                    }
                  });
                },
                child: Container(
                  height: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 12,
                          ),
                          if (index == 1 || index == 0)
                            SvgPicture.asset('assets/temp/kaz.svg')
                          else if (index == 2)
                            SvgPicture.asset('assets/temp/rus.svg')
                          else if (index == 3)
                            SvgPicture.asset('assets/temp/ukr.svg')
                          else if (index == 4)
                            SvgPicture.asset('assets/temp/bel.svg'),
                          const SizedBox(
                            width: 12,
                          ),
                          if (index == 1 || index == 0)
                            const Text(
                              'Казахстан',
                              style: AppTextStyles.drawer2TextStyle,
                            )
                          else if (index == 2)
                            const Text(
                              'Россия',
                              style: AppTextStyles.drawer2TextStyle,
                            )
                          else if (index == 3)
                            const Text(
                              'Украина',
                              style: AppTextStyles.drawer2TextStyle,
                            )
                          else if (index == 4)
                            const Text(
                              'Беларус',
                              style: AppTextStyles.drawer2TextStyle,
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/back_menu.svg'),
                          const SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const Divider(
            color: AppColors.kGray200,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 67),
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
