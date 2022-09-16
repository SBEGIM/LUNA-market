import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/admin/my_products_admin/bloc/models/menu_items_data.dart';
import 'package:haji_market/admin/my_products_admin/presentation/ui/banner_watch_recently_admin_page.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/category_admin_page.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/show_alert_statictics_widget.dart';
import 'package:haji_market/core/common/constants.dart';

class MyProductsAdminPage extends StatefulWidget {
  const MyProductsAdminPage({Key? key}) : super(key: key);

  @override
  State<MyProductsAdminPage> createState() => _MyProductsAdminPageState();
}

class _MyProductsAdminPageState extends State<MyProductsAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: Column(
        // shrinkWrap: true,
        children: [
          Container(
            color: Colors.white,
            height: 50,
          ),
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    'HAJI-MARKET',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.kGray900),
                  ),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    // your logic
                    if (value == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryAdminPage()),
                      );
                    }
                  },
                  itemBuilder: (BuildContext bc) {
                    return [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Text(
                              "Добавить товар",
                              style: TextStyle(color: Colors.black),
                            ),
                            SvgPicture.asset('assets/icons/lenta1.svg'),
                          ],
                        ),
                        value: 0,
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Text("Добавить видео"),
                            SvgPicture.asset('assets/icons/lenta2.svg'),
                          ],
                        ),
                        value: 1,
                      ),
                    ];
                  },
                  icon: SvgPicture.asset('assets/icons/plus.svg'),
                ),
              ],
            ),
          ),
          Container(
            height: 20,
            color: AppColors.kBackgroundColor,
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 16),
                  itemCount: 4,
                  itemBuilder: (BuildContext ctx, index) {
                    return Stack(
                      children: [
                        const BannerWatcehRecentlyAdminPage(),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        InkWell(
                          onTap: () {
                            showAlertStaticticsWidget(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Icon(
                                  Icons.more_vert_rounded,
                                  color: AppColors.kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
