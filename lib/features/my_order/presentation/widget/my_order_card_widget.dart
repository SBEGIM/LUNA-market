import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/widgets/error_image_widget.dart';
import 'package:haji_market/features/basket/data/models/basket_order_model.dart';
import 'package:haji_market/features/my_order/presentation/widget/my_order_status_page.dart';

class MyOrderCardWidget extends StatefulWidget {
  final BasketOrderModel basketOrder;

  const MyOrderCardWidget({required this.basketOrder, Key? key}) : super(key: key);

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 12,
        ),
        Text(
          '${widget.basketOrder.date}',
          style: const TextStyle(color: AppColors.kGray300, fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Заказ № ${widget.basketOrder.id}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: AppColors.kGray900, fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              // if (widget.basketOrder.product != null &&
              //     widget.basketOrder.product!.isNotEmpty &&
              //     widget.basketOrder.product!.first.path != null &&
              //     widget.basketOrder.product!.first.path!.isNotEmpty)
              //   Image.network(
              //     "http://185.116.193.73/storage/${widget.basketOrder.product!.first.path!.first.toString()}",
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Тип доставки:',
                          style: TextStyle(color: AppColors.kGray400, fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'FBS',
                          style: TextStyle(color: AppColors.kGray750, fontSize: 12, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Доставка:',
                          style: TextStyle(color: AppColors.kGray400, fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${widget.basketOrder.deliveryDay} дней',
                          style: const TextStyle(color: AppColors.kGray750, fontSize: 12, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Статус:',
                          style: TextStyle(color: AppColors.kGray400, fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        Container(
                          decoration:
                              BoxDecoration(color: const Color(0x104BB34B), borderRadius: BorderRadius.circular(4)),
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                statusFBS,
                                style: const TextStyle(
                                    color: Color(0xFF4BB34B), fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              if ((widget.basketOrder.productFBS?.isNotEmpty ?? false) &&
                  (widget.basketOrder.productRealFBS?.isNotEmpty ?? false))
                const Divider(
                  height: 1,
                  color: AppColors.kGray300,
                ),
              const SizedBox(height: 8),
              if (widget.basketOrder.productRealFBS?.isNotEmpty ?? false)
                Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Тип доставки:',
                          style: TextStyle(color: AppColors.kGray400, fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'realFBS',
                          style: TextStyle(color: AppColors.kGray750, fontSize: 12, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Доставка:',
                          style: TextStyle(color: AppColors.kGray400, fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Неизвестно',
                          style: TextStyle(color: AppColors.kGray750, fontSize: 12, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Статус:',
                          style: TextStyle(color: AppColors.kGray400, fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        Container(
                          decoration:
                              BoxDecoration(color: const Color(0x104BB34B), borderRadius: BorderRadius.circular(4)),
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                statusRealFBS,
                                style: const TextStyle(
                                    color: Color(0xFF4BB34B), fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              const SizedBox(
                height: 8,
              ),
              // const Divider(
              //   height: 1,
              //   color: AppColors.kGray300,
              // ),
              Container(
                padding: const EdgeInsets.only(top: 8),
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    widget.basketOrder.id != null
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyOrderStatusPage(basketOrder: widget.basketOrder)),
                          )
                        : printError();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Детали заказа',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.kPrimaryColor),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.kPrimaryColor,
                        size: 18,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
