import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/presentaion/base.dart';
import 'package:haji_market/features/drawer/presentation/ui/about_us_page.dart';
import 'package:haji_market/features/drawer/presentation/ui/catalog_page.dart';
import 'package:haji_market/features/drawer/presentation/ui/city_page.dart';
import 'package:haji_market/features/profile/data/presentation/ui/notification_page.dart';
import 'package:haji_market/features/profile/data/presentation/ui/profile_page.dart';

import '../../../../admin/coop_request/presentation/ui/coop_request_page.dart';

class DrawerHome extends StatefulWidget {
  const DrawerHome({Key? key}) : super(key: key);

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 140,
            color: AppColors.kPrimaryColor,
            child: DrawerHeader(
              decoration: BoxDecoration(
                border: Border(
                  bottom: Divider.createBorderSide(context,
                      color: AppColors.kPrimaryColor, width: 0.0),
                ),
                // color: AppColors.kPrimaryColor,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 30,
                      child: CircleAvatar(
                        radius: 28,
                        child: SvgPicture.asset('assets/icons/phone.svg'),
                      ),
                    ),
                    const Text(
                      'Маржан Жумадилова',
                      style: AppTextStyles.drawer1TextStyle,
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
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
                  text: 'Продавать на Хаджи маркет',
                ),
              ),
              const Divider(
                color: AppColors.kGray200,
              ),
              InkWell(
                onTap: (){
                    Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const Base(
                  index: 0,
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUsPage()),
                  );
                },
                child: const DrawerListTile(
                  text: 'Связаться с администрацией',
                ),
              ),
              const Divider(
                color: AppColors.kGray200,
              ),
              ListTile(
                title: Row(
                  children: [
                    SvgPicture.asset('assets/temp/kaz.svg'),
                    const SizedBox(
                      width: 12,
                    ),
                    const Text(
                      'Казахстан',
                      style: AppTextStyles.drawer2TextStyle,
                    ),
                  ],
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: AppColors.kPrimaryColor,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 90),
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
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: AppTextStyles.drawer2TextStyle,
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 14,
            color: AppColors.kPrimaryColor,
          ),
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
