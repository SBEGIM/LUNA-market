import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/basket/data/models/basket_order_model.dart';
import 'package:haji_market/src/feature/my_order/presentation/widget/my_order_status_page.dart';

class MyOrderCardWidget extends StatefulWidget {
  final BasketOrderModel basketOrder;

  const MyOrderCardWidget({required this.basketOrder, Key? key})
      : super(key: key);

  @override
  State<MyOrderCardWidget> createState() => _MyOrderCardWidgetState();
}

class _MyOrderCardWidgetState extends State<MyOrderCardWidget> {
  String statusFBS = '';
  String statusRealFBS = '';

  @override
  void initState() {
    switch (widget.basketOrder.statusFBS) {
      case 'order':
        {
          statusFBS = 'Заказ оформлен';
        }
        break;

      case 'accepted':
        {
          statusFBS = 'Заказ оформлен';
        }
        break;

      case 'courier':
        {
          statusFBS = 'Передан службе доставка';
        }
        break;
      case 'error':
        {
          statusFBS = 'Ошибка';
        }
        break;
      case 'cancel':
        {
          statusFBS = 'Клиент отменил заказ';
        }
        break;
      case 'rejected':
        {
          statusFBS = 'Магазин отменил заказ';
        }
        break;
      case 'end':
        {
          statusFBS = 'Заказ окончен';
        }
        break;
      case 'in_process':
        {
          statusFBS = 'В процессе';
        }
        break;
      case 'success':
        {
          statusFBS = 'Принять';
        }
        break;
      default:
        {
          statusFBS = 'Неизвестно';
        }
        break;
    }

    switch (widget.basketOrder.statusRealFBS) {
      case 'order':
        {
          statusRealFBS = 'Заказ оформлен';
        }
        break;

      case 'accepted':
        {
          statusRealFBS = 'Заказ оформлен';
        }
        break;

      case 'courier':
        {
          statusRealFBS = 'Передан службе доставка';
        }
        break;
      case 'error':
        {
          statusRealFBS = 'Ошибка';
        }
        break;
      case 'cancel':
        {
          statusRealFBS = 'Клиент отменил заказ';
        }
        break;
      case 'rejected':
        {
          statusRealFBS = 'Магазин отменил заказ';
        }
        break;
      case 'end':
        {
          statusRealFBS = 'Заказ окончен';
        }
        break;
      case 'in_process':
        {
          statusRealFBS = 'В процессе';
        }
        break;
      case 'success':
        {
          statusFBS = 'Принять';
        }
        break;
      default:
        {
          statusRealFBS = 'Неизвестно';
        }
        break;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.basketOrder.id != null
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MyOrderStatusPage(basketOrder: widget.basketOrder)),
              )
            : printError();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Заказ № ${widget.basketOrder.id}',
                          textAlign: TextAlign.right,
                          style: AppTextStyles.size14Weight500
                              .copyWith(color: Color(0xff8E8E93))),
                    ),
                    Text(
                      '${statusFBS ?? statusRealFBS}',
                      style: AppTextStyles.size14Weight500
                          .copyWith(color: AppColors.mainPurpleColor),
                    )
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                // if (widget.basketOrder.product != null &&
                //     widget.basketOrder.product!.isNotEmpty &&
                //     widget.basketOrder.product!.first.path != null &&
                //     widget.basketOrder.product!.first.path!.isNotEmpty)
                //   Image.network(
                //     "https://lunamarket.ru/storage/${widget.basketOrder.product!.first.path!.first.toString()}",
                //     height: 80,
                //     width: 80,
                //     errorBuilder: (context, error, stackTrace) => const ErrorImageWidget(
                //       height: 80,
                //       width: 80,
                //     ),
                //   )
                // else
                //   const ErrorImageWidget(
                //     height: 80,
                //     width: 80,
                //   ),

                if (widget.basketOrder.productFBS?.isNotEmpty ?? false)
                  Column(
                    children: [
                      // const Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       'Тип доставки:',
                      //       style: TextStyle(
                      //           color: AppColors.kGray400,
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.w500),
                      //     ),
                      //     Text(
                      //       'FBS',
                      //       style: TextStyle(
                      //           color: AppColors.kGray750,
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.w500),
                      //     )
                      //   ],
                      // ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.basketOrder.deliveryDay} дней',
                            style: AppTextStyles.size16Weight500
                                .copyWith(color: Color(0xff3A3A3C)),
                          ),
                          Text(
                            '${widget.basketOrder.priceFBS ?? widget.basketOrder.priceRealFBS} ₽',
                            style: AppTextStyles.size16Weight700
                                .copyWith(color: Color(0xff3A3A3C)),
                          ),
                        ],
                      ),
                    ],
                  ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.basketOrder.product?.length ?? 0,
                          itemBuilder: (BuildContext context, int i) {
                            final path = widget.basketOrder.product?[i].path
                                        ?.isNotEmpty ==
                                    true
                                ? widget.basketOrder.product![i].path!.first
                                : null;
                            final url = path != null
                                ? 'https://lunamarket.ru/storage/$path'
                                : null;

                            final dpr = MediaQuery.of(context).devicePixelRatio;
                            final cacheSize = (48 * dpr).round();
                            return Container(
                              height: 48,
                              width: 48,
                              margin: EdgeInsets.only(right: 9, top: 12),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.kGray200,
                              ),
                              child: url == null
                                  ? const Icon(
                                      Icons.image_not_supported_outlined)
                                  : Image.network(
                                      url,
                                      fit: BoxFit.cover,
                                      cacheWidth: cacheSize,
                                      cacheHeight: cacheSize,
                                      loadingBuilder:
                                          (context, child, progress) {
                                        if (progress == null) return child;
                                        return const Center(
                                            child: SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2),
                                        ));
                                      },
                                      errorBuilder: (context, error, stack) =>
                                          const Icon(
                                              Icons.broken_image_outlined),
                                    ),
                            );
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
