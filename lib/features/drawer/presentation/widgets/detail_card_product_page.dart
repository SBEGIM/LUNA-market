import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/drawer/presentation/widgets/detailed_store_page.dart';
import 'package:haji_market/features/drawer/presentation/widgets/specifications_page.dart';

import '../../../home/presentation/ui/home_page.dart';
import '../../../home/presentation/widgets/banner_watceh_recently_widget.dart';

class DetailCardProductPage extends StatefulWidget {
  DetailCardProductPage({Key? key}) : super(key: key);

  @override
  State<DetailCardProductPage> createState() => _DetailCardProductPageState();
}

class _DetailCardProductPageState extends State<DetailCardProductPage> {
  int _selectedIndex = 0;
  List textDescrp = [
    'Все товары APPLE',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.kPrimaryColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: const [
                Icon(
                  Icons.ios_share,
                  color: AppColors.kPrimaryColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.search,
                  color: AppColors.kPrimaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 300,
            color: Colors.white,
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Черные беспроводные наушники\nAirPods Max',
                      style: TextStyle(fontSize: 17, color: AppColors.kGray900),
                    ),
                    Icon(
                      Icons.heart_broken,
                      color: Colors.red,
                    ),
                  ],
                ),
                const Text(
                  'Артикул: 1920983974',
                  style: TextStyle(
                      color: AppColors.kGray300,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    RatingBar(
                      ignoreGestures: true,
                      initialRating: 2,
                      unratedColor: const Color(0x30F11712),
                      itemSize: 15,
                      // itemPadding:
                      // const EdgeInsets.symmetric(horizontal: 4.0),
                      ratingWidget: RatingWidget(
                        full: const Icon(Icons.star),
                        half: const Icon(Icons.star),
                        empty: const Icon(Icons.star),
                      ),
                      onRatingUpdate: (double value) {},
                    ),
                    const Text(
                      '(98 отзывов)',
                      style: TextStyle(
                          color: AppColors.kGray300,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18.5,
                ),
                Row(
                  children: const [
                    Text(
                      '9 300 000 ₸',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '9 500 000 ₸',
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: AppColors.kGray900,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const Text(
                      'в рассрочку',
                      style: TextStyle(
                          color: AppColors.kGray200,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '100 000',
                        style: TextStyle(
                            color: AppColors.kGray900,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      'x3',
                      style: TextStyle(
                          color: AppColors.kGray200,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    '-10% скидка за наличный расчет',
                    style: TextStyle(color: Color(0xFFFF3347)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.card_giftcard_outlined,
                      color: AppColors.kPrimaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Подарим бонусы до 15%',
                      style: TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Выберите цвет',
                  style: TextStyle(
                      color: AppColors.kGray900,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),
                // for (var item in imgList)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/images/wireles.png',
                      height: 80,
                    ),
                    Image.asset(
                      'assets/images/wireles.png',
                      height: 80,
                    ),
                    Image.asset(
                      'assets/images/wireles.png',
                      height: 80,
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Продавцы',
                  style: TextStyle(
                    color: AppColors.kGray900,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('В рассрочку'),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Text(
                            '3 мес',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Text(
                            '6 мес',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Text(
                            '9 мес',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Text(
                            '12 мес',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
              color: Colors.white,
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: ,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sulpak',
                              style: TextStyle(
                                  color: AppColors.kGray900,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                const Text(
                                  '(98 отзывов)',
                                  style: TextStyle(
                                      color: AppColors.kGray300,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                RatingBar(
                                  ignoreGestures: true,
                                  initialRating: 2,
                                  unratedColor: const Color(0x30F11712),
                                  itemSize: 15,
                                  // itemPadding:
                                  // const EdgeInsets.symmetric(horizontal: 4.0),
                                  ratingWidget: RatingWidget(
                                    full: const Icon(Icons.star),
                                    half: const Icon(Icons.star),
                                    empty: const Icon(Icons.star),
                                  ),
                                  onRatingUpdate: (double value) {},
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '30 000 ₸',
                              style: TextStyle(
                                  color: AppColors.kGray900,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    '100 000',
                                    style: TextStyle(
                                        color: AppColors.kGray900,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                const Text(
                                  'x3',
                                  style: TextStyle(
                                      color: AppColors.kGray200,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Доставка завтра, бесплатно',
                                  style: TextStyle(
                                      color: AppColors.kGray900,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  'Самовывоз: завтра',
                                  style: TextStyle(
                                      color: AppColors.kGray900,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailStorePage()),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFF1DC4CF),
                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.all(16),
                                child: const Text(
                                  'Выбрать',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              )),
          const SizedBox(
            height: 10,
          ),
          Container(
            // padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Характеристики',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Назначение: Обычные\nТип конструкции: Полноразмерные\nТип крепления: С оголовьем\nЧастотный диапазон, Гц-кГц: 20 - 20\nИмпеданс, Ом: 32\nТип подключения: Беспроводное',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: AppColors.kGray400,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SpecificationsPage()),
                      );
                      // SpecificationsPage
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Подробнее',
                          style: TextStyle(
                              color: AppColors.kPrimaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.kPrimaryColor,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var item in textDescrp)
                            Text(
                              item,
                              style: const TextStyle(
                                  color: AppColors.kGray900,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: AppColors.kGray400,
                      )
                    ],
                  );
                },
              )),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Похожие товары',
                  style: TextStyle(
                      color: AppColors.kGray900,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: const <Widget>[
                      BannerWatcehRecently(),
                      BannerWatcehRecently(),
                      BannerWatcehRecently(),
                      BannerWatcehRecently(),
                    ])),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'С этим товаром пакупают',
                  style: TextStyle(
                      color: AppColors.kGray900,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: const <Widget>[
                      BannerWatcehRecently(),
                      BannerWatcehRecently(),
                      BannerWatcehRecently(),
                      BannerWatcehRecently(),
                    ])),
              ],
            ),
          ),
          const SizedBox(
            height: 90,
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 36),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                // Navigator.pop(context);
              },
              child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.kPrimaryColor,
                  ),
                  // width: MediaQuery.of(context).size.width * 0.440,
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 13, bottom: 13),
                  child: const Text(
                    'Оформить сейчас',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    textAlign: TextAlign.center,
                  )),
            ),
            InkWell(
              onTap: () {
                // Navigator.pop(context);
              },
              child: Container(
                  height: 44,
                  // width: MediaQuery.of(context).size.width * 0.490,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  padding: const EdgeInsets.only(
                      left: 21.5, right: 21.5, top: 13, bottom: 13),
                  child: const Text(
                    'Добавить в корзину',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                    textAlign: TextAlign.center,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
