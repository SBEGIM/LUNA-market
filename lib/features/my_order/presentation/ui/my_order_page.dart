import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/my_order/presentation/widget/my_order_card_widget.dart';
import 'package:haji_market/features/my_order/presentation/widget/my_order_status_page.dart';
import 'package:haji_market/features/profile/data/presentation/widgets/show_dialog_redirect.dart';
import 'package:haji_market/features/my_order/presentation/widget/show_filter_dialog.dart';

import '../../../drawer/presentation/ui/drawer_home.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({Key? key}) : super(key: key);

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
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
                  child: const Icon(Icons.schema_rounded)),
            )
          ],
          centerTitle: true,
          title: const Text(
            'История заказов',
            style: TextStyle(
              color: Colors.black,
            ),
          )),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return const MyOrderCardWidget();
                }),
          ],
        ),
      ),
    );
  }
}
