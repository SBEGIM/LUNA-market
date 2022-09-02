import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/common/constants.dart';

class DetailStorePage extends StatefulWidget {
  DetailStorePage({Key? key}) : super(key: key);

  @override
  State<DetailStorePage> createState() => _DetailStorePageState();
}

class _DetailStorePageState extends State<DetailStorePage> {
  // List<bool>? isSelected;
  int index = 0;

  // @override
  // void initState() {
  //   isSelected = [true, false];
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
        title: const Text(
          'ZARA',
          style: TextStyle(
              color: AppColors.kGray900,
              fontWeight: FontWeight.w500,
              fontSize: 18),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.ios_share_rounded,
              color: AppColors.kPrimaryColor,
            ),
          )
        ],
      ),
      // appBar: ,
      body: ListView(
        shrinkWrap: true,
        children: [
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
                    'Дата регистрации: 20.06.2022',
                    style: TextStyle(
                        color: AppColors.kGray300,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
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
                  ListTile(
                    leading: SvgPicture.asset('assets/icons/check_circle.svg'),
                    title: const Text(
                      'Более 1 000 успешных продаж',
                      style: TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.kPrimaryColor),
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.black),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      'Подписаться',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColors.kPrimaryColor),
                    ),
                  )
                ],
              )),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                const Divider(
                  color: AppColors.kGray300,
                ),
                const ListTile(
                  leading: Icon(
                    Icons.message_rounded,
                    color: AppColors.kPrimaryColor,
                  ),
                  title: Text(
                    'Чат с поддержкой',
                    style: TextStyle(
                        color: AppColors.kGray900,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const Divider(
                  color: AppColors.kGray300,
                ),
                const ListTile(
                    leading: Text(
                      'Все товары ZARA',
                      style: TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.kPrimaryColor,
                    )),
                const Divider(
                  color: AppColors.kGray300,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        index = 0;
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: MediaQuery.of(context).size.width * 0.45,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.kGray300),
                            borderRadius: const BorderRadius.only(
                                bottomLeft: const Radius.circular(10),
                                topLeft: const Radius.circular(10))),
                        child: const Text(
                          'Отзывы',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        index = 1;
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.kGray300),
                            borderRadius: const BorderRadius.only(
                                topRight: const Radius.circular(10),
                                bottomRight: const Radius.circular(10))),
                        child: const Text(
                          'Пункты самовывоза',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                )
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) {
                return const ListTile(
                  minLeadingWidth: 23,
                  leading: Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Icon(
                      Icons.share_location_outlined,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                  title: Text(
                    'Алматы, улица Байзакова, 280',
                    style: TextStyle(
                        color: AppColors.kGray900,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  subtitle: Text(
                    'Пн – Сб с 10:00 до 18:00, Вс – выходной',
                    style: TextStyle(
                        color: AppColors.kGray300,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                );
              },
            ),
          )
          // ReviewsWidget(),

          // IndexedStack(
          //   index: index,
          //   children: [],
          // ),
        ],
      ),
    );
  }
}

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Отзывы',
            style: TextStyle(
                color: AppColors.kGray900,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          ),
          Row(
            children: const [
              Text(
                '4.8 из 5',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.kGray300,
                    fontSize: 32),
              ),
            ],
          ),
          const Text(
            '98 отзывов',
            style: TextStyle(
                color: AppColors.kGray300,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            // separatorBuilder: (BuildContext context, int index) => const Divider(),
            itemBuilder: (BuildContext context, int index) {
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Ronald Richards',
                          style: TextStyle(
                              color: AppColors.kGray900,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
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
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      '14 мая 2021г.',
                      style: const TextStyle(
                          color: AppColors.kGray300,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    const Text(
                      'Here is some long text that I am expecting will go off of the screen.',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //   Flexible(
                    //       child: Text(
                    //           'The Dropbox HQ in San Francisco is one of the best designed & most comfortable offices I have ever witnessed. Great stuff! If you happen to visit SanFran, dont miss the chance to witness it yourself. ',style: TextStyle(color: Colors.black),))
                    // ],
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
