import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
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
      child: ListView(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            child: Container(
              color: AppColors.kPrimaryColor,
              padding: const EdgeInsets.only(
                  top: 56.0, left: 16, right: 16, bottom: 16),
              height: 140,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    child: SvgPicture.asset('assets/icons/phone.svg'),
                  ),
                  const Text(
                    'Маржан Жумадилова',
                    style: AppTextStyles.drawer1TextStyle,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  )
                ],
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
                onTap: (){
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
              const DrawerListTile(
                text: 'Маркет',
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
                  color: AppColors.kPrimaryColor,
                ),
              ),
              const Divider(
                color: AppColors.kGray200,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 30),
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
                    child:  Center(
                        child: Text(
                      'Қаз',
                      style:TextStyle(
                        fontSize: 17,
                        color: selected == false ? Colors.black : Colors.white,
                        // AppColors.kLightBlackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                  ),
                ),
                const SizedBox(
                  width: 20,
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
                    child:  Center(
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
    return ListTile(
      title: Text(
        text,
        style: AppTextStyles.drawer2TextStyle,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: AppColors.kPrimaryColor,
      ),
    );
  }
}
