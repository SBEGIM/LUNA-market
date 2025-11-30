import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import 'package:haji_market/src/feature/basket/bloc/basket_cubit.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/pre_order_dialog.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/show_basket_bottom_sheet_widget.dart';
import 'package:haji_market/src/feature/product/cubit/product_cubit.dart' as productCubit;
import 'package:haji_market/src/feature/product/data/model/product_model.dart';
import 'package:haji_market/src/feature/product/provider/filter_provider.dart';
import 'package:intl/intl.dart';
import '../../../favorite/bloc/favorite_cubit.dart';

class ProductRecentlyWachedCard extends StatefulWidget {
  final ProductModel product;
  const ProductRecentlyWachedCard({required this.product, Key? key}) : super(key: key);

  @override
  State<ProductRecentlyWachedCard> createState() => _ProductRecentlyWachedCardState();
}

class _ProductRecentlyWachedCardState extends State<ProductRecentlyWachedCard> {
  credit(int price) {
    final creditPrice = (price / 3);
    return creditPrice.toInt();
  }

  double? procentPrice;
  int compoundPrice = 0;
  int basketCount = 0;

  bool inFavorite = false;

  @override
  void initState() {
    compoundPrice =
        (widget.product.price!.toInt() * (((100 - widget.product.compound!.toInt())) / 100))
            .toInt();
    inFavorite = widget.product.inFavorite as bool;
    procentPrice =
        ((widget.product.price!.toInt() - widget.product.compound!.toInt()) /
            widget.product.price!.toInt()) *
        100;

    basketCount = widget.product.basketCount ?? 0;

    log('basketCount $basketCount');
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
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
                      const ErrorImageWidget(height: 144, width: 173),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 4, bottom: 8, top: 8),
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
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(left: 8.0, right: 8, top: 4, bottom: 4),
                              child: Text(
                                '0·0·12',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () async {
                              final favorite = BlocProvider.of<FavoriteCubit>(context);
                              await favorite.favorite(widget.product.id.toString());
                              setState(() {
                                inFavorite = !inFavorite;
                              });
                            },
                            child: Image.asset(
                              inFavorite == true
                                  ? Assets.icons.favoriteBottomFullIcon.path
                                  : Assets.icons.favoriteBottomIcon.path,
                              color: inFavorite == true
                                  ? const Color.fromRGBO(255, 50, 72, 1)
                                  : Colors.grey,
                              height: 18,
                              width: 21,
                            ),

                            // SvgPicture.asset(
                            //   'assets/icons/heart_fill.svg',
                            //   color: inFavorite == true
                            //       ? const Color.fromRGBO(255, 50, 72, 1)
                            //       : Colors.grey,
                            // ),
                          ),
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
                    const SizedBox(height: 4),
                    widget.product.point != 0
                        ? Container(
                            width: 52,
                            height: 22,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(-0.6, -1), // приблизительное направление 128.49°
                                end: Alignment(1, 1),
                                colors: [Color(0xFF7D2DFF), Color(0xFF41DDFF)],
                                stops: [0.2685, 1.0], // соответствуют 26.85% и 100%
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${widget.product.point ?? 0}% Б',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.statisticsTextStyle.copyWith(
                                color: AppColors.kWhite,
                              ),
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
            padding: const EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  width: 150,
                  child: Text(
                    '${widget.product.name}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: AppTextStyles.size14Weight400.copyWith(color: Color(0xff636366)),
                  ),
                ),
                compoundPrice != 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${formatPrice(compoundPrice)} ₽ ',
                            style: const TextStyle(
                              color: Colors.black,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '${formatPrice(widget.product.price!)} ₽ ',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppColors.kGray300,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -1,
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Color(0xff8E8E93),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Text(
                        '${formatPrice(widget.product.price!)} ₽ ',
                        style: const TextStyle(
                          color: AppColors.kGray900,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0,
                          fontSize: 14,
                        ),
                      ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
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
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                InkWell(
                  onTap: () {
                    if (basketCount != 0) {
                      AppSnackBar.show(context, 'Товар уже в корзине', type: AppSnackType.error);

                      return;
                    }

                    showBasketBottomSheetOptions(
                      context,
                      '${widget.product.shop?.name}',
                      0,
                      widget.product,
                      (int callBackCount, int callBackPrice, bool callBackOptom) {
                        if (widget.product.product_count == 0 && widget.product.pre_order == 1) {
                          if (widget.product.inBasket == false) {
                            showCupertinoModalPopup<void>(
                              context: context,
                              builder: (context) => PreOrderDialog(
                                onYesTap: () {
                                  Navigator.pop(context);
                                  if (widget.product.inBasket == false) {
                                    BlocProvider.of<BasketCubit>(context).basketAdd(
                                      widget.product.id.toString(),
                                      callBackCount,
                                      callBackPrice,
                                      '',
                                      '',
                                      isOptom: callBackOptom,
                                    );
                                    setState(() {
                                      // isvisible = true;
                                    });
                                    final filters = context.read<FilterProvider>();

                                    BlocProvider.of<productCubit.ProductCubit>(
                                      context,
                                    ).products(filters);
                                  } else {
                                    context.router.replaceAll([
                                      const LauncherRoute(children: [BasketRoute()]),
                                    ]);
                                  }
                                },
                              ),
                            );
                          } else {
                            context.router.pushAndPopUntil(
                              const LauncherRoute(children: [BasketRoute()]),
                              predicate: (route) => false,
                            );
                          }

                          return;
                        }

                        // if (widget.product.inBasket == false) {
                        BlocProvider.of<BasketCubit>(context).basketAdd(
                          widget.product.id.toString(),
                          callBackCount,
                          callBackPrice,
                          '',
                          '',
                          isOptom: callBackOptom,
                        );

                        BlocProvider.of<productCubit.ProductCubit>(context).updateProductByIndex(
                          index: widget.product.id!,
                          updatedProduct: widget.product.copyWith(
                            basketCount: widget.product.basketCount! + 1,
                          ),
                        );
                        setState(() {
                          basketCount += callBackCount;
                          // if (count == 0) {
                          //   isvisible = false;
                          // } else {
                          //   isvisible = true;
                          // }
                        });
                      },
                    );
                  },
                  child: Container(
                    height: 32,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: basketCount != 0
                          ? AppColors.buttonBackgroundPurpleColor
                          : AppColors.mainPurpleColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Купить',
                      style: AppTextStyles.categoryTextStyle.copyWith(color: AppColors.kWhite),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
