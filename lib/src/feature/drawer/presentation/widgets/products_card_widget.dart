import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import 'package:haji_market/src/feature/basket/bloc/basket_cubit.dart';
import 'package:haji_market/src/feature/favorite/bloc/favorite_cubit.dart';
import 'package:haji_market/src/feature/product/data/model/product_model.dart';
import 'package:haji_market/src/feature/product/cubit/product_cubit.dart'
    as productCubit;
import 'package:intl/intl.dart';

class ProductCardWidget extends StatefulWidget {
  final int index;
  final ProductModel product;

  const ProductCardWidget(
      {required this.product, Key? key, required this.index})
      : super(key: key);

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  int count = 0;
  // bool isvisible = false;
  bool inFavorite = false;
  int compoundPrice = 0;

  @override
  void initState() {
    compoundPrice = (widget.product.price!.toInt() *
            (((100 - widget.product.compound!.toInt())) / 100))
        .toInt();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    count += widget.product.basketCount ?? 0;
    inFavorite = widget.product.inFavorite ?? false;
    compoundPrice =
        (widget.product.price! * (100 - (widget.product.compound ?? 0))) ~/ 100;

    setState(() {});
    // });

    super.initState();
  }

  String formatPrice(int price) {
    final format = NumberFormat('#,###', 'ru_RU');
    return format.format(price).replaceAll(',', ' ');
  }

  @override
  Widget build(BuildContext context) {
    final basketCount = widget.product.basketCount ?? 0;

    return Container(
      height: 315,
      width: 173,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.kWhite,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 144,
                width: 154,
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(5), // White border effect
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      12), // Slightly smaller than container
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
                padding:
                    const EdgeInsets.only(left: 4, right: 4, bottom: 8, top: 8),
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
                              child: inFavorite == true
                                  ? SvgPicture.asset(
                                      'assets/icons/heart_fill.svg')
                                  : SvgPicture.asset(
                                      'assets/icons/favorite.svg',
                                      color: inFavorite == true
                                          ? Colors.red
                                          : Colors.grey,
                                    ))
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
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: 40, // Ensures minimum width
                    minHeight: 20, // Prevents excessive width
                  ),
                  child: Text(
                    widget.product.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.categoryTextStyle
                        .copyWith(color: AppColors.kGray300),
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
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
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
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                const SizedBox(
                  height: 7,
                ),
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Оптом $basketCount шт',
                          // textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (basketCount != 0)
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    /// FIXME
                                    BlocProvider.of<BasketCubit>(context)
                                        .basketMinus(
                                            widget.product.id.toString(),
                                            '1',
                                            0,
                                            'fbs');

                                    BlocProvider.of<productCubit.ProductCubit>(
                                            context)
                                        .updateProductByIndex(
                                      index: widget.index,
                                      updatedProduct: widget.product.copyWith(
                                        basketCount: basketCount - 1,
                                      ),
                                    );
                                    // setState(() {
                                    //   if (count == 0) {
                                    //     isvisible = false;
                                    //   } else {
                                    //     isvisible = true;
                                    //   }
                                    //   count -= 1;
                                    // });
                                  },
                                  child: Container(
                                    height: 32,
                                    width: 32,
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
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
                                    child: basketCount == 1
                                        ? SvgPicture.asset(
                                            'assets/icons/basket_1.svg',
                                            width: 3.12,
                                            height: 15,
                                          )
                                        : const Icon(
                                            Icons.remove,
                                            color: AppColors.mainPurpleColor,
                                          ),
                                  ),
                                ),
                                // const SizedBox(
                                //   width: 14,
                                // ),
                                Container(
                                  width: 28,
                                  alignment: Alignment.center,
                                  child: Text('$basketCount'),
                                ),
                                // const SizedBox(
                                //   width: 14,
                                // ),
                                InkWell(
                                  onTap: () {
                                    BlocProvider.of<BasketCubit>(context)
                                        .basketAdd(widget.product.id.toString(),
                                            '1', 0, '', '');
                                    BlocProvider.of<productCubit.ProductCubit>(
                                            context)
                                        .updateProductByIndex(
                                      index: widget.index,
                                      updatedProduct: widget.product.copyWith(
                                        basketCount: basketCount + 1,
                                      ),
                                    );

                                    /// FIXME
                                    // setState(() {
                                    //   count += 1;
                                    // });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
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
                                    // child: SvgPicture.asset(
                                    //     'assets/icons/add_1.svg'),
                                    child: const Icon(
                                      Icons.add,
                                      color: AppColors.mainPurpleColor,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          else
                            (widget.product.pre_order == 1 &&
                                    widget.product.product_count == 0)
                                ? GestureDetector(
                                    onTap: () {
                                      /// FIXME
                                      BlocProvider.of<BasketCubit>(context)
                                          .basketAdd(
                                              widget.product.id.toString(),
                                              '1',
                                              0,
                                              '',
                                              '');
                                      BlocProvider.of<
                                              productCubit
                                              .ProductCubit>(context)
                                          .updateProductByIndex(
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
                                      /// FIXME
                                      if (widget.product.product_count != 0) {
                                        BlocProvider.of<BasketCubit>(context)
                                            .basketAdd(
                                                widget.product.id.toString(),
                                                '1',
                                                0,
                                                '',
                                                '');
                                        BlocProvider.of<
                                                productCubit
                                                .ProductCubit>(context)
                                            .updateProductByIndex(
                                          index: widget.index,
                                          updatedProduct:
                                              widget.product.copyWith(
                                            basketCount: basketCount + 1,
                                          ),
                                        );
                                      } else {
                                        Get.snackbar(
                                            'Ошибка запроса нет предзаказа!',
                                            'количество товара 0 шт',
                                            backgroundColor: Colors.blueAccent);
                                      }

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
                                        color: widget.product.product_count != 0
                                            ? AppColors.mainPurpleColor
                                            : Colors.grey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Купить',
                                        // textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                        ],
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
