import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/my_order/presentation/widget/my_order_card_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../basket/bloc/basket_cubit.dart';
import '../../../basket/bloc/basket_state.dart';
import '../../../drawer/presentation/ui/drawer_home.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future<void> onRefresh() async {
    await BlocProvider.of<BasketCubit>(context).basketOrderShow();
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {});
    }
    _refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    await BlocProvider.of<BasketCubit>(context).basketOrderShow();
    await Future.delayed(const Duration(milliseconds: 2000));

    _refreshController.loadComplete();
  }

  @override
  void initState() {
    BlocProvider.of<BasketCubit>(context).basketOrderShow();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      drawer: const DrawerPage(),
      appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.kPrimaryColor,
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Мои заказы',
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          )),
      body: BlocConsumer<BasketCubit, BasketState>(
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

            if (state is LoadedOrderState) {
              return SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: true,
                onLoading: () {
                  onLoading();
                },
                onRefresh: () {
                  onRefresh();
                },
                child: ListView.builder(
                    shrinkWrap: true,
                    // padding: const EdgeInsets.all(8),
                    itemCount: state.basketOrderModel.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                          child: MyOrderCardWidget(
                              basketOrder: state.basketOrderModel[index]));
                    }),
              );
            } else {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.indigoAccent));
            }
          }),
    );
  }
}
