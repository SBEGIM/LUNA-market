import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/basket/bloc/basket_cubit.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/pre_order_dialog.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/show_basket_bottom_sheet_widget.dart';
import 'package:haji_market/src/feature/favorite/bloc/favorite_cubit.dart';
import 'package:haji_market/src/feature/product/data/model/product_model.dart';
import 'package:haji_market/src/feature/product/cubit/product_cubit.dart' as productCubit;
import 'package:intl/intl.dart';

class ProductCardWidget extends StatefulWidget {
  final int index;
  final ProductModel product;

  const ProductCardWidget({required this.product, Key? key, required this.index}) : super(key: key);

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  int count = 0;
  // bool isvisible = false;
  bool inFavorite = false;
  int compoundPrice = 0;

  int basketCount = 0;

  @override
  void initState() {
    basketCount = widget.product.basketCount ?? 0;
    compoundPrice =
        (widget.product.price!.toInt() * (((100 - widget.product.compound!.toInt())) / 100))
            .toInt();
    count += widget.product.basketCount ?? 0;
    inFavorite = widget.product.inFavorite ?? false;
    compoundPrice = (widget.product.price! * (100 - (widget.product.compound ?? 0))) ~/ 100;

    super.initState();
  }

  String formatPrice(int price) {
    final format = NumberFormat('#,###', 'ru_RU');
    return format.format(price).replaceAll(',', ' ');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12, left: 9.3, right: 9.3),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.circular(16),

