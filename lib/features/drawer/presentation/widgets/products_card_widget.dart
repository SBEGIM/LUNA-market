import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/drawer/data/bloc/basket_cubit.dart';
import 'package:haji_market/features/drawer/data/bloc/favorite_cubit.dart';
import 'package:haji_market/features/drawer/data/models/product_model.dart';

class ProductCardWidget extends StatefulWidget {
  final ProductModel product;

  const ProductCardWidget({
    required this.product,
    Key? key
  }) : super(key: key );

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  int count = 0;
  bool isvisible = false;
  bool inFavorite = false;
  int compoundPrice = 0;
  double procentPrice = 0;


  @override
  void initState() {
    count += widget.product.basketCount ?? 0;
    if(count > 0){
      isvisible = true;
    }
    inFavorite = widget.product.inFavorite ?? false;
    compoundPrice =  (widget.product.price!.toInt() -  widget.product.compound!.toInt());
    procentPrice =  ((widget.product.price!.toInt() -  widget.product.compound!.toInt()) / widget.product.price!.toInt()) * 100 ;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        height: 151,
        margin: const EdgeInsets.only(left: 16, top: 12, bottom: 12, right: 16),
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
              padding: const EdgeInsets.only(top: 7.0 , left: 16,right: 16),
              child: Stack(
                children: [
                  Image.network(
                    widget.product.path!.isNotEmpty ? "http://80.87.202.73:8001/storage/${widget.product.path!.first}" : '',
                    height: 104,
                    width: 104,
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
                                left: 8.0, right: 8, top: 4, bottom: 4),
                            child: Text(
                              '0.0.12',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
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
                          child: const Padding(
                            padding:  EdgeInsets.only(
                                left: 4.0, right: 4, top: 4, bottom: 4),
                            child:  Text(
                              '10% Б',
                              textAlign: TextAlign.center,
                              style:  TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4)),
                          child:  Padding(
                            padding:const EdgeInsets.only(
                                left: 4.0, right: 4, top: 4, bottom: 4),
                            child: Text(
                              '-${procentPrice.roundToDouble()}%',
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
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 205,
                  child:Row(
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
                           onPressed: () async{
                         final favorite =  BlocProvider.of<FavoriteCubit>(context);
                         await favorite.favorite(widget.product.id.toString());
                            setState(() {
                              inFavorite = !inFavorite;
                            });
                          },
                        splashRadius: 1.00,
                          icon: inFavorite == true ? SvgPicture.asset('assets/icons/heart_fill.svg') : SvgPicture.asset('assets/icons/favorite.svg' ,
                            color:  inFavorite == true ? Colors.red : Colors.grey,
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
                      initialRating: double.parse(widget.product.rating.toString()),
                      minRating: 0,
                      maxRating: 5,
                      itemCount: 5,
                      // unratedColor: const Color(0x30F11712),
                      itemSize: 15,
                      unratedColor: Color(0xFFFFC107),
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
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                (compoundPrice  != null || compoundPrice == 0) ?
                Row(
                  children:  [
                    Text(
                      '${compoundPrice}  ₸ ',
                      style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    Text(
                      '${widget.product.price}₸ ',
                      style: const TextStyle(
                        color: AppColors.kGray900,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ) : Text(
              '${widget.product.price}₸ ',
              style: const TextStyle(
              color: AppColors.kGray900,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              decoration: TextDecoration.lineThrough,
              ),),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFC107),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child:  Text(
                        '${widget.product.price ?? 0 / 12}',
                        style:const TextStyle(
                            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.02,
                    ),
                    const Text('х3' , style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(197,200,204, 1)
                    ),),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.12,
                    ),
                    count < 1
                        ? SizedBox()
                        : Visibility(
                            visible: isvisible,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                     BlocProvider.of<BasketCubit>(context).basketMinus(widget.product.id.toString() , '1');
                                    setState(() {
                                      if(count == 0){
                                        isvisible = false;
                                      }else
                                      {
                                        isvisible = true;
                                      }
                                      count -= 1;
                                    });
                                  },
                                  child:  Container(
                                    height: 32,
                                    width: 32,
                                    padding: const EdgeInsets.all(4),
                                    child:  SvgPicture.asset(
                                      count == 1 ?'assets/icons/basket_1.svg' : 'assets/icons/minus.svg',
                                      width: 3.12,
                                      height: 15,
                                    ),
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
                                  ),
                                ),
                                const SizedBox(
                                  width: 14,
                                ),
                                Text('$count'),
                                const SizedBox(
                                  width: 14,
                                ),
                                InkWell(
                                  onTap: () {
                                     BlocProvider.of<BasketCubit>(context).basketAdd(widget.product.id.toString() , '1');

                                    setState(() {
                                      count += 1;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    child: SvgPicture.asset(
                                        'assets/icons/add_1.svg'),
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                    count >= 1
                        ? const SizedBox()
                        : InkWell(
                            onTap: () {
                               BlocProvider.of<BasketCubit>(context).basketAdd(widget.product.id.toString() , '1');
                              setState(() {
                                count += 1;
                                if(count == 0){
                                  isvisible = false;
                                }else
                                {
                                  isvisible = true;
                                }
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.26,
                              height: 32,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1DC4CF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, bottom: 6, top: 6),
                              child: const Center(
                                child: Text(
                                  'В корзину',
                                  // textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                  ],
                )
              ],
            )
          ],
        ),
    );
  }
}
