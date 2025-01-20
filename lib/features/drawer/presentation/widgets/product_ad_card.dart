import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/widgets/error_image_widget.dart';
import 'package:haji_market/features/drawer/data/models/product_model.dart';
import 'package:haji_market/features/drawer/presentation/widgets/advert_bottom_sheet.dart';
import '../../../../contract_of_sale.dart';
import '../../../drawer/data/bloc/favorite_cubit.dart';

class ProductAdCard extends StatefulWidget {
  final ProductModel product;
  const ProductAdCard({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductAdCard> createState() => _ProductAdCardState();
}

class _ProductAdCardState extends State<ProductAdCard> {
  credit(int price) {
    final creditPrice = (price / 3);
    return creditPrice.toInt();
  }

  double? procentPrice;

  bool inFavorite = false;

  @override
  void initState() {
    inFavorite = widget.product.inFavorite as bool;
    procentPrice =
        ((widget.product.price!.toInt() - widget.product.compound!.toInt()) /
                widget.product.price!.toInt()) *
            100;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16.0, top: 6),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(250, 250, 250, 1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                padding: EdgeInsets.only(top: 6),
                height: 120,
                width: 120,
                child: Image.network(
                  widget.product.path!.isNotEmpty
                      ? "https://lunamarket.ru/storage/${widget.product.path!.first}"
                      : '',
                  alignment: Alignment.center,
                  errorBuilder: (context, error, stackTrace) =>
                      const ErrorImageWidget(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 0, top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                      width: 160,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.kPrimaryColor,
                                borderRadius: BorderRadius.circular(6)),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 8.0, right: 8, top: 4, bottom: 4),
                              child: Text(
                                '0·0·12',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
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
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(4)),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 4.0, right: 4, top: 4, bottom: 4),
                              child: Text(
                                '10% Б',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    widget.product.point != 0
                        ? const SizedBox(height: 5)
                        : const SizedBox(),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 4.0, right: 4, top: 4, bottom: 4),
                        child: Text(
                          '-${widget.product.compound}%',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.product.name}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.kGray900,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 4,
                ),
                GestureDetector(
                  onTap: () async {
                    await showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      isDismissible: true,
                      builder: (context) {
                        return AdvertBottomSheet(
                            description:
                                "${widget.product.shop?.typeOrganization ?? 'ИП'}: ${widget.product.shop!.userName}");
                      },
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 4.0, right: 4, top: 4, bottom: 4),
                      child: Text(
                        'РЕКЛАМА',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                (widget.product.compound != 0 ||
                        widget.product.compound != null)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 75,
                            child: Text(
                              '${(widget.product.price?.toInt() ?? 0) - (widget.product.price! / 100 * widget.product.compound!).toInt()} ₽',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(255, 50, 72, 1),
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Text(
                            '${widget.product.price} ₽',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 10,
                                color: Color(0xFF19191A),
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    : Text(
                        '${widget.product.price} ₽',
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF19191A),
                            fontWeight: FontWeight.w700),
                      ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 4, right: 4, top: 4, bottom: 4),
                        child: Text(
                          '${((widget.product.price! * (100 - (widget.product.compound ?? 0))) ~/ 100.toInt() / 3).round()}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFF19191A),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Text(
                      'х3',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.kGray300,
                          fontWeight: FontWeight.w400),
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
