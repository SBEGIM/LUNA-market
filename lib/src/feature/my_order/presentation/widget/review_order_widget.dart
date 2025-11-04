import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import 'package:haji_market/src/feature/basket/data/models/basket_order_model.dart';
import 'package:haji_market/src/feature/drawer/bloc/review_cubit.dart';
import 'package:haji_market/src/feature/seller/order/bloc/order_status_seller_cubit.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/basket/bloc/basket_cubit.dart';

@RoutePage()
class ReviewOrderWidgetPage extends StatefulWidget {
  BasketOrderModel basketOrder;
  int index;

  ReviewOrderWidgetPage(
      {required this.basketOrder, required this.index, Key? key})
      : super(key: key);

  @override
  State<ReviewOrderWidgetPage> createState() => _ReviewOrderWidgetPageState();
}

class _ReviewOrderWidgetPageState extends State<ReviewOrderWidgetPage> {
  int selectIndex = -1;
  String productId = '';
  String productName = '';
  int rating = 0;

  TextEditingController _commentController = TextEditingController();

  List<String> cancel = [
    'Передумал покупать',
    'Сроки доставки изменились',
    'У продавца нет товара в наличии',
    'У продавца нет цвета/размера/модели',
    'Продавец предлагал другую модель/товар',
    'Товар не соответствует описанию/фото',
    'Другое'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  height: 9.5,
                  width: 16.5,
                  child: Image.asset(Assets.icons.defaultBackIcon.path))),
          //   iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: const Text('Оставить отзыв',
              style: AppTextStyles.appBarTextStyle)),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Container(
              height: 124,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              margin: EdgeInsets.only(top: 12, left: 16, right: 16),
              padding: const EdgeInsets.only(left: 20, right: 0, top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.basketOrder.productFBS != null &&
                      widget.basketOrder.productFBS?[widget.index].path !=
                          null &&
                      (widget.basketOrder.productFBS?[widget.index].path
                              ?.isNotEmpty ??
                          false))
                    buildProductImage(widget.index)
                  else
                    SizedBox.shrink(),
                  const SizedBox(
                    width: 16,
                  ),
                  SizedBox(
                    width: 238,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 238,
                          child: Text(
                            '${widget.basketOrder.productFBS?[widget.index].productName}',
                            style: AppTextStyles.size14Weight500,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 4),
                        SizedBox(
                          width: 238,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Сумма:',
                                style: AppTextStyles.size14Weight400
                                    .copyWith(color: Color(0xff8E8E93)),
                              ),
                              Text(
                                '${widget.basketOrder.productFBS?[widget.index].price} ₽',
                                style: AppTextStyles.size14Weight500,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 238,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Количество:',
                                style: AppTextStyles.size14Weight400
                                    .copyWith(color: Color(0xff8E8E93)),
                              ),
                              Text(
                                '${widget.basketOrder.productFBS?[widget.index].count} шт',
                                style: AppTextStyles.size14Weight500,
                              ),
                            ],
                          ),
                        ),

                        // const SizedBox(height: 4),
                        // GestureDetector(
                        //   onTap: () async {
                        //     if (inbasket != true) {
                        //       await BlocProvider.of<
                        //               BasketCubit>(context)
                        //           .basketAdd(
                        //               widget
                        //                   .basketOrder
                        //                   .productFBS?[
                        //                       index]
                        //                   .id,
                        //               '1',
                        //               0,
                        //               '',
                        //               '');
                        //       Get.snackbar('Успешно',
                        //           'Товар добавлен в корзину',
                        //           backgroundColor:
                        //               Colors.blueAccent);

                        //       inbasket = true;
                        //       setState(() {});
                        //     }
                        //   },
                        //   child: Container(
                        //     height: 32,
                        //     width: 136,
                        //     alignment: Alignment.center,
                        //     decoration: BoxDecoration(
                        //       color:
                        //           AppColors.mainPurpleColor,
                        //       borderRadius:
                        //           BorderRadius.circular(12),
                        //     ),
                        //     child: Text(
                        //       inbasket != true
                        //           ? 'В корзину'
                        //           : 'Добавлен в корзину',
                        //       style: AppTextStyles
                        //           .size13Weight500
                        //           .copyWith(
                        //               color:
                        //                   AppColors.kWhite),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              )),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Оцените товар',
                        style: AppTextStyles.size16Weight600,
                      ),
                      RatingBar.builder(
                        initialRating: 0,
                        minRating: 1,
                        itemSize: 28,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.only(right: 11.0),
                        unratedColor: Color(0xffE5E5EA),
                        itemBuilder: (context, _) => Image.asset(
                          Assets.icons.defaultStarIcon.path,
                          color: Color(0xffFFBE00),
                        ),
                        onRatingUpdate: (value) {
                          rating = value.toInt();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xffEDEDED),
                        borderRadius: BorderRadius.circular(16)),
                    child: TextFormField(
                      controller: _commentController,
                      maxLines: 5,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 16, top: 16),
                          hintText: 'Комментарий',
                          hintStyle: AppTextStyles.size16Weight400
                              .copyWith(color: Color(0xff8E8E93)),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(height: 12),
                  GestureDetector(
                    onTap: () async {},
                    child: DottedBorder(
                      dashPattern: [5, 5],
                      strokeWidth: 2,
                      color: AppColors.mainPurpleColor,
                      radius: Radius.circular(16),
                      borderType: BorderType.RRect,
                      child: Container(
                        alignment: Alignment.center,
                        height: 52,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '+Добавить фото',
                          style: AppTextStyles.size18Weight600
                              .copyWith(color: AppColors.mainPurpleColor),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Форматы: JPG, PNG. До 5 МБ каждое, до 5 фотографий',
                      style: AppTextStyles.size14Weight400
                          .copyWith(color: Color(0xff8E8E93)),
                    ),
                  )
                ]),
          ),
        ],
      ),
      bottomSheet: BlocConsumer<OrderStatusSellerCubit, OrderStatusSellerState>(
          listener: (context, state) {
        if (state is CancelState) {
          // int count = 0;
          // Navigator.of(context).popUntil((_) => count++ >= 2);
          // BlocProvider.of<BasketCubit>(context).basketOrderShow();
          // Get.snackbar('Заказ', 'Заказ успешно отменен',
          //     backgroundColor: Colors.blueAccent);
          // BlocProvider.of<OrderStatusSellerCubit>(context).toInitState();
        }
      }, builder: (context, state) {
        return SafeArea(
          bottom: true,
          child: InkWell(
            onTap: () async {
              await BlocProvider.of<ReviewCubit>(context).reviewStore(
                  _commentController.text, rating.toString(), productId);
              _commentController.clear();

              setState(() {});

              Get.snackbar('Успешно', 'отзыв добавлен',
                  backgroundColor: Colors.blueAccent);
            },
            child: Container(
              height: 52,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.mainPurpleColor,
              ),
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: state is LoadingState
                  ? const SizedBox(
                      height: 51,
                      child:
                          Center(child: CircularProgressIndicator.adaptive()))
                  : Text(
                      'Отправить',
                      style: AppTextStyles.size18Weight600
                          .copyWith(color: AppColors.kWhite),
                    ),
            ),
          ),
        );
      }),
    );
  }

  String? _imageUrlFor(int index) {
    final fbs = widget.basketOrder.productFBS;
    if (fbs == null || index < 0 || index >= fbs.length) return null;

    final paths = fbs[index].path; // предположительно List<String>?
    if (paths == null || paths.isEmpty) return null;

    final p = paths.first.trim();
    if (p.isEmpty) return null;

    return 'https://lunamarket.ru/storage/$p';
  }

  Widget buildProductImage(int index) {
    final url = _imageUrlFor(index);

    return SizedBox(
      width: 72,
      height: 72,
      child: url != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                url,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const ErrorImageWidget(width: 72, height: 72),
              ),
            )
          : const ErrorImageWidget(width: 72, height: 72),
    );
  }
}
