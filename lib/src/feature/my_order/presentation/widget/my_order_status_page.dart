import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import 'package:haji_market/src/feature/basket/data/models/basket_order_model.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/pre_order_dialog.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/show_basket_bottom_sheet_widget.dart';
import 'package:haji_market/src/feature/home/presentation/widgets/product_watching_card.dart';
import 'package:haji_market/src/feature/my_order/presentation/widget/cancel_order_widget.dart';
import 'package:haji_market/src/feature/my_order/presentation/widget/show_order_cancel_widget.dart';
import 'package:haji_market/src/feature/my_order/presentation/widget/show_order_uncancel_widget.dart';
import 'package:haji_market/src/feature/product/cubit/product_cubit.dart' as product_cubit;
import 'package:haji_market/src/feature/product/cubit/product_state.dart' as product_state;
import 'package:haji_market/src/feature/product/data/model/product_model.dart';
import 'package:haji_market/src/feature/product/provider/filter_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../seller/order/bloc/order_status_seller_cubit.dart';
import '../../../basket/bloc/basket_cubit.dart';

class MyOrderStatusPage extends StatefulWidget {
  int index;
  BasketOrderModel basketOrder;

  MyOrderStatusPage({required this.index, required this.basketOrder, super.key});

  @override
  State<MyOrderStatusPage> createState() => _MyOrderStatusPageState();
}

class _MyOrderStatusPageState extends State<MyOrderStatusPage> {
  late BasketOrderModel _basketOrder;

  bool inbasket = false;
  bool hidden = false;
  String productId = '';
  String productName = '';
  int segmentValue = 0;

  int rating = 0;

  @override
  void initState() {
    if (State is! product_state.LoadedState) {
      final filters = context.read<FilterProvider>();
      BlocProvider.of<product_cubit.ProductCubit>(context).productsMbInteresting(filters);
    }

    _basketOrder = widget.basketOrder;
    // статус прогресса теперь приходит с бэка в basketStatusTimeline,
    // поэтому orderTimeline больше не нужен
    super.initState();
  }

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  Future<void> onRefresh() async {
    await BlocProvider.of<BasketCubit>(context).basketOrderShow(status: 'active');
    if (mounted) {
      setState(() {});
    }
    _refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    await BlocProvider.of<BasketCubit>(context).basketOrderShow(status: 'active');
    await Future.delayed(const Duration(milliseconds: 2000));

    _refreshController.loadComplete();
  }

