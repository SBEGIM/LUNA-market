import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
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
  int segmentValue = 0;
  String currentStatus = '';

  final TextEditingController _searchController = TextEditingController();

  final RefreshController _refreshController = RefreshController();

  Future<void> onRefresh() async {
    await BlocProvider.of<BasketCubit>(context)
        .basketOrderShow(status: currentStatus);
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {});
    }
    _refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    await BlocProvider.of<BasketCubit>(context)
        .basketOrderShowPaginate(status: currentStatus);
    await Future.delayed(const Duration(milliseconds: 2000));

    _refreshController.loadComplete();
  }

  @override
  void initState() {
    BlocProvider.of<BasketCubit>(context)
        .basketOrderShow(status: currentStatus);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      drawer: const DrawerPage(),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: AppColors.kWhite,
        surfaceTintColor: AppColors.kWhite,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            Assets.icons.defaultBackIcon.path,
            scale: 2.1,
          ),
        ),
        centerTitle: true,
        title: const Text('Мои заказы', style: AppTextStyles.size18Weight600),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Container(
            color: AppColors.kBackgroundColor,
            child: Column(
              children: [
                Container(
                  height: 44,
                  margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xffEAECED),
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
                      hintStyle: AppTextStyles.size16Weight400
                          .copyWith(color: const Color(0xff8E8E93)),
                      contentPadding: EdgeInsets.zero,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Image.asset(
                          Assets.icons.defaultSearchIcon.path,
                          width: 18,
                          height: 18,
                        ),
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 18 + 5,
                        minHeight: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 72,
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
      ),
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
            if (state is NoDataState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 72,
                        width: 72,
                        child:
                            Image.asset(Assets.icons.defaultNoDataIcon.path)),
                    Text('Заказов пока нет',
                        style: AppTextStyles.size16Weight500),
                    Text(
                      'Здесь появятся заказы от покупателей',
                      style: AppTextStyles.size14Weight400
                          .copyWith(color: Color(0xff8E8E93)),
                    ),
                  ],
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
          setState(() {
            currentStatus = status;
          });

          BlocProvider.of<BasketCubit>(context).basketOrderShow(status: status);
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
            style: AppTextStyles.size14Weight500.copyWith(
              color: isActive ? Colors.white : Color(0xff636366),
            ),
          ),
        ),
      ),
    );
  }
}
