import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/my_order/presentation/widget/my_order_card_widget.dart';
import 'package:haji_market/features/my_order/presentation/widget/my_order_status_page.dart';
import 'package:haji_market/features/profile/data/presentation/widgets/show_dialog_redirect.dart';
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
      drawer: const DrawerHome(),
      appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: InkWell(
                  onTap: () {
                    showFilterDialog(context);
                  },
                  child: SvgPicture.asset('assets/icons/filter.svg')),
            )
          ],
          centerTitle: true,
          title: const Text(
            'История заказов',
            style: TextStyle(
              color: Colors.black,
            ),
          )),
      body: BlocConsumer<BasketCubit, BasketState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ErrorState) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(fontSize: 20.0, color: Colors.grey),
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
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 16),
                        child: MyOrderCardWidget(
                            basketOrder: state.basketOrderModel[index]));
                  });
            } else {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.indigoAccent));
            }
          }),
    );
  }
}
