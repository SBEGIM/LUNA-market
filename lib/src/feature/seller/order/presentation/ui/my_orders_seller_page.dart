import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/seller/order/bloc/basket_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/order/bloc/basket_seller_state.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/seller/order/presentation/widgets/my_order_card_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

@RoutePage()
class MyOrdersSellerPage extends StatefulWidget {
  const MyOrdersSellerPage({super.key});

  @override
  State<MyOrdersSellerPage> createState() => _MyOrdersSellerPageState();
}

class _MyOrdersSellerPageState extends State<MyOrdersSellerPage> {
  int segmentValue = 0;
  final TextEditingController _searchController = TextEditingController();
  final RefreshController _controller = RefreshController();

  @override
  void initState() {
    BlocProvider.of<BasketSellerCubit>(context).basketOrderShow('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Мои заказы', style: AppTextStyles.appBarTextStyle),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Column(
            children: [
              Container(
                height: 44,
                margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xffF7F7F7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _searchController,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: 'Поиск',
                    hintStyle: AppTextStyles.size16Weight400.copyWith(
                      color: const Color(0xff8E8E93),
                    ),
                    contentPadding: EdgeInsets.zero,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Image.asset(
                        Assets.icons.defaultSearchIcon.path,
                        width: 18,
                        height: 18,
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(minWidth: 18 + 5, minHeight: 18),
                  ),
                ),
              ),
              Container(
                height: 72,
                decoration: BoxDecoration(
                  color: Color(0xffF7F7F7),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .05),
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 36,
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
                            width: 56,
                          ),
                          const SizedBox(width: 8),
                          _buildSegmentItem(
                            index: 1,
                            label: 'Новые',
                            status: 'active',
                            isActive: segmentValue == 1,
                            width: 74,
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
                            width: 122,
                          ),
                          const SizedBox(width: 8),
                          _buildSegmentItem(
                            index: 4,
                            label: 'Отмененные',
                            status: 'cancel',
                            isActive: segmentValue == 4,
                            width: 122,
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
      body: Padding(
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
                  BlocProvider.of<BasketSellerCubit>(context).basketOrderShow('');
                  _controller.refreshCompleted();
                },
                controller: _controller,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: state.basketOrderModel.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      child: SellerMyOrderCardWidget(basketOrder: state.basketOrderModel[index]),
                    );
                  },
                ),
              );
            } else {
              return SmartRefresher(
                onRefresh: () {
                  BlocProvider.of<BasketSellerCubit>(context).basketOrderShow('fbs');
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
      ),
    );
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
