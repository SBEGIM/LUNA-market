import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/feature/seller/order/presentation/widgets/detail_order_seller_page.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../bloc/basket_seller_cubit.dart';
import '../../bloc/basket_seller_state.dart';

class AllOrdersRealFbsSellerPage extends StatefulWidget {
  String fulfillment;
  AllOrdersRealFbsSellerPage({required this.fulfillment, Key? key}) : super(key: key);

  @override
  State<AllOrdersRealFbsSellerPage> createState() => _AllOrdersRealFbsSellerPageState();
}

class _AllOrdersRealFbsSellerPageState extends State<AllOrdersRealFbsSellerPage> {
  final RefreshController _controller = RefreshController();
  String status = '';

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

  @override
  void initState() {
    BlocProvider.of<BasketSellerCubit>(context).basketOrderRealFBSshow('realFBS');
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
                BlocProvider.of<BasketSellerCubit>(context).basketOrderRealFBSshow('realFBS');
                _controller.refreshCompleted();
              },
              controller: _controller,
              child: ListView.builder(
                itemCount: state.basketOrderRealFbsModel.length,
                itemBuilder: (context, index) {
                  text(state.basketOrderRealFbsModel[index].status);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${state.basketOrderRealFbsModel[index].date}',
                        style: const TextStyle(
                          color: AppColors.kGray300,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailOrderSellerPage(
                                basket: state.basketOrderRealFbsModel[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
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
                                        '№${state.basketOrderRealFbsModel[index].id}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.kGray700,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      SvgPicture.asset('assets/icons/master_card.svg'),
                                    ],
                                  ),
                                  const Icon(Icons.more_horiz),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.timer, color: AppColors.kGray300),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${state.basketOrderRealFbsModel[index].returnDate}',
                                    style: const TextStyle(
                                      color: AppColors.kGray300,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: state.basketOrderRealFbsModel[index].product!.length * 20,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.basketOrderRealFbsModel[index].product!.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          state
                                              .basketOrderRealFbsModel[index]
                                              .product![i]
                                              .productName
                                              .toString(),
                                          style: const TextStyle(
                                            color: AppColors.kGray750,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          state.basketOrderRealFbsModel[index].product![i].count
                                              .toString(),
                                          style: const TextStyle(
                                            color: AppColors.kGray750,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          state.basketOrderRealFbsModel[index].product![i].price
                                              .toString(),
                                          style: const TextStyle(
                                            color: AppColors.kGray750,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Сумма заказа:',
                                    style: TextStyle(
                                      color: AppColors.kGray400,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '${state.basketOrderRealFbsModel[index].summa.toString()} ₽',
                                    style: const TextStyle(
                                      color: AppColors.kGray750,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/user.svg',
                                    color: AppColors.kGray400,
                                  ),
                                  Text(
                                    ' ${state.basketOrderRealFbsModel[index].user!.fullName}',
                                    style: const TextStyle(
                                      color: AppColors.kGray500,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0x104BB34B),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  status,
                                  style: const TextStyle(
                                    color: Color(0xFF4BB34B),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            );
          } else {
            return SmartRefresher(
              onRefresh: () {
                BlocProvider.of<BasketSellerCubit>(context).basketOrderRealFBSshow('realFBS');
                _controller.refreshCompleted();
              },
              controller: _controller,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Center(child: CircularProgressIndicator(color: Colors.indigoAccent))],
              ),
            );
          }
        },
      ),
    );
  }
}
