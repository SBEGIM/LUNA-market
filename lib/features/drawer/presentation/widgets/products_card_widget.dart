import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  bool isvisible = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9),
      child: Container(
        padding: const EdgeInsets.all(9),
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
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/wireles.png',
                  height: 104,
                  width: 104,
                )
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Silver MacBook M1 13.1in.\nApple 256GB',
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.kGray900,
                          fontWeight: FontWeight.w400),
                    ),
                    //  SizedBox(
                    //   width: MediaQuery.of(context).size.width * 0.06,
                    // ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.heart_broken,
                          color: Colors.red,
                        ))
                  ],
                ),
                const Text(
                  'Ноутбук',
                  style: TextStyle(
                      color: AppColors.kGray300,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
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
                      '(3 отзыва)',
                      style: TextStyle(
                          color: AppColors.kGray300,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Text(
                      '556 900 ₸ ',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                    Text(
                      '556 900 ₸ ',
                      style: TextStyle(
                        color: AppColors.kGray900,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        '110 300',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    const Text('х3'),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.12,
                    ),
                    Visibility(
                      visible: isvisible,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isvisible = !isvisible;
                          });
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1DC4CF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(12),
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
                    ),
                    // Visibility(
                    //    visible: isvisible,
                    //     child: Container(
                    //   child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         ClipOval(
                    //           child: Material(
                    //             color: Colors.grey[300], // Button color
                    //             child: InkWell(
                    //               splashColor:
                    //                   AppColors.reviewStar, // Splash color
                    //               onTap: () {
                    //                 // if (model.countAdults! > 0) {
                    //                 //   model.countAdults =
                    //                 //       model.countAdults! - 1;
                    //                 // }
                    //               },
                    //               child: const SizedBox(
                    //                 width: 40,
                    //                 height: 40,
                    //                 child: Icon(Icons.remove),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //         Text(
                    //           '0',
                    //         ),
                    //         ClipOval(
                    //           child: Material(
                    //             color: AppColors.kReviewBg, // Button color
                    //             child: InkWell(
                    //               splashColor:
                    //                   AppColors.reviewStar, // Splash color
                    //               onTap: () {
                    //                 // model.countAdults ??= 0;
                    //                 // model.countAdults = model.countAdults! + 1;
                    //               },
                    //               child: const SizedBox(
                    //                 width: 40,
                    //                 height: 40,
                    //                 child: Icon(
                    //                   Icons.add,
                    //                   color: Colors.white,
                    //                 ),
                    //               ),
                    //             ),
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    // ))
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
