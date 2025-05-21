import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/feature/seller/order/bloc/basket_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/order/presentation/widgets/all_orders_seller_page.dart';
import 'package:haji_market/src/feature/seller/order/presentation/widgets/done_order_seller_page.dart';
import 'package:haji_market/src/core/common/constants.dart';
import '../../../../app/widgets/custom_switch_button.dart';

@RoutePage()
class MyOrdersSellerPage extends StatefulWidget {
  const MyOrdersSellerPage({super.key});

  @override
  State<MyOrdersSellerPage> createState() => _MyOrdersSellerPageState();
}

class _MyOrdersSellerPageState extends State<MyOrdersSellerPage> {
  int segmentValue = 0;
  final TextEditingController _searchController = TextEditingController();

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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.kBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey[600],
                        size: 20,
                      ),
                      hintText: 'Поиск...',
                      hintStyle: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                              onPressed: () {
                                _searchController.clear();
                                // Add any search clearing logic here
                                setState(() {});
                              },
                            )
                          : null,
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    onChanged: (value) {
                      // Add your search logic here
                      setState(() {});
                    },
                    onSubmitted: (value) {
                      // Add your search submission logic here
                    },
                  ),
                ),
                Container(
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppColors.kBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 48,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          physics: const BouncingScrollPhysics(),
                          children: [
                            _buildSegmentItem(
                              index: 0,
                              status: '',
                              label: 'Все',
                              isActive: segmentValue == 0,
                              width: 72,
                            ),
                            const SizedBox(width: 8),
                            _buildSegmentItem(
                              index: 1,
                              label: 'Новые',
                              status: 'active',
                              isActive: segmentValue == 1,
                              width: 84,
                            ),
                            const SizedBox(width: 8),
                            _buildSegmentItem(
                              index: 2,
                              label: 'В процессе',
                              status: 'in_process',
                              isActive: segmentValue == 2,
                              width: 108,
                            ),
                            const SizedBox(width: 8),
                            _buildSegmentItem(
                              index: 3,
                              label: 'Завершенные',
                              status: 'end',
                              isActive: segmentValue == 3,
                              width: 120,
                            ),
                            const SizedBox(width: 8),
                            _buildSegmentItem(
                              index: 4,
                              label: 'Отмененные',
                              status: 'cancel',
                              isActive: segmentValue == 4,
                              width: 120,
                            ),
                            const SizedBox(width: 8),
                            _buildSegmentItem(
                              index: 5,
                              label: 'Спорные',
                              status: 'error',
                              isActive: segmentValue == 5,
                              width: 108,
                            ),
                          ],
                        ),
                      ),
                    ],
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
            children: [
              AllOrdersSellerPage(fulfillment: 'fbs'),

              //  AllMyOrdersRealFBSPage(fulfillment: 'realFBS'),
              const DoneMyOrdersPage(),
            ],
          ),
        ));
  }

  Widget _buildSegmentItem({
    required int index,
    required String label,
    required String status,
    required bool isActive,
    required double width,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          segmentValue = index;
          BlocProvider.of<BasketSellerCubit>(context).basketOrderShow(status);
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isActive ? AppColors.mainPurpleColor : Colors.white,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isActive ? Colors.white : Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }
}