        // boxShadow: const [
        //   BoxShadow(
        //     offset: Offset(0, 2),
        //     color: Colors.white,
        //   ),
        // ]
      ),
      // height: MediaQuery.of(context).size.height * 0.86,
      // color: Colors.red,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 144,
                width: 300,
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12), // Slightly smaller than container
                  child: Image.network(
                    "https://lunamarket.ru/storage/${widget.product.path!.first}",
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey[100],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[100],
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4, right: 4, bottom: 8, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 160,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 26,
                            decoration: BoxDecoration(
                              color: AppColors.kYellowDark,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text(
                              '0·0·12',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.size13Weight500,
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
                                  : Assets.icons.favoriteBottomFullIcon.path,
                              scale: 1.9,
                              color: inFavorite == true
                                  ? const Color(0xffFF3347)
                                  : const Color(0xffD1D1D6),
                            ),
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
                            height: 26,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(-0.6, -1),
                                end: Alignment(1, 1),
                                colors: [Color(0xFF7D2DFF), Color(0xFF41DDFF)],
                                stops: [0.2685, 1.0], // соответствуют 26.85% и 100%
                              ),
                              borderRadius: BorderRadius.circular(10),
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
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: 40, // Ensures minimum width
                    minHeight: 40, // Prevents excessive width
                  ),
                  child: Text(
                    widget.product.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.size14Weight400.copyWith(color: Color(0xff636366)),
                  ),
                ),
                SizedBox(height: 4),
                compoundPrice != 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            // width: 75,
                            child: Text(
                              '${formatPrice(compoundPrice)} ₽ ',
                              style: AppTextStyles.size16Weight700,
                            ),
                          ),
                          Text(
                            '${formatPrice(widget.product.price!)} ₽ ',
                            style: AppTextStyles.size14Weight500.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Color(0xff8E8E93),
                              decorationColor: Color(0xff8E8E93),
                            ),
                          ),
                        ],
                      )
                    : Text(
                        '${formatPrice(widget.product.price!)} ₽ ',
                        style: const TextStyle(
                          letterSpacing: 0,
                          color: AppColors.kGray900,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                const SizedBox(height: 4),
                Container(
                  constraints: const BoxConstraints(
                    minWidth: 40, // Ensures minimum width
                    maxWidth: 81, // Prevents excessive width
                  ),
                  height: 21,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: AppColors.kYellowDark,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: FittedBox(
                    // Ensures text fits within container
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '${formatPrice((widget.product.price! / 3).round())} ₽ / мес',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -1,
                      ),
                      maxLines: 1, // Prevents text wrapping
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Spacer(),
                widget.product.optom == true
                    ? Container(
                        width: 150,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.mainPurpleColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Оптом $basketCount шт',
                          // textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //   if (basketCount != 0)
                          //     Row(
                          //       children: [
                          //         InkWell(
                          //           onTap: () {
                          //             /// FIXME
                          //             BlocProvider.of<BasketCubit>(context)
                          //                 .basketMinus(
                          //                     widget.product.id.toString(),
                          //                     '1',
                          //                     0,
                          //                     'fbs');

                          //             BlocProvider.of<productCubit.ProductCubit>(
                          //                     context)
                          //                 .updateProductByIndex(
                          //               index: widget.index,
                          //               updatedProduct: widget.product.copyWith(
                          //                 basketCount: basketCount - 1,
                          //               ),
                          //             );
                          //             // setState(() {
                          //             //   if (count == 0) {
                          //             //     isvisible = false;
                          //             //   } else {
                          //             //     isvisible = true;
                          //             //   }
                          //             //   count -= 1;
                          //             // });
                          //           },
                          //           child: Container(
                          //             height: 32,
                          //             width: 32,
                          //             padding: const EdgeInsets.all(4),
                          //             decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(6),
                          //               color: Colors.white,
                          //               boxShadow: [
                          //                 BoxShadow(
                          //                   color: Colors.grey.withOpacity(0.1),
                          //                   spreadRadius: 1,
                          //                   blurRadius: 1,
                          //                   offset: const Offset(0,
                          //                       1), // changes position of shadow
                          //                 ),
                          //               ],
                          //             ),
                          //             child: basketCount == 1
                          //                 ? SvgPicture.asset(
                          //                     'assets/icons/basket_1.svg',
                          //                     width: 3.12,
                          //                     height: 15,
                          //                   )
                          //                 : const Icon(
                          //                     Icons.remove,
                          //                     color: AppColors.mainPurpleColor,
                          //                   ),
                          //           ),
                          //         ),
                          //         // const SizedBox(
                          //         //   width: 14,
                          //         // ),
                          //         Container(
                          //           width: 28,
                          //           alignment: Alignment.center,
                          //           child: Text('$basketCount'),
                          //         ),
                          //         // const SizedBox(
                          //         //   width: 14,
                          //         // ),
                          //         InkWell(
                          //           onTap: () {
                          //             BlocProvider.of<BasketCubit>(context)
                          //                 .basketAdd(widget.product.id.toString(),
                          //                     '1', 0, '', '');
                          //             BlocProvider.of<productCubit.ProductCubit>(
                          //                     context)
                          //                 .updateProductByIndex(
                          //               index: widget.index,
                          //               updatedProduct: widget.product.copyWith(
                          //                 basketCount: basketCount + 1,
                          //               ),
                          //             );

                          //             /// FIXME
                          //             // setState(() {
                          //             //   count += 1;
                          //             // });
                          //           },
                          //           child: Container(
                          //             padding: const EdgeInsets.all(4),
                          //             decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(10),
                          //               color: Colors.white,
                          //               boxShadow: [
                          //                 BoxShadow(
                          //                   color: Colors.grey.withOpacity(0.1),
                          //                   spreadRadius: 1,
                          //                   blurRadius: 1,
                          //                   offset: const Offset(0,
                          //                       1), // changes position of shadow
                          //                 ),
                          //               ],
                          //             ),
                          //             // child: SvgPicture.asset(
                          //             //     'assets/icons/add_1.svg'),
                          //             child: const Icon(
                          //               Icons.add,
                          //               color: AppColors.mainPurpleColor,
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     )

                          //  else
                          // if
                          (widget.product.pre_order == 1 && widget.product.product_count == 0)
                              ? GestureDetector(
                                  onTap: () {
                                    /// FIXME
                                    BlocProvider.of<BasketCubit>(
                                      context,
                                    ).basketAdd(widget.product.id.toString(), '1', 0, '', '');
                                    BlocProvider.of<productCubit.ProductCubit>(
                                      context,
                                    ).updateProductByIndex(
                                      index: widget.index,
                                      updatedProduct: widget.product.copyWith(
                                        basketCount: basketCount + 1,
                                      ),
                                    );
                                    // setState(() {
                                    //   count += 1;
                                    //   if (count == 0) {
                                    //     isvisible = false;
                                    //   } else {
                                    //     isvisible = true;
                                    //   }
                                    // });
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: AppColors.mainPurpleColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Предзаказ',
                                      // textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    if (widget.product.basketCount != 0) {
                                      AppSnackBar.show(
                                        context,
                                        'Товар уже в корзине',
                                        type: AppSnackType.error,
                                      );

                                      return;
                                    }

                                    showBasketBottomSheetOptions(
                                      context,
                                      '${widget.product.shop?.name}',
                                      0,
                                      widget.product,
                                      (int callBackCount, int callBackPrice, bool callBackOptom) {
                                        if (widget.product.product_count == 0 &&
                                            widget.product.pre_order == 1) {
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

                                                    BlocProvider.of<productCubit.ProductCubit>(
                                                      context,
                                                    ).updateProductByIndex(
                                                      index: widget.index,
                                                      updatedProduct: widget.product.copyWith(
                                                        basketCount: basketCount + 1,
                                                        inBasket: true,
                                                      ),
                                                    );
                                                    setState(() {
                                                      // isvisible = true;
                                                    });

                                                    // final filters = context
                                                    //     .read<FilterProvider>();

                                                    // BlocProvider.of<
                                                    //             productCubit
                                                    //             .ProductCubit>(
                                                    //         context)
                                                    //     .products(filters);
                                                  } else {
                                                    context.router.replaceAll([
                                                      const LauncherRoute(
                                                        children: [BasketRoute()],
                                                      ),
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

                                        BlocProvider.of<productCubit.ProductCubit>(
                                          context,
                                        ).updateProductByIndex(
                                          index: widget.index,
                                          updatedProduct: widget.product.copyWith(
                                            basketCount: basketCount + 1,
                                            inBasket: true,
                                          ),
                                        );
                                        setState(() {
                                          count += 1;
                                          // if (count == 0) {
                                          //   isvisible = false;
                                          // } else {
                                          //   isvisible = true;
                                          // }
                                        });

                                        // BlocProvider.of<
                                        //         productCubit
                                        //         .ProductCubit>(context)
                                        //     .products();
                                        // } else {
                                        //   log('pushReplaceAll',
                                        //       name: 'Detail Card Product Page');
                                        //   context.router.replaceAll([
                                        //     const LauncherRoute(
                                        //         children: [BasketRoute()]),
                                        //   ]);
                                        // }
                                        // });

                                        /// FIXME
                                        // if (widget.product.product_count != 0) {
                                        //   BlocProvider.of<BasketCubit>(context)
                                        //       .basketAdd(
                                        //           widget.product.id.toString(),
                                        //           '1',
                                        //           0,
                                        //           '',
                                        //           '');
                                        //   BlocProvider.of<
                                        //           productCubit
                                        //           .ProductCubit>(context)
                                        //       .updateProductByIndex(
                                        //     index: widget.index,
                                        //     updatedProduct:
                                        //         widget.product.copyWith(
                                        //       basketCount: basketCount + 1,
                                        //     ),
                                        //   );
                                        // } else {
                                        //   Get.snackbar(
                                        //       'Ошибка запроса нет предзаказа!',
                                        //       'количество товара 0 шт',
                                        //       backgroundColor: Colors.blueAccent);
                                        // }

                                        // setState(() {
                                        //   count += 1;
                                        //   if (count == 0) {
                                        //     isvisible = false;
                                        //   } else {
                                        //     isvisible = true;
                                        //   }
                                        // });
                                      },
                                    );
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: widget.product.basketCount == 0
                                          ? AppColors.mainPurpleColor
                                          : AppColors.mainBackgroundPurpleColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Купить',
                                      style: AppTextStyles.size14Weight600.copyWith(
                                        color: AppColors.kWhite,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
