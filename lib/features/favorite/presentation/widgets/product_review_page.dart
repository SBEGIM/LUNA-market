import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/favorite/presentation/widgets/payment_page.dart';

class ProductReviewPage extends StatelessWidget {
  const ProductReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 0,
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   icon: const Icon(
          //     Icons.arrow_back_ios,
          //     color: AppColors.kPrimaryColor,
          //   ),
          // ),
          centerTitle: true,
          title: const Text(
            'Отзыв о товаре',
            style: TextStyle(
              color: Colors.black,
            ),
          )),
      bottomSheet: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
        child: InkWell(
          onTap: () {
             Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  PaymentPage()),
  );
            // Navigator.pop(context);
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.kPrimaryColor,
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Отправить',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
                textAlign: TextAlign.center,
              )),
        ),
      ),
      body: Column(
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
                  'Отзывы',
                  style: const TextStyle(color: AppColors.kGray900),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: '4.8 ',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 32,
                                fontWeight: FontWeight.w700),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'из 5 ',
                                  style: TextStyle(
                                      color: AppColors.kGray300,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
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
                  ],
                ),
                const Divider(
                  color: AppColors.kGray300,
                ),
                Row(
                  children: [
                    Text(
                      'Оцените товар ',
                      style: TextStyle(color: AppColors.kGray900),
                    ),
                    RatingBar(
                      ignoreGestures: true,
                      initialRating: 2,
                      unratedColor: const Color(0x30F11712),
                      itemSize: 50,
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
                const Divider(
                  color: AppColors.kGray300,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Напишите отзыв',
                      style: TextStyle(color: AppColors.kGray300),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    TextField()
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
