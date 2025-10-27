import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
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
  bool isChecked;
  BasketProductCardWidget({
    required this.count,
    required this.basketProducts,
    required this.fulfillment,
    required this.isChecked,
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
        child: Container(
          height: 152,
          padding: EdgeInsets.only(top: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.basketProducts.image != null &&
                  widget.basketProducts.image!.isNotEmpty)
                Stack(children: [
                  Container(
                    height: 94,
                    width: 114,
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.basketProducts.image != null
                            ? "https://lunamarket.ru/storage/${widget.basketProducts.image!.first}"
                            : "https://lunamarket.ru/storage/banners/2.png",
                        fit: BoxFit.cover,
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
                        widget.isChecked = !widget.isChecked;
                        setState(() {});
                      },
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.kWhite),
                        child: widget.isChecked
                            ? Image.asset(
                                Assets.icons.defaultCheckIcon.path,
                                height: 16,
                                width: 16,
                                color: AppColors.mainPurpleColor,
                              )
                            : Image.asset(
                                Assets.icons.defaultUncheckIcon.path,
                                height: 16,
                                width: 16,
                                color: AppColors.kAlpha12,
                              ),
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
                            Text(
                              '${formatPrice(compoundPrice)} ₽ ',
                              style: AppTextStyles.size18Weight700,
                            ),
                            Text(
                              '${formatPrice(widget.basketProducts.product!.price!)} ₽ ',
                              style: AppTextStyles.size14Weight400.copyWith(
                                color: Color(0xff8E8E93),
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Color(0xff8E8E93),
                              ),
                            ),
                          ],
                        )
                      : Text(
                          '${formatPrice(widget.basketProducts.product!.price!)} ₽ ',
                          style: AppTextStyles.size18Weight700,
                        ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${(widget.basketProducts.product!.price!.toInt() - (widget.basketProducts.product!.price!.toInt() * (widget.basketProducts.product!.compound!.toInt() / 100))).toInt() * basketCount} ₽/$basketCount шт',
                    style: AppTextStyles.size13Weight400
                        .copyWith(color: Color(0xff8E8E93)),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    width: 234,
                    child: Flexible(
                      child: Text(
                        '${widget.basketProducts.product?.name ?? ''}',
                        style: AppTextStyles.size13Weight400
                            .copyWith(color: Color(0xff636366)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.basketProducts.optom == 1)
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Color(0xffF7F7F7),
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Оптом ${widget.basketProducts.basketCount} шт.',
                              style: AppTextStyles.size16Weight600
                                  .copyWith(color: AppColors.mainPurpleColor),
                            ),
                          ),
                        )
                      else
                        Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                              color: Color(0xffF7F7F7),
                              borderRadius: BorderRadius.circular(100)),
                          alignment: Alignment.center,
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
                ],
              )
            ],
          ),
        ));
  }
}
