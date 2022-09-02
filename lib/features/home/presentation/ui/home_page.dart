import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/drawer/presentation/ui/drawer_home.dart';
import 'package:haji_market/features/home/presentation/widgets/banner_watceh_recently_widget.dart';
import 'package:haji_market/features/home/presentation/widgets/gridLayout_popular.dart';
import 'package:haji_market/features/home/presentation/widgets/gridLayout_popular_shop.dart';
import 'package:haji_market/features/home/presentation/widgets/gridlayout_categor.dart';
import 'package:haji_market/features/home/presentation/widgets/stocks_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List images = [
    'assets/images/reclama.png',
    'assets/images/reclama.png',
    'assets/images/reclama.png'
  ];

  final List<Map> myProducts =
      List.generate(6, (index) => {"id": index, "name": "Product "}).toList();

  late List<GridLayoutCategory> options = [
    GridLayoutCategory(
      title: 'Скидки',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StocksPage()),
        );
      },
      icon: 'assets/icons/phone.svg',
    ),
    GridLayoutCategory(
      title: 'Cмартфоны',
      icon: 'assets/icons/phone.svg',
    ),
    GridLayoutCategory(
      title: 'Аптека',
      icon: 'assets/icons/phone.svg',
    ),
    GridLayoutCategory(
      title: 'Скидки',
      icon: 'assets/icons/phone.svg',
    ),
    GridLayoutCategory(
      title: 'Игрушки',
      icon: 'assets/icons/phone.svg',
    ),
    GridLayoutCategory(
      title: 'Cмартфоны',
      icon: 'assets/icons/phone.svg',
      // ontap1: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerHome(),
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: const Icon(
        //   Icons.menu,
        //   color: AppColors.kPrimaryColor,
        // ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 22.0),
            child: Icon(
              Icons.search,
            ),
          )
        ],
        title: const Text(
          'HAJI-MARKET',
          style: AppTextStyles.appBarTextStylea,
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: const <Widget>[
                  BannerImage(),
                  BannerImage(),
                  BannerImage(),
                  BannerImage(),
                ])),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Категории',
                    style: AppTextStyles.appBarTextStylea,
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 2 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemCount: myProducts.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GridOptionsCategory(
                          layout: options[index],
                        );
                      }),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Категории',
                    style: AppTextStyles.appBarTextStylea,
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 2 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemCount: myProducts.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GridOptionsPopular(
                          layout: optionsPopular[index],
                        );
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Все предложения',
                        style: AppTextStyles.kcolorPrimaryTextStyle,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.kPrimaryColor,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Популярные магазины',
                    style: AppTextStyles.appBarTextStylea,
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 2 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemCount: myProducts.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return GridOptionsPopularShop(
                          layout: optionsPopularshop[index],
                        );
                      }),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Все предложения',
                        style: AppTextStyles.kcolorPrimaryTextStyle,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.kPrimaryColor,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Вы недавно смотрели',
                    style: AppTextStyles.appBarTextStylea,
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: const <Widget>[
                        BannerWatcehRecently(),
                        BannerWatcehRecently(),
                        BannerWatcehRecently(),
                        BannerWatcehRecently(),
                      ])),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Вас могут заинтересовать',
                    style: AppTextStyles.appBarTextStylea,
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: const <Widget>[
                        BannerWatcehRecently(),
                        BannerWatcehRecently(),
                        BannerWatcehRecently(),
                        BannerWatcehRecently(),
                      ])),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Партнерам',
                    style: AppTextStyles.appBarTextStylea,
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text(
                    'Кабинет продавца',
                    style: AppTextStyles.kcolorPrimaryTextStyle,
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text(
                    'Начать продавать с «»',
                    style: AppTextStyles.kcolorPrimaryTextStyle,
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text(
                    'Договор присоединения',
                    style: AppTextStyles.kcolorPrimaryTextStyle,
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Text(
                    'Договор по оказанию услуги доставки',
                    style: AppTextStyles.kcolorPrimaryTextStyle,
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BannerImage extends StatelessWidget {
  const BannerImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/reclama.png'),
          const SizedBox(
            height: 8,
          ),
          const Text(
            '15 июля - 17 июля',
            style: AppTextStyles.bannerTextStyle,
          )
        ],
      ),
    );
  }
}


