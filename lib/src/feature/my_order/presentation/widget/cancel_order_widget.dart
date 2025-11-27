import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/seller/order/bloc/order_status_seller_cubit.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/basket/bloc/basket_cubit.dart';

class CancelOrderWidget extends StatefulWidget {
  String id;

  CancelOrderWidget({required this.id, Key? key}) : super(key: key);

  @override
  State<CancelOrderWidget> createState() => _CancelOrderWidgetState();
}

class _CancelOrderWidgetState extends State<CancelOrderWidget> {
  int selectIndex = -1;

  List<String> cancel = [
    'Передумал покупать',
    'Сроки доставки изменились',
    'У продавца нет товара в наличии',
    'У продавца нет цвета/размера/модели',
    'Продавец предлагал другую модель/\nтовар',
    'Товар не соответствует описанию/\nфото',
    'Другое',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            height: 9.5,
            width: 16.5,
            child: Image.asset(Assets.icons.defaultBackIcon.path),
          ),
        ),
        //   iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text('Выберите причину', style: AppTextStyles.appBarTextStyle),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 8, right: 12),
            child: SizedBox(
              height: cancel.length * 48 + 110,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cancel.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      selectIndex = index;
                      setState(() {});
                    },
                    child: Container(
                      height: index == 4 || index == 5 ? 68 : 48,
                      margin: EdgeInsets.only(top: 8),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: 290,
                              child: Text(
                                cancel[index],
                                maxLines: 2,
                                style: AppTextStyles.size16Weight600,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            width: 20,
                            height: 20,
                            child: Image.asset(
                              selectIndex == index
                                  ? Assets.icons.defaultCheckIcon.path
                                  : Assets.icons.defaultUncheckIcon.path,
                              scale: 2.1,
                              color: selectIndex == index ? AppColors.kLightBlackColor : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomSheet: SafeArea(
        bottom: true,
        child: Container(
          color: AppColors.kBackgroundColor,
          child: BlocConsumer<OrderStatusSellerCubit, OrderStatusSellerState>(
            listener: (context, state) {
              if (state is CancelState) {
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 2);
                BlocProvider.of<BasketCubit>(context).basketOrderShow(status: '');

                AppSnackBar.show(context, 'Заказ успешно отменен', type: AppSnackType.success);
                BlocProvider.of<OrderStatusSellerCubit>(context).toInitState();
              }
            },
            builder: (context, state) {
              return InkWell(
                onTap: () async {
                  if (selectIndex == -1) {
                    AppSnackBar.show(context, 'Выберите причину отказа!', type: AppSnackType.error);
                  } else {
                    BlocProvider.of<OrderStatusSellerCubit>(
                      context,
                    ).cancelOrder(widget.id, 'cancel', cancel[selectIndex]);
                  }
                },
                child: Container(
                  height: 52,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.mainPurpleColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: state is LoadingState
                      ? const SizedBox(
                          height: 51,
                          child: Center(child: CircularProgressIndicator.adaptive()),
                        )
                      : Text(
                          'Отменить заказ',
                          style: AppTextStyles.size18Weight600.copyWith(color: AppColors.kWhite),
                        ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
