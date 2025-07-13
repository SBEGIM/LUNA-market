import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import 'package:haji_market/src/feature/product/data/model/product_model.dart';
import 'package:intl/intl.dart';

import '../../../favorite/bloc/favorite_cubit.dart';

class ProductMbInterestingCard extends StatefulWidget {
  final ProductModel product;
  const ProductMbInterestingCard({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductMbInterestingCard> createState() =>
      _ProductMbInterestingCardState();
}

class _ProductMbInterestingCardState extends State<ProductMbInterestingCard> {
  credit(int price) {
    final creditPrice = (price / 3);
    return creditPrice.toInt();
  }

  double? procentPrice;
  int compoundPrice = 0;

  bool inFavorite = false;

  @override
  void initState() {
    compoundPrice = (widget.product.price!.toInt() *
            (((100 - widget.product.compound!.toInt())) / 100))
        .toInt();
    inFavorite = widget.product.inFavorite as bool;
    procentPrice =
        ((widget.product.price?.toInt() ?? 0 - (widget.product.compound ?? 0)) /
                widget.product.price!.toInt()) *
            100;
    super.initState();
  }

  String formatPrice(int price) {
    final format = NumberFormat('#,###', 'ru_RU');
    return format.format(price).replaceAll(',', ' ');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                height: 144,
                width: 173,
                child: Image.network(
                  widget.product.path?.length != 0
                      ? "https://lunamarket.ru/storage/${widget.product.path?.first}"
                      : '',
                  height: 144,
                  width: 173,
                  alignment: Alignment.center,
                  errorBuilder: (context, error, stackTrace) =>
                      const ErrorImageWidget(
                    height: 144,
                    width: 173,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 4, bottom: 8, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 160,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.kYellowDark,
                                borderRadius: BorderRadius.circular(6)),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 8.0, right: 8, top: 4, bottom: 4),
                              child: Text(
                                '0·0·12',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () async {
                              final favorite =
                                  BlocProvider.of<FavoriteCubit>(context);
                              await favorite
                                  .favorite(widget.product.id.toString());
                              setState(() {
                                inFavorite = !inFavorite;
                              });
                            },
                            child: SvgPicture.asset(
                              'assets/icons/heart_fill.svg',
                              color: inFavorite == true
                                  ? const Color.fromRGBO(255, 50, 72, 1)
                                  : Colors.grey,
                            ),
                          )
                          // IconButton(
                          //     padding: EdgeInsets.zero,
                          //     onPressed: () async {
                          //       final favorite =
                          //           BlocProvider.of<FavoriteCubit>(context);
                          //       await favorite
                          //           .favorite(widget.product.id.toString());
                          //       setState(() {
                          //         inFavorite = !inFavorite;
                          //       });
                          //     },
                          //     icon: )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    widget.product.point != 0
                        ? Container(
                            width: 52,
                            height: 22,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(-0.6,
                                      -1), // приблизительное направление 128.49°
                                  end: Alignment(1, 1),
                                  colors: [
                                    Color(0xFF7D2DFF),
                                    Color(0xFF41DDFF),
                                  ],
                                  stops: [
                                    0.2685,
                                    1.0
                                  ], // соответствуют 26.85% и 100%
                                ),
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              '${widget.product.point ?? 0}% Б',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.statisticsTextStyle
                                  .copyWith(color: AppColors.kWhite),
                            ),
                          )
                        : const SizedBox(),
                    // widget.product.point != 0
                    //     ? const SizedBox(height: 66)
                    //     : const SizedBox(),
                    // widget.product.compound != 0
                    //     ? Container(
                    //         decoration: BoxDecoration(
                    //             color: Colors.red,
                    //             borderRadius: BorderRadius.circular(6)),
                    //         child: Padding(
                    //           padding: const EdgeInsets.only(
                    //               left: 4.0, right: 4, top: 4, bottom: 4),
                    //           child: Text(
                    //             '-${widget.product.compound}%',
                    //             textAlign: TextAlign.center,
                    //             style: const TextStyle(
                    //                 color: Colors.white,
                    //                 fontSize: 12,
                    //                 fontWeight: FontWeight.w400),
                    //           ),
                    //         ),
                    //       )
                    //     : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: 173,
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  child: Text(
                    '${widget.product.name}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 14,
                        letterSpacing: 0,
                        color: AppColors.kGray400,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                // const SizedBox(
                //   height: 8,
                // ),
                // Text(
                //   '${widget.product.catName ?? 'Неизвестно'}',
                //   overflow: TextOverflow.ellipsis,
                //   style: TextStyle(
                //       fontSize: 14,
                //       color: AppColors.kGray300,
                //       fontWeight: FontWeight.w400),
                // ),
                const SizedBox(
                  height: 3,
                ),

                compoundPrice != 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            // width: 75,
                            child: Text(
                              '${formatPrice(compoundPrice)} ₽ ',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0,
                                  fontSize: 16),
                            ),
                          ),
                          Text(
                            '${formatPrice(widget.product.price!)} ₽ ',
                            style: const TextStyle(
                              color: AppColors.kGray300,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -1,
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: AppColors.kGray300,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        '${formatPrice(widget.product.price!)} ₽ ',
                        style: const TextStyle(
                          letterSpacing: 0,
                          color: AppColors.kGray900,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                // Row(
                //   children: [
                //     RatingBar(
                //       ignoreGestures: true,
                //       initialRating: widget.product.rating!.toDouble(),
                //       unratedColor: const Color(0x30F11712),
                //       itemSize: 12,
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
                //           color: Colors.grey,
                //         ),
                //       ),
                //       onRatingUpdate: (double value) {},
                //     ),
                //     Text(
                //       '(${widget.product.count} отзывов)',
                //       style: const TextStyle(
                //           color: AppColors.kGray300,
                //           fontSize: 12,
                //           fontWeight: FontWeight.w400),
                //     ),
                //   ],
                // ),
                // const SizedBox(
                //   height: 6,
                // ),
                // (widget.product.compound != 0 &&
                //         widget.product.compound != null)
                //     ? Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: [
                //           SizedBox(
                //             width: 75,
                //             child: Text(
                //               '${(widget.product.price?.toInt() ?? 0) - (widget.product.price! / 100 * widget.product.compound!).toInt()} ₽',
                //               overflow: TextOverflow.ellipsis,
                //               style: const TextStyle(
                //                   fontSize: 12,
                //                   color: Color.fromRGBO(255, 50, 72, 1),
                //                   fontWeight: FontWeight.w700),
                //             ),
                //           ),
                //           Text(
                //             '${widget.product.price} ₽',
                //             overflow: TextOverflow.ellipsis,
                //             style: const TextStyle(
                //                 decoration: TextDecoration.lineThrough,
                //                 fontSize: 10,
                //                 color: Color(0xFF19191A),
                //                 fontWeight: FontWeight.w400),
                //           ),
                //         ],
                //       )
                //     : Text(
                //         '${widget.product.price} ₽',
                //         textAlign: TextAlign.start,
                //         overflow: TextOverflow.ellipsis,
                //         style: const TextStyle(
                //             fontSize: 12,
                //             color: Color(0xFF19191A),
                //             fontWeight: FontWeight.w700),
                //       ),
                const SizedBox(
                  height: 4,
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  //width: ,
                  height: 21,
                  decoration: BoxDecoration(
                    color: AppColors.kYellowDark,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${formatPrice(int.parse((widget.product.price! / 3).round().toString()))} ₽ / мес ',
                    style: const TextStyle(
                        color: Colors.black,
                        letterSpacing: 0,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  height: 32,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.mainPurpleColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    'Купить',
                    style: AppTextStyles.categoryTextStyle
                        .copyWith(color: AppColors.kWhite),
                  ),
                )

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Container(
                //       padding: const EdgeInsets.symmetric(horizontal: 4),
                //       height: 16,
                //       alignment: Alignment.center,
                //       decoration: const BoxDecoration(
                //           color: Colors.amber,
                //           borderRadius: BorderRadius.all(Radius.circular(4))),
                //       child: Text(
                //         '${((widget.product.price! * (100 - (widget.product.compound ?? 0))) ~/ 100.toInt() / 3).round()}',
                //         overflow: TextOverflow.ellipsis,
                //         textAlign: TextAlign.center,
                //         style: const TextStyle(
                //             fontSize: 10,
                //             color: Color(0xFF19191A),
                //             fontWeight: FontWeight.w500),
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 4,
                //     ),
                //     const Text(
                //       'х3',
                //       overflow: TextOverflow.ellipsis,
                //       style: TextStyle(
                //           fontSize: 14,
                //           color: AppColors.kGray300,
                //           fontWeight: FontWeight.w400),
                //     ),
                //   ],
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
