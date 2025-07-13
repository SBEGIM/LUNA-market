import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/basket/bloc/basket_cubit.dart';
import 'package:haji_market/src/feature/basket/data/DTO/basket_order_dto.dart';
import 'package:haji_market/src/feature/basket/data/models/basket_show_model.dart';
import 'package:haji_market/src/feature/chat/presentation/message.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/count_zero_dialog.dart';
import 'package:intl/intl.dart';

class BasketProductCardWidget extends StatefulWidget {
  final BasketShowModel basketProducts;
  final int count;
  final String fulfillment;
  const BasketProductCardWidget({
    required this.count,
    required this.basketProducts,
    required this.fulfillment,
    Key? key,
  }) : super(key: key);

  @override
  State<BasketProductCardWidget> createState() =>
      _BasketProductCardWidgetState();
}

class _BasketProductCardWidgetState extends State<BasketProductCardWidget> {
  int basketCount = 0;
  int basketPrice = 0;
  bool isVisible = true;
  String fulfillmentApi = 'fbs';
  bool isChecked = false;

  int compoundPrice = 0;

  List<basketOrderDTO> basketOrder = [];

  String formatPrice(int price) {
    final format = NumberFormat('#,###', 'ru_RU');
    return format.format(price).replaceAll(',', ' ');
  }

