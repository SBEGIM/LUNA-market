import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/bloger/my_products_admin/data/models/blogger_shop_products_model.dart';
import 'package:haji_market/bloger/my_products_admin/presentation/ui/upload_product_video.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/widgets/error_image_widget.dart';

class BloggerProductCardWidget extends StatefulWidget {
  final BloggerShopProductModel product;

  const BloggerProductCardWidget({required this.product, Key? key}) : super(key: key);

  @override
  State<BloggerProductCardWidget> createState() => _BloggerProductCardWidget();
}

class _BloggerProductCardWidget extends State<BloggerProductCardWidget> {
  int count = 0;
  bool isvisible = false;
  bool inFavorite = false;
  int compoundPrice = 0;
  double procentPrice = 0;

  @override
  void initState() {
    // count += widget.product.basketCount ?? 0;
    // if (count > 0) {
    //   isvisible = true;
    // }
    // inFavorite = widget.product.inFavorite ?? false;
    compoundPrice = (widget.product.price! * (100 - (widget.product.compound ?? 0))) ~/ 100;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 151,
      margin: const EdgeInsets.only(left: 16, top: 7, bottom: 8, right: 16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), boxShadow: const [
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
                      ? "http://185.116.193.73/storage/${widget.product.path!.path}"
                      : "http://185.116.193.73/storage/banners/2.png",
                  height: 104,
                  width: 104,
                  errorBuilder: (context, error, stackTrace) => const ErrorImageWidget(
                    height: 104,
                    width: 104,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4, bottom: 8, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration:
                            BoxDecoration(color: AppColors.kPrimaryColor, borderRadius: BorderRadius.circular(4)),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
                          child: Text(
                            '0·0·12',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(4)),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
                          child: Text(
                            '10% Б',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Container(
                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0, right: 4, top: 2, bottom: 2),
                          child: Text(
                            '-${widget.product.compound}%',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w400),
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
                      Text(
                        widget.product.name.toString(),
                        style: const TextStyle(fontSize: 12, color: AppColors.kGray900, fontWeight: FontWeight.w500),
                      ),
                      IconButton(
                          onPressed: () async {
                            // final favorite =
                            //     BlocProvider.of<FavoriteCubit>(context);
                            // await favorite.favorite(widget.product.id.toString());
                            setState(() {
                              inFavorite = !inFavorite;
                            });
                          },
                          splashRadius: 1.00,
                          icon: inFavorite == true
                              ? SvgPicture.asset('assets/icons/heart_fill.svg')
                              : SvgPicture.asset(
                                  'assets/icons/favorite.svg',
                                  color: inFavorite == true ? Colors.red : Colors.grey,
                                ))
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 0, bottom: 3),
                  child: Text(
                    'Ноутбук',
                    style: TextStyle(color: AppColors.kGray300, fontSize: 12, fontWeight: FontWeight.w400),
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
                              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w500, fontSize: 16),
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
                    height: 32,
                    padding: const EdgeInsets.only(right: 12),
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
                                style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
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
                                    fontSize: 12, fontWeight: FontWeight.w400, color: Color.fromRGBO(197, 200, 204, 1)),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            // await showAlertStaticticsWidget(
                            //     context, widget.product);

                            Get.to(() => UploadProductVideoPage(id: widget.product.id!));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            // width: 99,
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1DC4CF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Добавить видео',
                              // textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
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
