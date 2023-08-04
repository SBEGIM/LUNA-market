import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:haji_market/admin/my_orders_admin/presentation/widgets/all_my_orders_page.dart';
import 'package:haji_market/admin/my_orders_admin/presentation/widgets/done_my_orders_page.dart';
import 'package:haji_market/core/common/constants.dart';

import '../../../../features/app/widgets/custom_back_button.dart';
import '../../../../features/app/widgets/custom_switch_button.dart';
@RoutePage()
class MyOrdersAdminPage extends StatefulWidget {
  const MyOrdersAdminPage({Key? key}) : super(key: key);

  @override
  State<MyOrdersAdminPage> createState() => _MyOrdersAdminPageState();
}

class _MyOrdersAdminPageState extends State<MyOrdersAdminPage> {
  int segmentValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'Мои заказы',
            style: AppTextStyles.appBarTextStyle,
          ),
          // leading: Padding(
          //   padding: const EdgeInsets.only(left: 22.0),
          //   child: CustomBackButton(onTap: () {
          //     Navigator.pop(context);
          //   }),
          // ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Column(
              children: [
                Container(
                  height: 12,
                  color: AppColors.kBackgroundColor,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 16,
                    bottom: 8,
                    right: 16,
                    // right: screenSize.height * 0.016,
                  ),
                  child: CustomSwitchButton<int>(
                    groupValue: segmentValue,
                    children: {
                      0: Container(
                        alignment: Alignment.center,
                        height: 39,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'FBS',
                          style: TextStyle(
                            fontSize: 15,
                            color: segmentValue == 0
                                ? Colors.black
                                : const Color(0xff9B9B9B),
                          ),
                        ),
                      ),
                      1: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        height: 39,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Завершенные',
                          style: TextStyle(
                            fontSize: 14,
                            color: segmentValue == 1
                                ? Colors.black
                                : const Color(0xff9B9B9B),
                          ),
                        ),
                      ),
                      2: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        height: 39,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'realFBS',
                          style: TextStyle(
                            fontSize: 14,
                            color: segmentValue == 2
                                ? Colors.black
                                : const Color(0xff9B9B9B),
                          ),
                        ),
                      ),
                    },
                    onValueChanged: (int? value) async {
                      if (value != null) {
                        segmentValue = value;
                      }
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          color: AppColors.kBackgroundColor,
          child: IndexedStack(
            index: segmentValue,
            children: const [
              AllMyOrdersPage(),
              DoneMyOrdersPage(),
              DoneMyOrdersPage(),
            ],
          ),
        ));
  }
}
