import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/feature/seller/order/presentation/widgets/my_order_card_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../bloc/basket_seller_cubit.dart';
import '../../bloc/basket_seller_state.dart';

class AllOrdersSellerPage extends StatefulWidget {
  AllOrdersSellerPage({Key? key}) : super(key: key);

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

  @override
  void initState() {
    BlocProvider.of<BasketSellerCubit>(context).basketOrderShow('fbs');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 8, bottom: 100),
        child: BlocBuilder<BasketSellerCubit, BasketAdminState>(
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
                padding: EdgeInsets.zero,
                itemCount: state.basketOrderModel.length,
                itemBuilder: (context, index) {
                  return Container(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 16),
                      child: SellerMyOrderCardWidget(
                          basketOrder: state.basketOrderModel[index]));
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