  @override
  void initState() {
    basketCount = widget.basketProducts.basketCount!.toInt();
    basketPrice = widget.basketProducts.price!.toInt();
    fulfillmentApi = widget.fulfillment;

    compoundPrice = (widget.basketProducts.product!.price!.toInt() *
            (((100 - widget.basketProducts.product!.compound!.toInt())) / 100))
        .toInt();

    // basketOrder[widget.count] = basketOrderDTO(product: ProductDTO(
    //   id: widget.basketProducts.product!.id!.toInt(),
    //   courier_price: widget.basketProducts.product!.courierPrice!.toInt(),
    //   compound: widget.basketProducts.product!.compound!.toInt(),
    //   shop_id: widget.basketProducts.product!.shopId!.toInt(),
    //   price: widget.basketProducts.product!.price!.toInt(),
    //   name: widget.basketProducts.product!.name.toString(),
    // ), basket: BasketDTO(
    //   basket_id: widget.basketProducts.basketId!.toInt(),
    //   price_courier: widget.basketProducts.priceCourier!.toInt(),
    //   price: widget.basketProducts.price!.toInt(),
    //   basket_count: widget.basketProducts.basketCount!.toInt(),
    //   basket_color: widget.basketProducts.basketColor.toString(),
    //   basket_size: widget.basketProducts.basketSize.toString(),
    //   shop_name: widget.basketProducts.shopName.toString(),
    //   address: [],
    // ));

    // basketOrder[widget.count] = basketOrderDTO(product: null, basket:  null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isVisible,
        child: SizedBox(
          height: 152,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.basketProducts.image != null &&
                  widget.basketProducts.image!.isNotEmpty)
                Stack(children: [
                  Container(
                    height: 94,
                    width: 104,
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(5), // White border effect
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          12), // Slightly smaller than container
                      child: Image.network(
                        widget.basketProducts.image != null
                            ? "https://lunamarket.ru/storage/${widget.basketProducts.image!.first}"
                            : "https://lunamarket.ru/storage/banners/2.png",
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.grey[100],
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
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
                          child: const Icon(Icons.broken_image,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 5.6,
                    top: 5.6,
                    child: InkWell(
                      onTap: () {
                        isChecked = !isChecked;
                        setState(() {});
                      },
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey, width: 1),
                          color: isChecked
                              ? AppColors.mainPurpleColor
                              : Colors.transparent,
                        ),
                        child: isChecked
                            ? const Icon(
                                Icons.check,
                                size: 16,
                                color: AppColors.kWhite,
                              )
                            : null,
                      ),
                    ),
                  ),
                ]),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18),
                              ),
                            ),
                            Text(
                              '${formatPrice(widget.basketProducts.product!.price!)} ₽ ',
                              style: const TextStyle(
                                color: AppColors.kGray300,
                                letterSpacing: -1,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: AppColors.kGray300,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          '${formatPrice(widget.basketProducts.product!.price!)} ₽ ',
                          style: const TextStyle(
                            color: AppColors.kGray900,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),

                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    '${(widget.basketProducts.product!.price!.toInt() - (widget.basketProducts.product!.price!.toInt() * (widget.basketProducts.product!.compound!.toInt() / 100))).toInt() * basketCount} ₽/$basketCount шт',
                    style: const TextStyle(
                      color: AppColors.kGray300,
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    width: 250,
                    child: Text(
                      '${widget.basketProducts.product!.name}',
                      style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.kGray300,
                          fontWeight: FontWeight.w400),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.basketProducts.optom == 1)
                        Container(
                          height: 32,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Оптом ${widget.basketProducts.basketCount} шт.',
                              style: const TextStyle(
                                  color: AppColors.kPrimaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      else
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: AppColors.kGray1,
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await BlocProvider.of<BasketCubit>(context)
                                      .basketMinus(
                                          widget.basketProducts.product!.id
                                              .toString(),
                                          '1',
                                          0,
                                          fulfillmentApi);

                                  basketCount--;
                                  int bottomPrice =
                                      GetStorage().read('bottomPrice');
                                  int bottomCount =
                                      GetStorage().read('bottomCount');
                                  bottomCount--;

                                  GetStorage()
                                      .write('bottomCount', bottomCount);

                                  basketPrice = (basketPrice -
                                      ((widget.basketProducts.product!.price!
                                              .toInt() -
                                          (widget.basketProducts.product!.price!
                                                      .toInt() *
                                                  (widget.basketProducts
                                                          .product!.compound!
                                                          .toInt() /
                                                      100))
                                              .toInt())));

                                  bottomPrice -= ((widget
                                          .basketProducts.product!.price!
                                          .toInt() -
                                      (widget.basketProducts.product!.price!
                                                  .toInt() *
                                              (widget.basketProducts.product!
                                                      .compound!
                                                      .toInt() /
                                                  100))
                                          .toInt()));

                                  if (basketCount == 0) {
                                    await BlocProvider.of<BasketCubit>(context)
                                        .basketShow(fulfillmentApi);
                                    isVisible = false;
                                  }

                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.remove,
                                  color: AppColors.mainPurpleColor,
                                ),
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              Text(
                                basketCount.toString(),
                                style:
                                    AppTextStyles.counterSellerProfileTextStyle,
                              ),
                              const SizedBox(
                                width: 14,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if ((widget.basketProducts.product?.count ??
                                          0) <=
                                      basketCount) {
                                    showCupertinoModalPopup<void>(
                                        context: context,
                                        builder: (context) =>
                                            CountZeroDialog(onYesTap: () {}));
                                    return;
                                  } else {
                                    BlocProvider.of<BasketCubit>(context)
                                        .basketAdd(
                                            widget.basketProducts.product!.id
                                                .toString(),
                                            '1',
                                            0,
                                            '',
                                            '');
                                    setState(() {
                                      basketCount++;
                                      basketPrice = (basketPrice +
                                          ((widget.basketProducts.product!
                                                  .price!
                                                  .toInt() -
                                              (widget.basketProducts.product!
                                                          .price!
                                                          .toInt() *
                                                      (widget
                                                              .basketProducts
                                                              .product!
                                                              .compound!
                                                              .toInt() /
                                                          100))
                                                  .toInt())));
                                    });

                                    int bottomPrice =
                                        GetStorage().read('bottomPrice');
                                    int bottomCount =
                                        GetStorage().read('bottomCount');
                                    bottomCount++;

                                    GetStorage()
                                        .write('bottomCount', bottomCount);
                                    bottomPrice += ((widget
                                            .basketProducts.product!.price!
                                            .toInt() -
                                        (widget.basketProducts.product!.price!
                                                    .toInt() *
                                                (widget.basketProducts.product!
                                                        .compound!
                                                        .toInt() /
                                                    100))
                                            .toInt()));
                                    GetStorage()
                                        .write('bottomPrice', bottomPrice);
                                  }
                                },
                                child: const Icon(
                                  Icons.add,
                                  color: AppColors.mainPurpleColor,
                                ),
                              )
                            ],
                          ),
                        ),
                    ],
                  )

                  // const SizedBox(
                  //   height: 8,
                  // ),
                  // Text(
                  //   'Продавец: ${widget.basketProducts.shopName}',
                  //   style: const TextStyle(
                  //       fontSize: 12,
                  //       color: AppColors.kGray900,
                  //       fontWeight: FontWeight.w400),
                  // ),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  // GestureDetector(
                  //   onTap: (() {
                  //     Get.to(() => MessagePage(
                  //         userId:
                  //             widget.basketProducts.product?.shopId,
                  //         name: widget.basketProducts.shopName,
                  //         avatar:
                  //             widget.basketProducts.image?.first ??
                  //                 '',
                  //         chatId: widget.basketProducts.chatId));
                  //   }),
                  //   child: Text(
                  //     widget.basketProducts.fulfillment != 'realFBS'
                  //         ? 'Доставка: ${widget.basketProducts.deliveryDay} дня'
                  //         : 'Узнать срок и цену доставки',
                  //     style: TextStyle(
                  //         fontSize: 14,
                  //         fontWeight: FontWeight.w400,
                  //         color:
                  //             widget.basketProducts.fulfillment ==
                  //                     'realFBS'
                  //                 ? Colors.orangeAccent
                  //                 : Colors.black),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ));
  }
}
