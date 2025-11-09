import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import 'package:haji_market/src/feature/product/data/model/product_model.dart';
import 'package:intl/intl.dart';

import '../../../favorite/bloc/favorite_cubit.dart';

class ProductWatchingCard extends StatefulWidget {
  final ProductModel product;
  const ProductWatchingCard({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductWatchingCard> createState() => _ProductWatchingCardState();
}

class _ProductWatchingCardState extends State<ProductWatchingCard> {
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
      width: 173,
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12, left: 14),
                height: 144,
                width: 144,
                child: Image.network(
                  widget.product.path?.length != 0
                      ? "https://lunamarket.ru/storage/${widget.product.path?.first}"
                      : '',
                  height: 144,
                  width: 144,
                  alignment: Alignment.center,
                  errorBuilder: (context, error, stackTrace) =>
                      const ErrorImageWidget(
                    height: 144,
                    width: 144,
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
                      width: 144,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 60,
                            height: 26,
                            decoration: BoxDecoration(
                                color: AppColors.kYellowDark,
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            child: Text(
                              '0·0·12',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.size13Weight500,
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
                              Assets.icons.favoriteFullIcon.path,
                              color: inFavorite == true
                                  ? const Color.fromRGBO(255, 50, 72, 1)
                                  : Colors.red,
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
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              '${widget.product.point ?? 0}% Б',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.size13Weight500
                                  .copyWith(color: AppColors.kWhite),
                            ),
                          )
                        : const SizedBox.shrink(),
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
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40,
                  child: Text(
                    '${widget.product.name}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: AppTextStyles.size14Weight400
                        .copyWith(color: AppColors.kGray400),
                  ),
                ),
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
                const SizedBox(
                  height: 8,
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 100),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    height: 21,
                    decoration: BoxDecoration(
                      color: AppColors.kYellowDark,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${formatPrice((widget.product.price! / 3).round())} ₽/мес',
                      style: AppTextStyles.size13Weight400,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
