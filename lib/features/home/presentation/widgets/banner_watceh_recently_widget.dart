import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';

class BannerWatcehRecently extends StatelessWidget {
  const BannerWatcehRecently({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  height: 144,
                  width: 144,
                  child:   Image.asset(
                    'assets/images/wireles.png',
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 4, right: 4, bottom: 8, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.kPrimaryColor,
                                borderRadius: BorderRadius.circular(4)),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 8.0, right: 8, top: 4, bottom: 4),
                              child: Text(
                                '0·0·12',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.20,
                          ),
                          SvgPicture.asset('assets/icons/heart_fill.svg'),
                        ],
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
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Беспроводные наушн...',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.kGray900,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'Подкатегория',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        color: AppColors.kGray300,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // Row(
                  //   children: [
                  //     RatingBar(
                  //       ignoreGestures: true,
                  //       initialRating: 2,
                  //       unratedColor: const Color(0x30F11712),
                  //       itemSize: 15,
                  //       // itemPadding:
                  //       // const EdgeInsets.symmetric(horizontal: 4.0),
                  //       ratingWidget: RatingWidget(
                  //         full: const Icon(
                  //           Icons.star,
                  //           color: Colors.yellow,
                  //         ),
                  //         half: const Icon(
                  //           Icons.star,
                  //           color: Colors.yellow,
                  //         ),
                  //         empty: const Icon(
                  //           Icons.star,
                  //           color: Colors.yellow,
                  //         ),
                  //       ),
                  //       onRatingUpdate: (double value) {},
                  //     ),
                  //     const Text(
                  //       '(98 отзывов)',
                  //       style: TextStyle(
                  //           color: AppColors.kGray300,
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.w400),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const[
                      Text(
                        '330 900 ₸ ',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(255,50,72,1),
                            fontWeight: FontWeight.w700),
                      ),
                       Text(
                        '330 900 ₸',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 10,
                            color: Color(0xFF19191A),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: const BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        child: const Padding(
                          padding: EdgeInsets.only(
                              left: 4, right: 4, top: 4, bottom: 4),
                          child: Text(
                            '110 300',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF19191A),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Text(
                        'х3',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.kGray300,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
