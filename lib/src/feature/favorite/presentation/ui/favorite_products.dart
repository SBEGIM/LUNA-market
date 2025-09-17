import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/basket/bloc/basket_cubit.dart';
import 'package:haji_market/src/feature/favorite/bloc/favorite_cubit.dart';
import 'package:haji_market/src/feature/product/data/model/product_model.dart';
import 'package:intl/intl.dart';

class FavoriteProductsCardWidget extends StatefulWidget {
  final ProductModel product;

  const FavoriteProductsCardWidget({required this.product, Key? key})
      : super(key: key);

  @override
  State<FavoriteProductsCardWidget> createState() =>
      _FavoriteProductsCardWidgetState();
}

class _FavoriteProductsCardWidgetState
    extends State<FavoriteProductsCardWidget> {
  int count = 0;
  bool isvisible = false;
  bool inFavorite = false;
  int compoundPrice = 0;
  double procentPrice = 0;

  @override
  void initState() {
    count += widget.product.basketCount ?? 0;
    if (count > 0) {
      isvisible = true;
    }
    inFavorite = widget.product.inFavorite ?? false;
    compoundPrice = (widget.product.price!.toInt() *
            (((100 - widget.product.compound!.toInt())) / 100))
        .toInt();
    procentPrice =
        ((widget.product.price!.toInt() - widget.product.compound!.toInt()) /
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
    return Visibility(
      visible: inFavorite,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
        child: Container(
          height: 130,
          width: 358,
          padding: const EdgeInsets.only(left: 4, top: 4, bottom: 4),
          decoration: BoxDecoration(
            color: AppColors.kBackgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(4),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      height: 104,
                      width: 104,
                      decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              12), // Slightly smaller than container
                          child: Image.network(
                            widget.product.path != null
                                ? "https://lunamarket.ru/storage/${widget.product.path!.first}"
                                : "https://lunamarket.ru/storage/banners/2.png",
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: Colors.grey[100],
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: Colors.grey[100],
                              child: const Icon(Icons.broken_image,
                                  color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Container(
                    //   padding: EdgeInsets.all(8),
                    //   height: 104,
                    //   width: 104,
                    //   decoration: BoxDecoration(
                    //       color: AppColors.kWhite,
                    //       borderRadius: BorderRadius.circular(16)),
                    //   child: Image.network(
                    //     widget.product.path!.isNotEmpty
                    //         ? "https://lunamarket.ru/storage/${widget.product.path!.first}"
                    //         : '',
                    //     fit: BoxFit.cover,
                    //     errorBuilder: (context, error, stackTrace) =>
                    //         const ErrorImageWidget(
                    //       height: 104,
                    //       width: 104,
                    //     ),
                    //   ),
                    // ),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 4, bottom: 8, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 52,
                            height: 22,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColors.kYellowDark,
                                borderRadius: BorderRadius.circular(24)),
                            child: Text('0·0·12',
                                style: AppTextStyles.size13Weight400),
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
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Text(
                                    '${widget.product.point ?? 0}% Б',
                                    style: AppTextStyles.size13Weight400
                                        .copyWith(color: AppColors.kWhite),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          // widget.product.compound != 0
                          //     ? Container(
                          //         height: 22,
                          //         decoration: BoxDecoration(
                          //             color:
                          //                 const Color.fromRGBO(255, 50, 72, 1),
                          //             borderRadius: BorderRadius.circular(4)),
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
                          // Container(
                          //   decoration: BoxDecoration(
                          //       color: Colors.red,
                          //       borderRadius: BorderRadius.circular(4)),
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(
                          //         left: 4.0, right: 4, top: 2, bottom: 2),
                          //     child: Text(
                          //       '-${widget.product.compound} %',
                          //       textAlign: TextAlign.center,
                          //       style: const TextStyle(
                          //           color: Colors.white,
                          //           fontSize: 9,
                          //           fontWeight: FontWeight.w400),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.only(left: 4, right: 4, top: 2),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Container(
                    //         decoration: BoxDecoration(
                    //             color: AppColors.kYellowLight,
                    //             borderRadius: BorderRadius.circular(4)),
                    //         child: const Padding(
                    //           padding: EdgeInsets.only(
                    //               left: 8.0, right: 8, top: 4, bottom: 4),
                    //           child: Text(
                    //             '0·0·12',
                    //             textAlign: TextAlign.center,
                    //             style: TextStyle(
                    //                 color: Colors.white,
                    //                 fontSize: 12,
                    //                 fontWeight: FontWeight.w400),
                    //           ),
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         height: 4,
                    //       ),
                    //       Container(
                    //         width: 50,
                    //         decoration: BoxDecoration(
                    //             color: Colors.black,
                    //             borderRadius: BorderRadius.circular(4)),
                    //         child: const Padding(
                    //           padding: EdgeInsets.only(
                    //               left: 4.0, right: 4, top: 2, bottom: 4),
                    //           child: Text(
                    //             '10% Б',
                    //             textAlign: TextAlign.center,
                    //             style: TextStyle(
                    //                 color: Colors.white,
                    //                 fontSize: 12,
                    //                 fontWeight: FontWeight.w400),
                    //           ),
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         height: 18,
                    //       ),
                    //       widget.product.compound != 0
                    //           ? Container(
                    //               height: 22,
                    //               decoration: BoxDecoration(
                    //                   color:
                    //                       const Color.fromRGBO(255, 50, 72, 1),
                    //                   borderRadius: BorderRadius.circular(4)),
                    //               child: Padding(
                    //                 padding: const EdgeInsets.only(
                    //                     left: 4.0, right: 4, top: 4, bottom: 4),
                    //                 child: Text(
                    //                   '-${widget.product.compound}%',
                    //                   textAlign: TextAlign.center,
                    //                   style: const TextStyle(
                    //                       color: Colors.white,
                    //                       fontSize: 12,
                    //                       fontWeight: FontWeight.w400),
                    //                 ),
                    //               ),
                    //             )
                    //           : const SizedBox(),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.58,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.product.name.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.size14Weight600,
                          ),
                        ),
                        SizedBox(width: 8),
                        IconButton(
                            onPressed: () async {
                              final favorite =
                                  BlocProvider.of<FavoriteCubit>(context);
                              await favorite
                                  .favorite(widget.product.id.toString());
                              setState(() {
                                inFavorite = !inFavorite;
                              });
                            },
                            icon: Image.asset(
                              Assets.icons.favoriteBottomFullIcon.path,
                              scale: 1.9,
                              color: inFavorite == true
                                  ? const Color.fromRGBO(255, 50, 72, 1)
                                  : Colors.grey,
                            ))
                      ],
                    ),
                  ),
                  compoundPrice != 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              // width: 75,
                              child: Text(
                                '${formatPrice(compoundPrice)} ₽ ',
                                style: AppTextStyles.size16Weight600,
                              ),
                            ),
                            Text(
                              '${formatPrice(widget.product.price!)} ₽ ',
                              style: AppTextStyles.size14Weight600.copyWith(
                                decoration: TextDecoration.lineThrough,
                                color: AppColors.kGray300,
                                decorationColor: AppColors.kGray300,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          '${formatPrice(widget.product.price!)} ₽ ',
                          style: const TextStyle(
                            color: AppColors.kGray900,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                  const SizedBox(
                    height: 7,
                  ),
                  SizedBox(
                      height: 25,
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            constraints: const BoxConstraints(
                              minWidth: 84,
                            ),
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppColors.kYellowDark,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${formatPrice(int.parse((widget.product.price ?? 0 / 3).toString()))} ₽ / мес ',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  letterSpacing: -1,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (count < 1) {
                                BlocProvider.of<BasketCubit>(context).basketAdd(
                                    widget.product.id.toString(),
                                    '1',
                                    0,
                                    '',
                                    '');
                                setState(() {
                                  count += 1;
                                  if (count == 0) {
                                    isvisible = false;
                                  } else {
                                    isvisible = true;
                                  }
                                });
                              } else {
                                BlocProvider.of<BasketCubit>(context)
                                    .basketMinus(widget.product.id.toString(),
                                        '1', 0, 'fbs');
                                setState(() {
                                  if (count == 0) {
                                    isvisible = false;
                                  } else {
                                    isvisible = true;
                                  }
                                  count -= 1;
                                });
                              }

                              print(count);
                            },
                            child: Container(
                              width: 114,
                              height: 25,
                              decoration: BoxDecoration(
                                color: count < 1
                                    ? AppColors.kGray300
                                    : AppColors.mainPurpleColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'В корзину',
                                style: TextStyle(
                                    color: count < 1
                                        ? AppColors.kLightBlackColor
                                        : Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
