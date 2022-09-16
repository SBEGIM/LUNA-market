import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/drawer/presentation/ui/catalog_page.dart';
import 'package:haji_market/features/drawer/presentation/ui/drawer_home.dart';
import 'package:haji_market/features/home/presentation/widgets/banner_watceh_recently_widget.dart';
import 'package:haji_market/features/home/presentation/widgets/bonus_page.dart';
import 'package:haji_market/features/home/presentation/widgets/gridLayout_popular.dart';
import 'package:haji_market/features/home/presentation/widgets/gridLayout_popular_shop.dart';
import 'package:haji_market/features/home/presentation/widgets/gridlayout_categor.dart';
import 'package:haji_market/features/home/presentation/widgets/stocks_page.dart';
import 'package:haji_market/features/home/presentation/widgets/user_agreement_page.dart';

import '../../../drawer/presentation/widgets/under_catalog_page.dart';

class HomePage extends StatefulWidget {
  final void Function()? drawerCallback;
  final GlobalKey<ScaffoldState>? globalKey;
  const HomePage({
    this.globalKey,
    this.drawerCallback,
    Key? key,
  }) : super(key: key);

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
      icon: 'assets/icons/cat2.svg',
    ),
    GridLayoutCategory(
      title: 'Cмартфоны',
      icon: 'assets/icons/cat1.svg',
    ),
    GridLayoutCategory(
      title: 'Аптека',
      icon: 'assets/icons/cat2.svg',
    ),
    GridLayoutCategory(
      title: 'Скидки',
      icon: 'assets/icons/cat4.svg',
    ),
    GridLayoutCategory(
      title: 'Игрушки',
      icon: 'assets/icons/cat3.svg',
    ),
    GridLayoutCategory(
      title: 'Cмартфоны',
      icon: 'assets/icons/cat1.svg',
      // ontap1: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const DrawerHome(),
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          // onPressed: widget.drawerCallback,
          onPressed: () {
            widget.globalKey!.currentState!.openDrawer();
          },
          icon: const Icon(Icons.menu),
          color: AppColors.kPrimaryColor,
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 22.0),
              child: SvgPicture.asset('assets/icons/search.svg'))
        ],
        title: Transform(
          transform: Matrix4.translationValues(-50, 0, 0),
          child: const Text(
            'HAJI-MARKET',
            style: AppTextStyles.appBarTextStylea,
          ),
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
              padding: const EdgeInsets.only(
                  left: 16.0, top: 16, bottom: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Категории',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 16,
                  ),
                  GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 2 / 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 16),
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Популярное',
                    style: TextStyle(
                        color: AppColors.kGray900,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 16,
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
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UnderCatalogPage()),
                            );
                          },
                          child: GridOptionsPopular(
                            layout: optionsPopular[index],
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 24,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CatalogPage()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Все предложения',
                          style: AppTextStyles.kcolorPrimaryTextStyle,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.kPrimaryColor,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Популярные магазины',
                    style: TextStyle(
                        color: AppColors.kGray900,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 16,
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
                        size: 16,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4,
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Вы недавно смотрели',
                    style: TextStyle(
                        color: AppColors.kGray900,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 16,
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Вас могут заинтересовать',
                    style: TextStyle(
                        color: AppColors.kGray900,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Партнерам',
                    style: TextStyle(
                        color: AppColors.kGray900,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Кабинет продавца',
                    style: AppTextStyles.kcolorPartnerTextStyle,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Начать продавать с «»',
                    style: AppTextStyles.kcolorPartnerTextStyle,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Договор присоединения',
                    style: AppTextStyles.kcolorPartnerTextStyle,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Договор по оказанию услуги доставки',
                    style: AppTextStyles.kcolorPartnerTextStyle,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserAgreementPage()),
                      );
                    },
                    child: const Text(
                      'Пользовательское соглашение',
                      style: AppTextStyles.kcolorPartnerTextStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12,
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
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BonusPage()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16, bottom: 16),
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
      ),
    );
  }
}
