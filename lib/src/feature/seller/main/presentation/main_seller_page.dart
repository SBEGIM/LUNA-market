import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:haji_market/src/feature/seller/main/presentation/widget/news_card_widget%20copy.dart';
import 'package:haji_market/src/feature/seller/main/presentation/widget/stories_card_widget.dart';

@RoutePage()
class HomeSellerAdminPage extends StatefulWidget {
  const HomeSellerAdminPage({super.key});

  @override
  State<HomeSellerAdminPage> createState() => _HomeSellerAdminPageState();
}

class _HomeSellerAdminPageState extends State<HomeSellerAdminPage> {
  List<String> images = [
    Assets.images.storyFirst.path,
    Assets.images.storySecond.path,
    Assets.images.storyThirty.path,
    Assets.images.storyForty.path
  ];

  List<CatsModel> news = [
    CatsModel(
        name: 'Продажа со своего склада (realFBS)',
        createdAt:
            'Как подключить доставку любым сторонним перевозчиком или возить заказы покупателямсамостоятельно'),
    CatsModel(
        name: 'Продажа со своего склада (realFBS)',
        createdAt:
            'Как подключить доставку любым сторонним перевозчиком или возить заказы покупателямсамостоятельно'),
    CatsModel(
        name: 'Продажа со своего склада (realFBS)',
        createdAt:
            'Как подключить доставку любым сторонним перевозчиком или возить заказы покупателямсамостоятельно'),
    CatsModel(
        name: 'Продажа со своего склада (realFBS)',
        createdAt:
            'Как подключить доставку любым сторонним перевозчиком или возить заказы покупателямсамостоятельно'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kWhite,
        appBar: AppBar(
          backgroundColor: AppColors.kWhite,
          centerTitle: false,
          title: Text(
            'Главная',
            style: AppTextStyles.defaultAppBarTextStyle
                .copyWith(color: AppColors.mainPurpleColor),
          ),
          actions: [
            Icon(Icons.notifications, color: AppColors.kLightBlackColor)
          ],
          // leading: Icon(Icons.notifications, color: AppColors.kPinkColor),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Get.to(StoryScreen()),
                        child: Container(
                          margin: const EdgeInsets.only(left: 5),
                          padding: const EdgeInsets.all(1),
                          height: 79,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: index == 0
                                  ? AppColors.mainPurpleColor
                                  : Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                10), // 14 - (4 padding + 2 border) = 8, but 10 looks better
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                height: 400,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: news.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(NewsScreen());
                        },
                        child: Container(
                            margin: const EdgeInsets.only(left: 5, bottom: 5),
                            padding: const EdgeInsets.all(1),
                            height: 148,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                transform: const GradientRotation(
                                    4.2373), // 242.73 degrees in radians
                                colors: [
                                  Color(0xFFAD32F8), // #AD32F8
                                  Color(0xFF3275F8), // #3275F8
                                ],
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      news[index].name!,
                                      style: AppTextStyles
                                          .defaultAppBarTextStyle
                                          .copyWith(
                                              color:
                                                  AppColors.kBackgroundColor),
                                    ),
                                  ),
                                  Text(
                                    news[index].createdAt!,
                                    style: AppTextStyles.statisticsTextStyle
                                        .copyWith(color: AppColors.kGray300),
                                  )
                                ],
                              ),
                            )),
                      );
                    }),
              ),
            ),
          ],
        ));
  }
}
