import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/admin/my_orders_admin/presentation/widgets/detail_my_orders_page.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../data/bloc/basket_admin_cubit.dart';
import '../../data/bloc/basket_admin_state.dart';

class AllMyOrdersPage extends StatefulWidget {
  String fulfillment;
  AllMyOrdersPage({required this.fulfillment, Key? key}) : super(key: key);

  @override
  State<AllMyOrdersPage> createState() => _AllMyOrdersPageState();
}

class _AllMyOrdersPageState extends State<AllMyOrdersPage> {
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
    BlocProvider.of<BasketAdminCubit>(context).basketOrderShow('fbs');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 45),
        child: BlocConsumer<BasketAdminCubit, BasketAdminState>(
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
                    BlocProvider.of<BasketAdminCubit>(context).basketOrderShow('fbs');
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
                          Text(
                            '${state.basketOrderModel[index].date}',
                            style:
                                const TextStyle(color: AppColors.kGray300, fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailMyOrdersPage(basket: state.basketOrderModel[index])),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            '№${state.basketOrderModel[index].id}',
                                            style: const TextStyle(
                                                fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.kGray700),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          SvgPicture.asset('assets/icons/master_card.svg')
                                        ],
                                      ),
                                      // const Icon(Icons.more_horiz),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  // Row(
                                  //   children: [
                                  //     const Icon(
                                  //       Icons.timer,
                                  //       color: AppColors.kGray300,
                                  //     ),
                                  //     const SizedBox(
                                  //       width: 5,
                                  //     ),
                                  //     Text(
                                  //       '${state.basketOrderModel[index].returnDate}',
                                  //       style: const TextStyle(
                                  //           color: AppColors.kGray300, fontSize: 13, fontWeight: FontWeight.w400),
                                  //     )
                                  //   ],
                                  // ),
                                  // const SizedBox(
                                  //   height: 8,
                                  // ),

                                  if (state.basketOrderModel[index].productFBS?.isNotEmpty ?? false)
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: (state.basketOrderModel[index].productFBS?.length ?? 0) * 30,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemCount: state.basketOrderModel[index].productFBS?.length ?? 0,
                                              itemBuilder: (BuildContext context, int i) {
                                                return SizedBox(
                                                  height: 20,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: 160,
                                                        child: Text(
                                                          state.basketOrderModel[index].productFBS![i].productName
                                                              .toString(),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: const TextStyle(
                                                              color: AppColors.kGray750,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                      Text(
                                                        'x' +
                                                            state.basketOrderModel[index].product![i].count.toString(),
                                                        style: const TextStyle(
                                                            color: AppColors.kGray750,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500),
                                                      ),
                                                      Text(
                                                        state.basketOrderModel[index].product![i].price.toString(),
                                                        style: const TextStyle(
                                                            color: AppColors.kGray750,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Сумма заказа:',
                                              style: TextStyle(
                                                  color: AppColors.kGray400, fontSize: 12, fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              '${state.basketOrderModel[index].priceFBS} ₽',
                                              style: const TextStyle(
                                                  color: AppColors.kGray750, fontSize: 16, fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        const Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Способ доставки:',
                                              style: TextStyle(
                                                  color: AppColors.kGray400, fontSize: 12, fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              'FBS',
                                              style: TextStyle(
                                                  color: AppColors.kGray750, fontSize: 16, fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Статус:',
                                              style: TextStyle(
                                                  color: AppColors.kGray400, fontSize: 12, fontWeight: FontWeight.w500),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: const Color(0x104BB34B),
                                                  borderRadius: BorderRadius.circular(4)),
                                              padding: const EdgeInsets.all(5),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    statusFBS,
                                                    style: const TextStyle(
                                                        color: Color(0xFF4BB34B),
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),

                                  if ((state.basketOrderModel[index].productFBS?.isNotEmpty ?? false) &&
                                      (state.basketOrderModel[index].productRealFBS?.isNotEmpty ?? false))
                                    const Divider(
                                      color: AppColors.kGray400,
                                    ),

                                  if (state.basketOrderModel[index].productRealFBS?.isNotEmpty ?? false)
                                    Column(children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        height: (state.basketOrderModel[index].productRealFBS?.length ?? 0) * 30,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: state.basketOrderModel[index].productRealFBS?.length ?? 0,
                                            itemBuilder: (BuildContext context, int i) {
                                              return SizedBox(
                                                height: 20,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      state.basketOrderModel[index].productRealFBS![i].productName
                                                          .toString(),
                                                      style: const TextStyle(
                                                          color: AppColors.kGray750,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                    Text(
                                                      'x' +
                                                          state.basketOrderModel[index].productRealFBS![i].count
                                                              .toString(),
                                                      style: const TextStyle(
                                                          color: AppColors.kGray750,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500),
                                                    ),
                                                    Text(
                                                      state.basketOrderModel[index].productRealFBS![i].price.toString(),
                                                      style: const TextStyle(
                                                          color: AppColors.kGray750,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500),
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Сумма заказа:',
                                            style: TextStyle(
                                                color: AppColors.kGray400, fontSize: 12, fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            '${state.basketOrderModel[index].priceRealFBS} ₽',
                                            style: const TextStyle(
                                                color: AppColors.kGray750, fontSize: 16, fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Способ доставки:',
                                            style: TextStyle(
                                                color: AppColors.kGray400, fontSize: 12, fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            'realFBS',
                                            style: TextStyle(
                                                color: AppColors.kGray750, fontSize: 16, fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Статус:',
                                            style: TextStyle(
                                                color: AppColors.kGray400, fontSize: 12, fontWeight: FontWeight.w500),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: const Color(0x104BB34B), borderRadius: BorderRadius.circular(4)),
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  statusRealFBS,
                                                  style: const TextStyle(
                                                      color: Color(0xFF4BB34B),
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w400),
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
                    BlocProvider.of<BasketAdminCubit>(context).basketOrderShow('fbs');
                    _controller.refreshCompleted();
                  },
                  controller: _controller,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: CircularProgressIndicator(color: Colors.indigoAccent)),
                    ],
                  ),
                );
              }
            }));
  }
}
