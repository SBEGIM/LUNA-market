import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/feature/seller/order/bloc/order_status_seller_cubit.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/basket/bloc/basket_cubit.dart';

class CancelOrderWidget extends StatefulWidget {
  String id;

  CancelOrderWidget({required this.id, Key? key}) : super(key: key);

  @override
  State<CancelOrderWidget> createState() => _CancelOrderWidgetState();
}

class _CancelOrderWidgetState extends State<CancelOrderWidget> {
  int selectIndex = -1;

  List<String> cancel = [
    'Не устрайвает сроки',
    'Товара нет в наличи',
    'Продовец попросил отменить',
    'Другое'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
          leading: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                height: 9.5,
                width: 16.5,
                child: SvgPicture.asset('assets/icons/back_header.svg',
                    height: 9.5, width: 16.5),
              )),
          //   iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            'Выберите причину',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          )),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 8, right: 12),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      selectIndex = 0;
                      setState(() {});
                    },
                    child: SizedBox(
                      height: 50,
                      child: ListTile(
                        title: Text(
                          cancel[0],
                          style: const TextStyle(
                              color: AppColors.kGray900,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: selectIndex == 0
                            ? const Icon(
                                Icons.done,
                                color: AppColors.kPrimaryColor,
                              )
                            : null,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectIndex = 1;
                      setState(() {});
                    },
                    child: SizedBox(
                      height: 50,
                      child: ListTile(
                        title: Text(
                          cancel[1],
                          style: const TextStyle(
                              color: AppColors.kGray900,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: selectIndex == 1
                            ? const Icon(
                                Icons.done,
                                color: AppColors.kPrimaryColor,
                              )
                            : null,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectIndex = 2;
                      setState(() {});
                    },
                    child: SizedBox(
                      height: 50,
                      child: ListTile(
                        title: Text(
                          cancel[2],
                          style: const TextStyle(
                              color: AppColors.kGray900,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: selectIndex == 2
                            ? const Icon(
                                Icons.done,
                                color: AppColors.kPrimaryColor,
                              )
                            : null,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      selectIndex = 3;
                      setState(() {});
                    },
                    child: SizedBox(
                      height: 50,
                      child: ListTile(
                        title: Text(
                          cancel[3],
                          style: const TextStyle(
                              color: AppColors.kGray900,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: selectIndex == 3
                            ? const Icon(
                                Icons.done,
                                color: AppColors.kPrimaryColor,
                              )
                            : null,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomSheet: BlocConsumer<OrderStatusSellerCubit, OrderStatusSellerState>(
          listener: (context, state) {
        if (state is CancelState) {
          int count = 0;
          Navigator.of(context).popUntil((_) => count++ >= 2);
          BlocProvider.of<BasketCubit>(context).basketOrderShow();
          Get.snackbar('Заказ', 'Заказ успешно отменен',
              backgroundColor: Colors.blueAccent);
          BlocProvider.of<OrderStatusSellerCubit>(context).toInitState();
        }
      }, builder: (context, state) {
        return Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
          child: InkWell(
            onTap: () async {
              if (selectIndex == -1) {
                Get.snackbar('Ошибка', 'Выберите причину отказа!',
                    backgroundColor: Colors.red);
              } else {
                BlocProvider.of<OrderStatusSellerCubit>(context)
                    .cancelOrder(widget.id, 'cancel', cancel[selectIndex]);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.kPrimaryColor,
              ),
              width: MediaQuery.of(context).size.width,
              child: state is LoadingState
                  ? const SizedBox(
                      height: 51,
                      child:
                          Center(child: CircularProgressIndicator.adaptive()))
                  : const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Отменить заказ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
          ),
        );
      }),
    );
  }
}
