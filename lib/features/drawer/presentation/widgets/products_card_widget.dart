import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';

class ProductCardWidget extends StatefulWidget {
  const ProductCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  int count = 0;
  bool isvisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9),
      child: Container(
        padding: const EdgeInsets.only(left: 4, top: 4, bottom: 9, right: 1),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 2),
                // blurRadius: 4,
                color: Colors.white,
              ),
            ]),
        // height: MediaQuery.of(context).size.height * 0.86,
        // color: Colors.red,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/mac.png',
                    height: 104,
                    width: 104,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 4, right: 4, bottom: 8, top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.kPrimaryColor,
                              borderRadius: BorderRadius.circular(4)),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8, top: 4, bottom: 4),
                            child: Text(
                              '0.0.12',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(4)),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 4.0, right: 4, top: 4, bottom: 4),
                            child: Text(
                              '10% Б',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4)),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 4.0, right: 4, top: 4, bottom: 4),
                            child: Text(
                              '-10%',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Silver MacBook M1 13.1in.\nApple 256GB',
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColors.kGray900,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.14,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset('assets/icons/heart_fill.svg'))
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 0, bottom: 6),
                  child: Text(
                    'Ноутбук',
                    style: TextStyle(
                        color: AppColors.kGray300,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Row(
                  children: [
                    RatingBar(
                      ignoreGestures: false,
                      initialRating: 2,
                      // unratedColor: const Color(0x30F11712),
                      itemSize: 15,
                      unratedColor: Color(0xFFFFC107),
                      // itemPadding:
                      // const EdgeInsets.symmetric(horizontal: 4.0),
                      ratingWidget: RatingWidget(
                        full: const Icon(
                          Icons.star,
                          color: Color(0xFFFFC107),
                        ),
                        half: const Icon(
                          Icons.star,
                          color: Color(0xFFFFC107),
                        ),
                        empty: const Icon(
                          Icons.star,
                          color: Color(0xFFFFC107),
                        ),
                      ),
                      onRatingUpdate: (double value) {},
                    ),
                    const Text(
                      '(3 отзыва)',
                      style: TextStyle(
                          color: AppColors.kGray300,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: const [
                    Text(
                      '556 900 ₸ ',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    Text(
                      '556 900 ₸ ',
                      style: TextStyle(
                        color: AppColors.kGray900,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC107),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '110 300',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    const Text('х3'),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.12,
                    ),
                    count < 1
                        ? SizedBox()
                        : Visibility(
                            visible: isvisible,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      count -= 1;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    child: SvgPicture.asset(
                                        'assets/icons/basket_1.svg'),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: const Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Text('$count'),
                                const SizedBox(
                                  width: 14,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      count += 1;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    child: SvgPicture.asset(
                                        'assets/icons/add_1.svg'),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: const Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    count >= 1
                        ? const SizedBox()
                        : InkWell(
                            onTap: () {
                              setState(() {
                                isvisible = !isvisible;
                                count = 1;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.29,
                              height: 32,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1DC4CF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, bottom: 6, top: 6),
                              child: const Center(
                                child: Text(
                                  'В корзину',
                                  // textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