  Future<void> _callSeller(String phone) async {
    final Uri uri = Uri(scheme: 'tel', path: phone);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication, // чтобы точно в звонилке
      );
    } else {
      debugPrint('Не удалось открыть звонилку');
    }
  }

  @override
  Widget build(BuildContext context) {
    /// новый список шагов таймлайна из модели
    final timelineSteps = _basketOrder.basketStatusTimeline ?? [];

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('№ ${_basketOrder.id}', style: AppTextStyles.size18Weight600),
        leading: InkWell(
          onTap: () {
            context.router.pop();
          },
          child: Image.asset(Assets.icons.defaultBackIcon.path, height: 22, width: 22, scale: 2.1),
        ),
      ),
      body: Container(
        color: AppColors.kBackgroundColor,
        child: IndexedStack(
          index: segmentValue,
          children: [
            if (_basketOrder.product?.isNotEmpty ?? false)
              ListView(
                children: [
                  const SizedBox(height: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_basketOrder.status != 'cancel')
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ********* НОВАЯ ШАПКА ОЖИДАЕМОЙ ДОСТАВКИ *********
                                if (_basketOrder.status != 'cancel')
                                  Text(
                                    'Ожидаемая доставка: ${_basketOrder.expectedDeliveryDate ?? ''}',
                                    style: AppTextStyles.size18Weight700,
                                  ),
                                const SizedBox(height: 20),
                                // ********* ДИНАМИЧЕСКИЙ ТАЙМЛАЙН ИЗ basketStatusTimeline *********
                                if (timelineSteps.isNotEmpty && _basketOrder.status != 'cancel')
                                  Column(
                                    children: [
                                      for (int i = 0; i < timelineSteps.length; i++)
                                        TimelineTile(
                                          alignment: TimelineAlign.start,
                                          isFirst: i == 0,
                                          isLast: i == timelineSteps.length - 1,
                                          indicatorStyle: (timelineSteps[i].isDone ?? false)
                                              ? IndicatorStyle(
                                                  color: AppColors.mainGreenColor,
                                                  iconStyle: IconStyle(
                                                    color: Colors.white,
                                                    iconData: Icons.check,
                                                  ),
                                                )
                                              : IndicatorStyle(
                                                  color: const Color(0xffDDDDDD),
                                                  iconStyle: i == 0
                                                      ? IconStyle(
                                                          color: Colors.white,
                                                          iconData: Icons.history_toggle_off,
                                                        )
                                                      : null,
                                                ),
                                          beforeLineStyle: const LineStyle(
                                            thickness: 1.0,
                                            color: Color(0xffDDDDDD),
                                          ),
                                          lineXY: 0.4,
                                          endChild: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                              top: 4,
                                              bottom: 4,
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  timelineSteps[i].title ?? '',
                                                  style: AppTextStyles.size16Weight500,
                                                ),
                                                if ((timelineSteps[i].date ?? '').isNotEmpty ==
                                                    true)
                                                  Text(
                                                    timelineSteps[i].date ?? '',
                                                    style: AppTextStyles.size14Weight400.copyWith(
                                                      color: Color(0xff979797),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(width: 30),
                                          if (_basketOrder.status == 'end')
                                            const SizedBox.shrink()
                                          else
                                            BlocConsumer<
                                              OrderStatusSellerCubit,
                                              OrderStatusSellerState
                                            >(
                                              listener: (context, state) {
                                                if (state is LoadedState) {
                                                  BlocProvider.of<BasketCubit>(
                                                    context,
                                                  ).basketOrderShow(status: 'end');
                                                  Navigator.pop(context);
                                                  Get.snackbar(
                                                    'Заказ',
                                                    'Вы совершили покупку',
                                                    backgroundColor: Colors.blueAccent,
                                                  );
                                                }
                                              },
                                              builder: (context, state) {
                                                return GestureDetector(
                                                  onTap: () async {
                                                    if (widget
                                                            .basketOrder
                                                            .basketStatusTimeline!
                                                            .last
                                                            .isDone ==
                                                        true) {
                                                      BlocProvider.of<OrderStatusSellerCubit>(
                                                        context,
                                                      ).basketStatus(
                                                        'end',
                                                        _basketOrder.id.toString(),
                                                        _basketOrder.product!.first.id.toString(),
                                                        'fbs',
                                                      );
                                                    } else {
                                                      AppSnackBar.show(
                                                        context,
                                                        '${_basketOrder.basketStatusTimeline![_basketOrder.currentStep! + 1].title}',
                                                        type: AppSnackType.error,
                                                      );
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 32,
                                                    width: 103,
                                                    margin: EdgeInsets.only(top: 4),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          widget
                                                                  .basketOrder
                                                                  .basketStatusTimeline!
                                                                  .last
                                                                  .isDone ==
                                                              false
                                                          ? AppColors.mainPurpleColor.withValues(
                                                              alpha: 0.5,
                                                            )
                                                          : AppColors.mainPurpleColor,
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    child: state is LoadingState
                                                        ? const CircularProgressIndicator.adaptive(
                                                            strokeWidth: 2,
                                                          )
                                                        : Text(
                                                            'Подтвердить',
                                                            textAlign: TextAlign.center,
                                                            style: AppTextStyles.size13Weight500
                                                                .copyWith(color: AppColors.kWhite),
                                                          ),
                                                  ),
                                                );
                                              },
                                            ),
                                        ],
                                      ),
                                    ],
                                  )
                                else
                                  // на всякий случай — если таймлайна нет, покажем старый вариант
                                  const Text(
                                    'Информация о статусе заказа временно недоступна',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: AppColors.kGray300,
                                    ),
                                  ),
                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        ),

                      if (_basketOrder.status == 'cancel')
                        Container(
                          height: 74,
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          padding: EdgeInsets.only(left: 16),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: AppColors.kWhite,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Отменен',
                                style: AppTextStyles.size18Weight700.copyWith(
                                  color: AppColors.mainRedColor,
                                ),
                              ),

                              Text('2 июня', style: AppTextStyles.size16Weight500),
                            ],
                          ),
                        ),

                      GestureDetector(
                        onTap: () {
                          if (_basketOrder.status != 'courier' && _basketOrder.status != 'cancel') {
                            final List<String> cancelReasons = [
                              'Передумал покупать',
                              'Сроки доставки изменились',
                              'У продавца нет товара в наличии',
                              'У продавца нет цвета/размера/модели',
                              'Продавец предлагал другую модель/\nтовар',
                              'Товар не соответствует описанию/\nфото',
                              'Другое',
                            ];

                            showOrderCancel(context, 'Причина возврата', cancelReasons, (
                              String reason,
                            ) {
                              context.read<OrderStatusSellerCubit>().cancelOrder(
                                _basketOrder.id.toString(),
                                'cancel',
                                reason,
                              );

                              BlocProvider.of<BasketCubit>(context).updateProductByIndex(
                                index: _basketOrder.id!,
                                updatedOrder: _basketOrder.copyWith(status: 'cancel'),
                              );

                              setState(() {
                                _basketOrder = _basketOrder.copyWith(status: 'cancel');
                              });

                              context.router.push(SuccessCancelRoute());
                            });
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         CancelOrderWidget(id: widget.basketOrder.id.toString()),
                            //   ),
                            // );
                          } else if (_basketOrder.status != 'courier' &&
                              _basketOrder.status != 'cancel') {
                            showOrderUncancel(context, 'Отменить заказ', [], (String reason) {});
                          } else {
                            ProductModel product = ProductModel(
                              id: _basketOrder.product?.first.id,
                              name: _basketOrder.product?.first.productName,
                              price: _basketOrder.product?.first.price,
                              count: _basketOrder.product?.first.count,
                              compound: _basketOrder.product?.first.count,
                              path: _basketOrder.product?.first.path,
                              pre_order: 1,
                              shop: Shop(
                                id: _basketOrder.shopId,
                                name: _basketOrder.product?.first.shopName,
                              ),
                            );
                            showBasketBottomSheetOptions(
                              context,
                              '${product.shop?.name}',
                              0,
                              product,
                              (int callBackCount, int callBackPrice, bool callBackOptom) {
                                if (product.product_count == 0 && product.pre_order == 1) {
                                  if (product.inBasket == false) {
                                    showCupertinoModalPopup<void>(
                                      context: context,
                                      builder: (context) => PreOrderDialog(
                                        onYesTap: () {
                                          Navigator.pop(context);
                                          if (product.inBasket == false) {
                                            BlocProvider.of<BasketCubit>(context).basketAdd(
                                              product.id.toString(),
                                              callBackCount,
                                              callBackPrice,
                                              '',
                                              '',
                                              isOptom: callBackOptom,
                                            );

                                            // BlocProvider.of<productCubit.ProductCubit>(
                                            //   context,
                                            // ).updateProductByIndex(
                                            //   index: widget.index,
                                            //   updatedProduct: widget.product.copyWith(
                                            //     basketCount: basketCount + 1,
                                            //     inBasket: true,
                                            //   ),
                                            // );
                                          }
                                        },
                                      ),
                                    );
                                  } else {
                                    context.router.pushAndPopUntil(
                                      const LauncherRoute(children: [BasketRoute()]),
                                      predicate: (route) => false,
                                    );
                                  }

                                  return;
                                }

                                // if (widget.product.inBasket == false) {
                                BlocProvider.of<BasketCubit>(context).basketAdd(
                                  product.id.toString(),
                                  callBackCount,
                                  callBackPrice,
                                  '',
                                  '',
                                  isOptom: callBackOptom,
                                );

                                // BlocProvider.of<productCubit.ProductCubit>(
                                //   context,
                                // ).updateProductByIndex(
                                //   index: widget.index,
                                //   updatedProduct: widget.product.copyWith(
                                //     basketCount: basketCount + 1,
                                //     inBasket: true,
                                //   ),
                                // );
                                // setState(() {
                                //   count += 1;
                                //   // if (count == 0) {
                                //   //   isvisible = false;
                                //   // } else {
                                //   //   isvisible = true;
                                //   // }
                                // });
                              },
                            );
                          }
                        },
                        child: Container(
                          height: 40,
                          margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.kWhite,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                // widget.basketOrder.status != 'courier' &&
                                _basketOrder.status == 'cancel'
                                    ? 'Повторить заказ'
                                    : 'Отменить заказ',
                                style: AppTextStyles.size18Weight500.copyWith(
                                  color: AppColors.mainPurpleColor,
                                ),
                              ),
                              Image.asset(
                                Assets.icons.defaultArrowForwardIcon.path,
                                color: AppColors.mainPurpleColor,
                                height: 20,
                                width: 20,
                                scale: 2.1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          final phone = _basketOrder.product?.first.shopPhone;

                          if (phone != null && phone.isNotEmpty) {
                            _callSeller(phone);
                          }
                        },
                        child: Container(
                          height: 110,
                          margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.kWhite,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              Text(
                                'Продавец',
                                style: AppTextStyles.size14Weight500.copyWith(
                                  color: const Color(0xffAEAEB2),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${_basketOrder.product!.first.shopName}',
                                style: AppTextStyles.size18Weight600,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _basketOrder.product?.first.shopPhone != null ||
                                        _basketOrder.product?.first.shopPhone != ''
                                    ? '${_basketOrder.product?.first.shopPhone}'
                                    : 'Неизвестен',
                                style: AppTextStyles.size16Weight500.copyWith(
                                  color: AppColors.mainPurpleColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 130,
                        margin: const EdgeInsets.only(left: 16, right: 16, top: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.kWhite,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            Text(
                              'Доставка',
                              style: AppTextStyles.size14Weight500.copyWith(
                                color: const Color(0xffAEAEB2),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('Пункт выдачи  СДЭК', style: AppTextStyles.size18Weight600),
                            Text(
                              _basketOrder.product?.first.address ?? 'Неизвестен',
                              style: AppTextStyles.size16Weight400,
                            ),
                            Text(
                              'пн-вс: 10:00-22:00',
                              style: AppTextStyles.size14Weight400.copyWith(
                                color: const Color(0xff8E8E93),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        height: (_basketOrder.product?.length ?? 1) * 130,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _basketOrder.product?.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 112,
                              width: 358,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              margin: const EdgeInsets.only(top: 12),
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (_basketOrder.product != null &&
                                      _basketOrder.product?[index].path != null &&
                                      (_basketOrder.product?[index].path?.isNotEmpty ?? false))
                                    buildProductImage(index)
                                  else
                                    const ErrorImageWidget(width: 88, height: 88),
                                  const SizedBox(width: 16),
                                  SizedBox(
                                    width: 238,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 238,
                                          child: Text(
                                            '${_basketOrder.product?[index].productName}',
                                            style: AppTextStyles.size14Weight500,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 238,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Сумма:',
                                                style: AppTextStyles.size14Weight400.copyWith(
                                                  color: const Color(0xff8E8E93),
                                                ),
                                              ),
                                              Text(
                                                '${_basketOrder.product?[index].price} ₽',
                                                style: AppTextStyles.size14Weight500,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 238,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Количество:',
                                                style: AppTextStyles.size14Weight400.copyWith(
                                                  color: const Color(0xff8E8E93),
                                                ),
                                              ),
                                              Text(
                                                '${_basketOrder.product?[index].count} шт',
                                                style: AppTextStyles.size14Weight500,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        if (_basketOrder.status == 'end')
                                          GestureDetector(
                                            onTap: () {
                                              productId =
                                                  (_basketOrder.product?[index].id.toString() ??
                                                  '0');
                                              context.router.push(
                                                ReviewOrderWidgetRoute(
                                                  basketOrder: _basketOrder,
                                                  index: index,
                                                ),
                                              );

                                              productName =
                                                  _basketOrder.product?[index].productName
                                                      .toString() ??
                                                  '0';
                                              hidden = !hidden;

                                              setState(() {});
                                            },
                                            child: Container(
                                              height: 38,
                                              width: 136,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: AppColors.mainPurpleColor,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                'Оставить отзыв',
                                                style: AppTextStyles.size13Weight500.copyWith(
                                                  color: AppColors.kWhite,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: 208,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: AppColors.kWhite,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Сумма заказа', style: AppTextStyles.size18Weight700),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Сумма', style: AppTextStyles.size16Weight400),
                                Text(
                                  '${_basketOrder.summa?.toInt()} ₽',
                                  style: AppTextStyles.size16Weight600,
                                ),
                              ],
                            ),
                            const SizedBox(height: 11),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Доставка', style: AppTextStyles.size16Weight400),
                                Text(
                                  '${_basketOrder.deliveryPrice ?? 0} ₽ ',
                                  style: AppTextStyles.size16Weight600,
                                ),
                              ],
                            ),
                            const SizedBox(height: 11),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Скидка', style: AppTextStyles.size16Weight400),
                                ShaderMask(
                                  shaderCallback: (bounds) => const LinearGradient(
                                    colors: [Color(0xFF7D2DFF), Color(0xFF41DDFF)],
                                  ).createShader(bounds),
                                  child: Text(
                                    '-${0} ₽',
                                    style: AppTextStyles.size16Weight600.copyWith(
                                      color: AppColors.kWhite,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 1,
                              child: LayoutBuilder(
                                builder: (BuildContext context, BoxConstraints constraints) {
                                  const dashWidth = 5.0;
                                  final dashHeight = 0.99;
                                  const dashCount = 30;
                                  return Flex(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    direction: Axis.horizontal,
                                    children: List.generate(dashCount, (_) {
                                      return SizedBox(
                                        width: dashWidth,
                                        height: dashHeight,
                                        child: const DecoratedBox(
                                          decoration: BoxDecoration(color: AppColors.kGray300),
                                        ),
                                      );
                                    }),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Итого', style: AppTextStyles.size18Weight600),
                                Text(
                                  ' ${(_basketOrder.summa?.toInt() ?? 0) + (_basketOrder.deliveryPrice ?? 0)}₽',
                                  style: AppTextStyles.size18Weight700,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
                        color: AppColors.kBackgroundColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Похожие товары', style: AppTextStyles.size18Weight700),
                            const SizedBox(height: 8),
                            BlocBuilder<product_cubit.ProductCubit, product_state.ProductState>(
                              builder: (context, state) {
                                if (state is product_state.ErrorState) {
                                  return Center(
                                    child: Text(
                                      state.message,
                                      style: const TextStyle(fontSize: 20.0, color: Colors.grey),
                                    ),
                                  );
                                }
                                if (state is product_state.LoadingState) {
                                  return const Center(
                                    child: CircularProgressIndicator(color: Colors.indigoAccent),
                                  );
                                }

                                if (state is product_state.LoadedState) {
                                  return state.productModel.isEmpty
                                      ? const Center(child: Text('Товары не найдены'))
                                      : SizedBox(
                                          width: 358,
                                          // height: 558,
                                          height: state.productModel.length >= 4 ? 558 : 291,
                                          child: GridView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: state.productModel.length >= 4
                                                  ? 2
                                                  : 1,
                                              childAspectRatio: 1.50,
                                              crossAxisSpacing: 8,
                                              mainAxisSpacing: 2,
                                            ),
                                            itemCount: state.productModel.length <= 10
                                                ? state.productModel.length
                                                : 10,
                                            itemBuilder: (BuildContext ctx, index) {
                                              return GestureDetector(
                                                onTap: () => context.router.push(
                                                  DetailCardProductRoute(
                                                    product: state.productModel[index],
                                                  ),
                                                ),
                                                child: ProductWatchingCard(
                                                  product: state.productModel[index],
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(color: Colors.indigoAccent),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 120),
                    ],
                  ),
                ],
              )
            else
              Container(
                margin: const EdgeInsets.only(bottom: 60),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/icons/no_data.png'),
                    const Text(
                      'Нет заказов',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    const Text(
                      // убрал упоминание fbs
                      'Отсутствуют заказы',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff717171),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  String? _imageUrlFor(int index) {
    final fbs = _basketOrder.product;
    if (fbs == null || index < 0 || index >= fbs.length) return null;

    final paths = fbs[index].path; // предположительно List<String>?
    if (paths == null || paths.isEmpty) return null;

    final p = paths.first.trim();
    if (p.isEmpty) return null;

    return 'https://lunamarket.ru/storage/$p';
  }

  Widget buildProductImage(int index) {
    final url = _imageUrlFor(index);

    return SizedBox(
      width: 72,
      height: 72,
      child: url != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                url,
                width: 72,
                height: 72,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const ErrorImageWidget(width: 88, height: 88),
              ),
            )
          : const ErrorImageWidget(width: 72, height: 72),
    );
  }
}

// class QRViewExample extends StatefulWidget {
//   int id;
//   int product_id;
//   String fulfillment;
//   QRViewExample(
//       {required this.id,
//       required this.product_id,
//       required this.fulfillment,
//       Key? key})
//       : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _QRViewExampleState();
// }

// class _QRViewExampleState extends State<QRViewExample> {
//   Barcode? result;
//   QRViewController? controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

//   // In order to get hot reload to work we need to pause the camera if the platform
//   // is android, or resume the camera if the platform is iOS.
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller!.pauseCamera();
//     }
//     controller!.resumeCamera();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Expanded(flex: 4, child: _buildQrView(context)),
//           Expanded(
//             flex: 1,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget>[
//                 if (result != null)
//                   Container(
//                       margin: const EdgeInsets.all(8),
//                       child: DefaultButton(
//                         width: 350,
//                         color: Colors.white,
//                         backgroundColor: AppColors.kPrimaryColor,
//                         text: '${result?.code ?? 'Код не найден'}',
//                         press: () async {
//                           if (result?.code == widget.id.toString()) {
//                             Get.snackbar('Заказ', 'возврат оформлен',
//                                 backgroundColor: Colors.greenAccent);

//                             BlocProvider.of<OrderStatusAdminCubit>(context)
//                                 .basketStatus(
//                                     'cancel',
//                                     widget.id.toString(),
//                                     widget.product_id.toString(),
//                                     widget.fulfillment);
//                           } else {
//                             Get.snackbar('Заказ', 'код товара не совпал',
//                                 backgroundColor: Colors.greenAccent);
//                           }
//                         },
//                       ))
//                 else
//                   SizedBox(
//                       height: 50,
//                       width: 50,
//                       child: const CircularProgressIndicator()),
//                 //   Row(
//                 //     mainAxisAlignment: MainAxisAlignment.center,
//                 //     crossAxisAlignment: CrossAxisAlignment.center,
//                 //     children: <Widget>[
//                 //       Container(
//                 //         margin: const EdgeInsets.all(8),
//                 //         child: ElevatedButton(
//                 //             onPressed: () async {
//                 //               await controller?.toggleFlash();
//                 //               setState(() {});
//                 //             },
//                 //             child: FutureBuilder(
//                 //               future: controller?.getFlashStatus(),
//                 //               builder: (context, snapshot) {
//                 //                 return Text('Свет: ${snapshot.data != false ? 'включен' : 'выключен'}');
//                 //               },
//                 //             )),
//                 //       ),
//                 //       Container(
//                 //         margin: const EdgeInsets.all(8),
//                 //         child: ElevatedButton(
//                 //             onPressed: () async {
//                 //               await controller?.flipCamera();
//                 //               setState(() {});
//                 //             },
//                 //             child: FutureBuilder(
//                 //               future: controller?.getCameraInfo(),
//                 //               builder: (context, snapshot) {
//                 //                 if (snapshot.data != null) {
//                 //                   return Text(
//                 //                       'Камера: ${describeEnum(snapshot.data!) != 'back' ? 'передняя' : 'задняя'}');
//                 //                 } else {
//                 //                   return const Text('loading');
//                 //                 }
//                 //               },
//                 //             )),
//                 //       )
//                 //     ],
//                 //   ),
//                 //   Row(
//                 //     mainAxisAlignment: MainAxisAlignment.center,
//                 //     crossAxisAlignment: CrossAxisAlignment.center,
//                 //     children: <Widget>[
//                 //       Container(
//                 //         margin: const EdgeInsets.all(8),
//                 //         child: ElevatedButton(
//                 //           onPressed: () async {
//                 //             await controller?.pauseCamera();
//                 //           },
//                 //           child: const Text('Пауза', style: TextStyle(fontSize: 20)),
//                 //         ),
//                 //       ),
//                 //       Container(
//                 //         margin: const EdgeInsets.all(8),
//                 //         child: ElevatedButton(
//                 //           onPressed: () async {
//                 //             await controller?.resumeCamera();
//                 //           },
//                 //           child: const Text('Продолжать', style: TextStyle(fontSize: 20)),
//                 //         ),
//                 //       )
//                 //     ],
//                 //   ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   // Widget _buildQrView(BuildContext context) {
//   //   // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
//   //   var scanArea = (MediaQuery.of(context).size.width < 400 ||
//   //           MediaQuery.of(context).size.height < 400)
//   //       ? 150.0
//   //       : 300.0;
//   //   // To ensure the Scanner view is properly sizes after rotation
//   //   // we need to listen for Flutter SizeChanged notification and update controller
//   //   return QRView(
//   //     key: qrKey,
//   //     onQRViewCreated: _onQRViewCreated,
//   //     overlay: QrScannerOverlayShape(
//   //         borderColor: Colors.red,
//   //         borderRadius: 10,
//   //         borderLength: 30,
//   //         borderWidth: 10,
//   //         cutOutSize: scanArea),
//   //     onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
//   //   );
//   // }

//   // void _onQRViewCreated(QRViewController controller) {
//   //   setState(() {
//   //     this.controller = controller;
//   //   });
//   //   controller.scannedDataStream.listen((scanData) {
//   //     setState(() {
//   //       if (result?.code != null) {
//   //         if (result?.code == scanData.code) {
//   //           result = scanData;
//   //         }
//   //       } else {
//   //         result = scanData;
//   //       }
//   //     });
//   //   });
//   // }

//   // void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//   //   log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
//   //   if (!p) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text('no Permission')),
//   //     );
//   //   }
//   // }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
