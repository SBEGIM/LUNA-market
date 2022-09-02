import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/category_admin_page.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/show_alert_statictics_widget.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/home/presentation/widgets/banner_watceh_recently_widget.dart';

class MyProductsAdminPage extends StatefulWidget {
  const MyProductsAdminPage({Key? key}) : super(key: key);

  @override
  State<MyProductsAdminPage> createState() => _MyProductsAdminPageState();
}

class _MyProductsAdminPageState extends State<MyProductsAdminPage> {
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(top: 1.0, right: 100),
          child: Text(
            'HAJI-MARKET',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          DropdownButton(
            elevation: 0,
            icon: const SizedBox.shrink(),
            underline: const SizedBox(),
            items: [
              DropdownMenuItem(
                onTap: () {},
                value: 1,
                child: Row(
                  children: [
                    const Text(
                      "Добавить товар",
                      style: TextStyle(color: Colors.black),
                    ),
                    SvgPicture.asset('assets/icons/lenta1.svg'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 2,
                child: Row(
                  children: [
                    const Text("Добавить видео"),
                    SvgPicture.asset('assets/icons/lenta2.svg'),
                  ],
                ),
              )
            ],
            onChanged: (int? value) {
              setState(() {
                _value = value!;
                _value == 1
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryAdminPage()),
                      )
                    : const SizedBox();
              });
            },
            hint: const Icon(
              Icons.ios_share_rounded,
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: 3,
            itemBuilder: (BuildContext ctx, index) {
              return Stack(
                children: [
                  const BannerWatcehRecently(),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  InkWell(
                    onTap: (){
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
    );
  }
}
