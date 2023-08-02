import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/widgets/error_image_widget.dart';
import 'package:haji_market/features/drawer/data/bloc/basket_cubit.dart';
import 'package:haji_market/features/drawer/data/bloc/favorite_cubit.dart';
import 'package:haji_market/features/drawer/data/models/product_model.dart';

class ProductCardWidget extends StatefulWidget {
  final ProductModel product;

  const ProductCardWidget({required this.product, Key? key}) : super(key: key);

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  int count = 0;
  bool isvisible = false;
  bool inFavorite = false;
  int compoundPrice = 0;

  @override
  void initState() {
    count += widget.product.basketCount ?? 0;
    if (count > 0) {
      isvisible = true;
    }
    inFavorite = widget.product.inFavorite ?? false;
    compoundPrice = widget.product.price! -
        ((widget.product.price! / 100) * (widget.product.compound ?? 1))
            .toInt();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 151,
      margin: const EdgeInsets.only(left: 16, top: 7, bottom: 8, right: 16),
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
            padding: const EdgeInsets.only(top: 7.0, left: 16, right: 16),
            child: Stack(
              children: [
                Image.network(
                  widget.product.path?.isNotEmpty ?? false
                      ? "http://185.116.193.73/storage/${widget.product.path!.first}"
                      : "http://185.116.193.73/storage/banners/2.png",
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
                      Container(
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 205,
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product.name.toString(),
                      style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.kGray900,
                          fontWeight: FontWeight.w500),
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
              const Padding(
                padding: EdgeInsets.only(top: 0, bottom: 3),
                child: Text(
                  'Ноутбук',
                  style: TextStyle(
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
              (compoundPrice != null || compoundPrice != 0)
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
                            '$compoundPrice ₽ ',
                            style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
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
                  width: 196,
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
                              ' ${widget.product.price ?? 0 / 3} ',
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
                      Row(
                        children: [
                          count < 1
                              ? const SizedBox()
                              : Visibility(
                                  visible: isvisible,
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          BlocProvider.of<BasketCubit>(context)
                                              .basketMinus(
                                                  widget.product.id.toString(),
                                                  '1',
                                                  0);
                                          setState(() {
                                            if (count == 0) {
                                              isvisible = false;
                                            } else {
                                              isvisible = true;
                                            }
                                            count -= 1;
                                          });
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
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                                spreadRadius: 1,
                                                blurRadius: 1,
                                                offset: const Offset(0,
                                                    1), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: count == 1
                                              ? SvgPicture.asset(
                                                  'assets/icons/basket_1.svg',
                                                  width: 3.12,
                                                  height: 15,
                                                )
                                              : const Icon(
                                                  Icons.remove,
                                                  color:
                                                      AppColors.kPrimaryColor,
                                                ),
                                        ),
                                      ),
                                      // const SizedBox(
                                      //   width: 14,
                                      // ),
                                      Container(
                                        width: 28,
                                        alignment: Alignment.center,
                                        child: Text('$count'),
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

                                          setState(() {
                                            count += 1;
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
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
                                  ),
                                ),
                          count >= 1
                              ? const SizedBox()
                              : GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<BasketCubit>(context)
                                        .basketAdd(widget.product.id.toString(),
                                            '1', 0, '', '');
                                    setState(() {
                                      count += 1;
                                      if (count == 0) {
                                        isvisible = false;
                                      } else {
                                        isvisible = true;
                                      }
                                    });
                                  },
                                  child: Container(
                                    width: 99,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1DC4CF),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'В корзину',
                                      // textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                        ],
                      )
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
