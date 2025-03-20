import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/feature/shop/my_products_admin/data/models/admin_products_model.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import 'package:share_plus/share_plus.dart';
import '../widgets/show_alert_statictics_widget.dart';

class AdminProductCardWidget extends StatefulWidget {
  final AdminProductsModel product;

  const AdminProductCardWidget({required this.product, Key? key})
      : super(key: key);

  @override
  State<AdminProductCardWidget> createState() => _AdminProductCardWidgetState();
}

class _AdminProductCardWidgetState extends State<AdminProductCardWidget> {
  int count = 0;
  bool isvisible = false;
  bool inFavorite = false;
  int compoundPrice = 0;
  int optomCount = 0;

  @override
  void initState() {
    // count += widget.product.basketCount ?? 0;
    // if (count > 0) {
    //   isvisible = true;
    // }
    // inFavorite = widget.product.inFavorite ?? false;
    compoundPrice = widget.product.price! -
        ((widget.product.price! / 100) * (widget.product.compound ?? 1))
            .toInt();

    widget.product.bloc?.forEach((element) {
      optomCount += element.count ?? 0;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
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
                  widget.product.path != null
                      ? "https://lunamarket.ru/storage/${widget.product.path!.path}"
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
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 4, right: 4, top: 2, bottom: 2),
                          child: Text(
                            widget.product.fulfillment ?? 'Доставка',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      widget.product.point != 0
                          ? Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 4, right: 4, top: 2, bottom: 2),
                                child: Text(
                                  '${widget.product.point ?? 0}% Б',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(
                        height: widget.product.point != 0 ? 22 : 0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 4.0, right: 4, top: 2, bottom: 2),
                          child: Text(
                            '-${widget.product.compound} %',
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  padding: const EdgeInsets.only(right: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        width: 145,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.product.name.toString(),
                          // 'qweqweq qweqweqw qweqweqweqw qweqweqwe qweqweqweqweqw',
                          style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.kGray900,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),

                      GestureDetector(
                          onTap: () async {
                            await Share.share(
                                '$kDeepLinkUrl/?product_id=${widget.product.id}');
                          },
                          child: SvgPicture.asset(
                            'assets/icons/share.svg',
                            height: 24,
                            width: 24,
                          ))
                      // IconButton(
                      //     onPressed: () async {
                      //       // final favorite =
                      //       //     BlocProvider.of<FavoriteCubit>(context);
                      //       // await favorite.favorite(widget.product.id.toString());
                      //       setState(() {
                      //         inFavorite = !inFavorite;
                      //       });
                      //     },
                      //     splashRadius: 1.00,
                      //     icon: inFavorite == true
                      //         ? SvgPicture.asset('assets/icons/heart_fill.svg')
                      //         : SvgPicture.asset(
                      //             'assets/icons/favorite.svg',
                      //             color: inFavorite == true
                      //                 ? Colors.red
                      //                 : Colors.grey,
                      //           ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 3),
                  child: Text(
                    '${widget.product.catName}',
                    style: const TextStyle(
                        color: AppColors.kGray300,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                // Row(
                //   children: [
                //     RatingBar(
                //       ignoreGestures: true,
                //       initialRating:
                //           double.parse(widget.product.rating.toString()),
                //       minRating: 0,
                //       maxRating: 5,
                //       itemCount: 5,
                //       // unratedColor: const Color(0x30F11712),
                //       itemSize: 14,
                //       unratedColor: const Color(0xFFFFC107),
                //       // itemPadding:
                //       // const EdgeInsets.symmetric(horizontal: 4.0),
                //       ratingWidget: RatingWidget(
                //         full: const Icon(
                //           Icons.star,
                //           color: Color(0xFFFFC107),
                //         ),
                //         half: const Icon(
                //           Icons.star,
                //           color: Colors.grey,
                //         ),
                //         empty: const Icon(
                //           Icons.star,
                //           color: Colors.grey,
                //         ),
                //       ),
                //       onRatingUpdate: (double value) {},
                //     ),
                //     Text(
                //       "(${widget.product.count} отзыва)",
                //       style: const TextStyle(
                //           color: AppColors.kGray300,
                //           fontSize: 12,
                //           fontWeight: FontWeight.w400),
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 8,
                ),
                compoundPrice != 0
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
                Container(
                    // height: 100,
                    padding: const EdgeInsets.only(right: 6, top: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'В наличии: ${widget.product.count}x',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Оптом: ${optomCount}x',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await showAlertStaticticsWidget(
                                context, widget.product);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            // width: 99,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1DC4CF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Управление',
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
