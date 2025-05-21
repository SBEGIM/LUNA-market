import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/feature/seller/order/presentation/widgets/detail_order_seller_page.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../bloc/basket_seller_cubit.dart';
import '../../bloc/basket_seller_state.dart';

class AllOrdersSellerPage extends StatefulWidget {
  String fulfillment;
  AllOrdersSellerPage({required this.fulfillment, Key? key}) : super(key: key);

  @override
  State<AllOrdersSellerPage> createState() => _AllOrdersSellerPageState();
}

class _AllOrdersSellerPageState extends State<AllOrdersSellerPage> {
  final RefreshController _controller = RefreshController();
  String status = '';
  String statusFBS = '';
  String statusRealFBS = '';

  text(sts) {
    switch (sts) {
      case 'order':
        {
          status = 'Заказ оформлен';
        }
        break;

      case 'courier':
        {
          status = 'Передан службе доставка';
        }
        break;
      case 'error':
        {
          status = 'Ошибка';
        }
        break;
      case 'cancel':
        {
          status = 'Клиент отменил заказ';
        }
        break;
      case 'rejected':
        {
          status = 'Магазин отменил заказ';
        }
        break;
      case 'end':
        {
          status = 'Заказ окончен';
        }
        break;
      case 'in_process':
        {
          status = 'В процессе';
        }
        break;
      case 'success':
        {
          status = 'Заказ принят';
        }
        break;
      default:
        {
          status = 'Неизвестно';
        }
        break;
    }
  }

  textFBS(sts) {
    switch (sts) {
      case 'order':
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
          statusFBS = 'Заказ принят';
        }
        break;
      default:
        {
          statusFBS = 'Неизвестно';
        }
        break;
    }
  }

  textRealFBS(sts) {
    switch (sts) {
      case 'order':
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
          statusRealFBS = 'Заказ принят';
        }
        break;
      default:
        {
          statusRealFBS = 'Неизвестно';
        }
        break;
    }
  }

  @override
  void initState() {
    BlocProvider.of<BasketSellerCubit>(context).basketOrderShow('fbs');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 45),
        child: BlocConsumer<BasketSellerCubit, BasketAdminState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ErrorState) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                );
              }

              if (state is LoadedState) {
                return SmartRefresher(
                  onRefresh: () {
                    BlocProvider.of<BasketSellerCubit>(context)
                        .basketOrderShow('fbs');
                    _controller.refreshCompleted();
                  },
                  controller: _controller,
                  child: ListView.builder(
                    itemCount: state.basketOrderModel.length,
                    itemBuilder: (context, index) {
                      text(state.basketOrderModel[index].status);
                      textFBS(state.basketOrderModel[index].statusFBS);
                      textRealFBS(state.basketOrderModel[index].statusRealFBS);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailOrderSellerPage(
                                        basket: state.basketOrderModel[index])),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '№${state.basketOrderModel[index].id}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.kGray300),
                                      ),
                                      Text(
                                        statusFBS,
                                        style: const TextStyle(
                                            color: Color(0xFF4BB34B),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      // const Icon(Icons.more_horiz),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${state.basketOrderModel[index].date}',
                                        style: AppTextStyles
                                            .navigationUnSelectLabelStyle
                                            .copyWith(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                          '${state.basketOrderModel[index].priceFBS} ₽',
                                          style: AppTextStyles
                                              .counterSellerProfileTextStyle),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  if (state.basketOrderModel[index].productFBS
                                          ?.isNotEmpty ??
                                      false)
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: (state.basketOrderModel[index]
                                                      .productFBS?.length ??
                                                  0) *
                                              60,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: state
                                                      .basketOrderModel[index]
                                                      .productFBS
                                                      ?.length ??
                                                  0,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int i) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 48,
                                                      width: 48,
                                                      child: Image.network(
                                                        "https://lunamarket.ru/storage/${state.basketOrderModel[index].productFBS![i].path![0].toString()}",
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  if ((state.basketOrderModel[index].productFBS
                                              ?.isNotEmpty ??
                                          false) &&
                                      (state.basketOrderModel[index]
                                              .productRealFBS?.isNotEmpty ??
                                          false))
                                    const Divider(
                                      color: AppColors.kGray400,
                                    ),
                                  if (state.basketOrderModel[index]
                                          .productRealFBS?.isNotEmpty ??
                                      false)
                                    Column(children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        height: (state.basketOrderModel[index]
                                                    .productRealFBS?.length ??
                                                0) *
                                            30,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: state
                                                    .basketOrderModel[index]
                                                    .productRealFBS
                                                    ?.length ??
                                                0,
                                            itemBuilder:
                                                (BuildContext context, int i) {
                                              return SizedBox(
                                                height: 20,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      state
                                                          .basketOrderModel[
                                                              index]
                                                          .productRealFBS![i]
                                                          .productName
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: AppColors
                                                              .kGray750,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      'x' +
                                                          state
                                                              .basketOrderModel[
                                                                  index]
                                                              .productRealFBS![
                                                                  i]
                                                              .count
                                                              .toString(),
                                                      style: const TextStyle(
                                                          color: AppColors
                                                              .kGray750,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      state
                                                          .basketOrderModel[
                                                              index]
                                                          .productRealFBS![i]
                                                          .price
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: AppColors
                                                              .kGray750,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Сумма заказа:',
                                            style: TextStyle(
                                                color: AppColors.kGray400,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            '${state.basketOrderModel[index].priceRealFBS} ₽',
                                            style: const TextStyle(
                                                color: AppColors.kGray750,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Способ доставки:',
                                            style: TextStyle(
                                                color: AppColors.kGray400,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            'realFBS',
                                            style: TextStyle(
                                                color: AppColors.kGray750,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Статус:',
                                            style: TextStyle(
                                                color: AppColors.kGray400,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: const Color(0x104BB34B),
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  statusRealFBS,
                                                  style: const TextStyle(
                                                      color: Color(0xFF4BB34B),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ]),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else {
                return SmartRefresher(
                  onRefresh: () {
                    BlocProvider.of<BasketSellerCubit>(context)
                        .basketOrderShow('fbs');
                    _controller.refreshCompleted();
                  },
                  controller: _controller,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: CircularProgressIndicator(
                              color: Colors.indigoAccent)),
                    ],
                  ),
                );
              }
            }));
  }
}
