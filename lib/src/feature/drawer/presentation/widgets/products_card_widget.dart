import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import 'package:haji_market/src/feature/drawer/data/bloc/basket_cubit.dart';
import 'package:haji_market/src/feature/drawer/data/bloc/favorite_cubit.dart';
import 'package:haji_market/src/feature/drawer/data/models/product_model.dart';
import 'package:haji_market/src/feature/drawer/data/bloc/product_cubit.dart'
    as productCubit;

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
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    count += widget.product.basketCount ?? 0;
    inFavorite = widget.product.inFavorite ?? false;
    compoundPrice =
        (widget.product.price! * (100 - (widget.product.compound ?? 0))) ~/ 100;

    setState(() {});
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final basketCount = widget.product.basketCount ?? 0;

    return Container(
      height: 151,
      margin: const EdgeInsets.only(left: 14, top: 7, bottom: 8, right: 14),
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
            padding: const EdgeInsets.only(top: 7.0, left: 8, right: 8),
            child: Stack(
              children: [
                Image.network(
                  widget.product.path?.isNotEmpty ?? false
                      ? "https://lunamarket.ru/storage/${widget.product.path!.first}"
                      : "https://lunamarket.ru/storage/banners/2.png",
                  height: 104,
                  width: 104,
                  errorBuilder: (context, error, stackTrace) =>
                      const ErrorImageWidget(
                    height: 104,
                    width: 104,
                  ),
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
                              left: 4, right: 4, top: 2, bottom: 2),
                          child: Text(
                            '0·0·12',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
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
                        child: widget.product.point != 0
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 4.0, right: 4, top: 2, bottom: 2),
                                child: Text(
                                  '${widget.product.point}% Б',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            : const SizedBox(),
                      ),
                      widget.product.point != 0
                          ? const SizedBox(
                              height: 22,
                            )
                          : const SizedBox(),
                      widget.product.compound != 0
                          ? Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 4.0, right: 4, top: 2, bottom: 2),
                                child: Text(
                                  '-${widget.product.compound}%',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 140,
                      child: Text(
                        widget.product.name.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.kGray900,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          final favorite =
                              BlocProvider.of<FavoriteCubit>(context);
                          await favorite.favorite(widget.product.id.toString());
                          setState(() {
                            inFavorite = !inFavorite;
                          });
                        },
                        splashRadius: 1.00,
                        icon: inFavorite == true
                            ? SvgPicture.asset('assets/icons/heart_fill.svg')
                            : SvgPicture.asset(
                                'assets/icons/favorite.svg',
                                color: inFavorite == true
                                    ? Colors.red
                                    : Colors.grey,
                              ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 3),
                child: Text(
                  widget.product.catName ?? '',
                  style: const TextStyle(
                      color: AppColors.kGray300,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Row(
                children: [
                  RatingBar(
                    ignoreGestures: true,
                    initialRating:
                        double.parse(widget.product.rating.toString()),
                    minRating: 0,
                    maxRating: 5,
                    itemCount: 5,
                    // unratedColor: const Color(0x30F11712),
                    itemSize: 14,
                    unratedColor: const Color(0xFFFFC107),
                    // itemPadding:
                    // const EdgeInsets.symmetric(horizontal: 4.0),
                    ratingWidget: RatingWidget(
                      full: const Icon(
                        Icons.star,
                        color: Color(0xFFFFC107),
                      ),
                      half: const Icon(
                        Icons.star,
                        color: Colors.grey,
                      ),
                      empty: const Icon(
                        Icons.star,
                        color: Colors.grey,
                      ),
                    ),
                    onRatingUpdate: (double value) {},
                  ),
                  Text(
                    "(${widget.product.count} отзыва)",
                    style: const TextStyle(
                        color: AppColors.kGray300,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              widget.product.compound != 0
                  ?
                  // Row(
                  //     children: [
                  //       Text(
                  //         '${compoundPrice}  ₸ ',
                  //         style: const TextStyle(
                  //             color: Colors.red,
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 16),
                  //       ),
                  //       Text(
                  //         '${widget.product.price}₸ ',
                  //         style: const TextStyle(
                  //           color: AppColors.kGray900,
                  //           fontWeight: FontWeight.w500,
                  //           fontSize: 14,
                  //           decoration: TextDecoration.lineThrough,
                  //         ),
                  //       ),
                  //     ],
                  //   )

                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          // width: 75,
                          child: Text(
                            '${(widget.product.price!.toInt() - (widget.product.price! / 100) * (widget.product.compound ?? 0)).toInt()} ₽ ',
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          '${widget.product.price}₽ ',
                          style: const TextStyle(
                            color: AppColors.kGray900,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      '${widget.product.price}₽ ',
                      style: const TextStyle(
                        color: AppColors.kGray900,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
              const SizedBox(
                height: 7,
              ),
              SizedBox(
                height: 32,
                width: MediaQuery.of(context).size.width * 0.55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          //width: ,
                          height: 32,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFC107),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            ' ${compoundPrice ~/ 3} ',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          //width: ,
                          height: 32,

                          alignment: Alignment.center,
                          child: const Text(
                            'х3',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(197, 200, 204, 1)),
                          ),
                        ),
                      ],
                    ),
                    widget.product.optom == true
                        ? Container(
                            width: 99,
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1DC4CF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Оптом $basketCount шт',
                              // textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        : Row(
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

                                        BlocProvider.of<
                                                productCubit
                                                .ProductCubit>(context)
                                            .updateProductByIndex(
                                          index: widget.index,
                                          updatedProduct:
                                              widget.product.copyWith(
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
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
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
                                                color: AppColors.kPrimaryColor,
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

                                        /// FIXME
                                        // setState(() {
                                        //   count += 1;
                                        // });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
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
                                          color: AppColors.kPrimaryColor,
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
                                            updatedProduct:
                                                widget.product.copyWith(
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
                                          width: 99,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF1DC4CF),
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                          if (widget.product.product_count !=
                                              0) {
                                            BlocProvider.of<BasketCubit>(
                                                    context)
                                                .basketAdd(
                                                    widget.product.id
                                                        .toString(),
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
                                                backgroundColor:
                                                    Colors.blueAccent);
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
                                          width: 99,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color:
                                                widget.product.product_count !=
                                                        0
                                                    ? const Color(0xFF1DC4CF)
                                                    : Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'В корзину',
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
              ),
            ],
          )
        ],
      ),
    );
  }
}
