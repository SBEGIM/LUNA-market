import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/my_order/presentation/widget/my_order_card_widget.dart';
import 'package:haji_market/features/my_order/presentation/widget/show_filter_dialog.dart';

import '../../../drawer/data/bloc/basket_cubit.dart';
import '../../../drawer/data/bloc/basket_state.dart';
import '../../../drawer/presentation/ui/drawer_home.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
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
            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
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
              return ListView.builder(
                  shrinkWrap: true,
                  // padding: const EdgeInsets.all(8),
                  itemCount: state.basketOrderModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        child: MyOrderCardWidget(basketOrder: state.basketOrderModel[index]));
                  });
            } else {
              return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
            }
          }),
    );
  }
}
