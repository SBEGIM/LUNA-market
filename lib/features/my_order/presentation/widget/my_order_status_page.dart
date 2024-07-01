import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/widgets/custom_switch_button.dart';
import 'package:haji_market/features/app/widgets/error_image_widget.dart';
import 'package:haji_market/features/auth/presentation/widgets/default_button.dart';
import 'package:haji_market/features/basket/data/models/basket_order_model.dart';
import 'package:haji_market/features/my_order/presentation/widget/cancel_order_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../../../admin/my_orders_admin/data/bloc/order_status_admin_cubit.dart';
import '../../../chat/presentation/message.dart';
import '../../../drawer/data/bloc/basket_cubit.dart';
import '../../../drawer/data/bloc/review_cubit.dart';

class MyOrderStatusPage extends StatefulWidget {
  final BasketOrderModel basketOrder;

  const MyOrderStatusPage({required this.basketOrder, Key? key})
      : super(key: key);

  @override
  State<MyOrderStatusPage> createState() => _MyOrderStatusPageState();
}

class _MyOrderStatusPageState extends State<MyOrderStatusPage> {
  bool inbasket = false;
  bool hidden = false;
  String productId = '';
  String productName = '';
  int segmentValue = 0;
  int statusProggress = 1;

  int rating = 0;

  final TextEditingController _commentController = TextEditingController();

  orderTimeline(String status) {
    switch (status) {
      case 'order':
        {
          statusProggress = 1;
        }
        break;

      case 'accepted':
        {
          statusProggress = 2;
        }
        break;

      case 'courier':
        {
          statusProggress = 3;
        }
        break;
      case 'error':
        {
          statusProggress = 1;
        }
        break;
      case 'cancel':
        {
          statusProggress = 1;
        }
        break;
      case 'rejected':
        {
          statusProggress = 2;
        }
        break;
      case 'end':
        {
          statusProggress = 4;
        }
        break;
      case 'in_process':
        {
          statusProggress = 1;
        }
        break;
      case 'success':
        {
          statusProggress = 2;
        }
        break;
      default:
        {
          statusProggress = 1;
        }
        break;
    }

    print('this nuber ${statusProggress}');

    setState(() {});
  }

  @override
  void initState() {
    orderTimeline(widget.basketOrder.statusFBS ?? 'in_process');
    super.initState();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Future<void> onRefresh() async {
    await BlocProvider.of<BasketCubit>(context).basketOrderShow();
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
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            '№ ${widget.basketOrder.id}',
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
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
                  color: AppColors.kBackgroundColor,
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
                      // 1: Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   alignment: Alignment.center,
                      //   height: 39,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(4),
                      //   ),
                      //   child: Text(
                      //     'realFBS',
                      //     style: TextStyle(
                      //       fontSize: 14,
                      //       color: segmentValue == 1 ? Colors.black : const Color(0xff9B9B9B),
                      //     ),
                      //   ),
                      // ),
                      1: Container(
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
                        print('${widget.basketOrder.statusFBS}');

                        if (value == 0) {
                          await BlocProvider.of<BasketCubit>(context)
                              .basketOrderShow();
                          orderTimeline(
                              widget.basketOrder.statusFBS ?? 'in_process');
                        } else {
                          await BlocProvider.of<BasketCubit>(context)
                              .basketOrderShow();
                          orderTimeline(
                              widget.basketOrder.statusRealFBS ?? 'in_process');
                        }

                        // BlocProvider.of<BasketAdminCubit>(context).basketSwitchState(value);
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
            children: [
              if (widget.basketOrder.productFBS?.isNotEmpty ?? false)
                ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            '${widget.basketOrder.date}',
                            style: const TextStyle(
                                color: AppColors.kGray300,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Оплачен',
                                  style: TextStyle(
                                    color: AppColors.kGray900,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TimelineTile(
                                  isFirst: true,
                                  indicatorStyle: statusProggress >= 1
                                      ? IndicatorStyle(
                                          color: AppColors.kPrimaryColor,
                                          iconStyle: IconStyle(
                                            color: Colors.white,
                                            iconData: Icons.check,
                                          ),
                                        )
                                      : IndicatorStyle(
                                          color: Colors.grey,
                                          iconStyle: IconStyle(
                                            color: Colors.white,
                                            iconData: Icons.history_toggle_off,
                                          ),
                                        ),
                                  beforeLineStyle: const LineStyle(
                                    thickness: 1.4,
                                  ),
                                  lineXY: 0.4,
                                  endChild: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 10, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Заказ оплачен',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '${widget.basketOrder.date}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: AppColors.kGray300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                TimelineTile(
                                  isFirst: false,
                                  indicatorStyle: statusProggress >= 2
                                      ? IndicatorStyle(
                                          color: AppColors.kPrimaryColor,
                                          iconStyle: IconStyle(
                                            color: Colors.white,
                                            iconData: Icons.check,
                                          ),
                                        )
                                      : IndicatorStyle(
                                          color: Colors.grey,
                                          iconStyle: IconStyle(
                                            color: Colors.white,
                                            iconData: Icons.history_toggle_off,
                                          ),
                                        ),
                                  beforeLineStyle: const LineStyle(
                                    thickness: 1.4,
                                  ),
                                  lineXY: 0.4,
                                  endChild: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 10, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.basketOrder.statusFBS ==
                                                      'cancel' ||
                                                  widget.basketOrder
                                                          .statusFBS ==
                                                      'rejected'
                                              ? 'Отменен или Отклонен'
                                              : 'Принять',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '${widget.basketOrder.statusFBS == 'cancel' ? widget.basketOrder.updated_at : widget.basketOrder.returnDate}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: AppColors.kGray300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                TimelineTile(
                                  isFirst: false,
                                  indicatorStyle: statusProggress >= 3
                                      ? IndicatorStyle(
                                          color: AppColors.kPrimaryColor,
                                          iconStyle: IconStyle(
                                            color: Colors.white,
                                            iconData: Icons.check,
                                          ),
                                        )
                                      : IndicatorStyle(
                                          color: Colors.grey,
                                          iconStyle: IconStyle(
                                            color: Colors.white,
                                            iconData: Icons.history_toggle_off,
                                          ),
                                        ),
                                  beforeLineStyle: const LineStyle(
                                    thickness: 1.4,
                                  ),
                                  lineXY: 0.4,
                                  endChild: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 10, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.basketOrder.statusFBS ==
                                                  'cancel'
                                              ? 'Отменен'
                                              : 'Доставка',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '${widget.basketOrder.statusFBS == 'cancel' ? widget.basketOrder.updated_at : widget.basketOrder.returnDate}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: AppColors.kGray300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                TimelineTile(
                                  isLast: true,
                                  indicatorStyle: statusProggress >= 4
                                      ? IndicatorStyle(
                                          color: AppColors.kPrimaryColor,
                                          iconStyle: IconStyle(
                                            color: Colors.white,
                                            iconData: Icons.check,
                                          ),
                                        )
                                      : IndicatorStyle(
                                          color: Colors.grey,
                                          iconStyle: IconStyle(
                                            color: Colors.white,
                                            iconData: Icons.history_toggle_off,
                                          ),
                                        ),
                                  beforeLineStyle: const LineStyle(
                                    thickness: 1.4,
                                  ),
                                  lineXY: 0.4,
                                  endChild: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 10, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Выдан',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          widget.basketOrder.statusFBS == 'end'
                                              ? 'Вы получили товар'
                                              : 'Товар пока не получен',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: AppColors.kGray300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // const Divider(
                                //   height: 1,
                                //   color: AppColors.kGray500,
                                // ),
                                const SizedBox(height: 10),
                                if (widget.basketOrder.statusFBS == 'cancel')
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 38,
                                          width: 136,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: AppColors.kPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: const Text(
                                            'Заказ отменен',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                else
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (widget.basketOrder.statusFBS ==
                                            'end')
                                          const SizedBox()
                                        else
                                          BlocConsumer<OrderStatusAdminCubit,
                                                  OrderStatusAdminState>(
                                              listener: (context, state) {
                                            if (state is LoadedState) {
                                              BlocProvider.of<BasketCubit>(
                                                      context)
                                                  .basketOrderShow();
                                              Navigator.pop(context);
                                              Get.snackbar('Заказ',
                                                  'Вы совершили покупку',
                                                  backgroundColor:
                                                      Colors.blueAccent);
                                            }
                                          }, builder: (context, state) {
                                            return Expanded(
                                              child: GestureDetector(
                                                onTap: () async {
                                                  if (widget.basketOrder
                                                          .statusFBS !=
                                                      'courier') {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CancelOrderWidget(
                                                                  id: widget
                                                                      .basketOrder
                                                                      .id
                                                                      .toString())),
                                                    );
                                                  } else {
                                                    BlocProvider.of<
                                                                OrderStatusAdminCubit>(
                                                            context)
                                                        .basketStatus(
                                                            'end',
                                                            widget
                                                                .basketOrder.id
                                                                .toString(),
                                                            widget
                                                                .basketOrder
                                                                .product!
                                                                .first
                                                                .id
                                                                .toString(),
                                                            'fbs');
                                                    // Get.back();
                                                  }
                                                },
                                                child: Container(
                                                  height: 38,
                                                  width: 136,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColors.kPrimaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: state is LoadingState
                                                      ? const CircularProgressIndicator
                                                          .adaptive(
                                                          strokeWidth: 2,
                                                        )
                                                      : Text(
                                                          widget.basketOrder
                                                                      .statusFBS ==
                                                                  'courier'
                                                              ? 'Товар получил \nПретензии не имею'
                                                              : 'Отменить',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                ),
                                              ),
                                            );
                                          }),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              // setState(() {});

                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    QRViewExample(
                                                        id: widget
                                                            .basketOrder.id!,
                                                        product_id: widget
                                                            .basketOrder
                                                            .product!
                                                            .first
                                                            .id!,
                                                        fulfillment: 'fbs'),
                                              ));
                                            },
                                            child: Container(
                                              height: 38,
                                              width: 136,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    29, 196, 207, 0.4),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: const Text(
                                                'Возврат',
                                                style: TextStyle(
                                                    color:
                                                        AppColors.kPrimaryColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 10),
                          child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Продовец',
                                    style: TextStyle(
                                        color: AppColors.kPrimaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 54,
                                        width: 54,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(34),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "http://185.116.193.73/storage/${widget.basketOrder.product!.first.shopImage}"),
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      const SizedBox(width: 13),
                                      if (widget.basketOrder.product != null &&
                                          widget
                                              .basketOrder.product!.isNotEmpty)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${widget.basketOrder.product!.first.shopName}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              widget
                                                              .basketOrder
                                                              .productFBS
                                                              ?.first
                                                              .shopPhone !=
                                                          null ||
                                                      widget
                                                              .basketOrder
                                                              .productFBS
                                                              ?.first
                                                              .shopPhone !=
                                                          ''
                                                  ? '${widget.basketOrder.productFBS?.first.shopPhone}'
                                                  : 'Неизвестен',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Get.to(() => const ChatPage());

                                          Get.to(MessagePage(
                                            userId: widget.basketOrder.shopId,
                                            name: widget.basketOrder.productFBS
                                                ?.first.shopName,
                                            avatar: widget.basketOrder
                                                .productFBS?.first.shopImage,
                                            chatId: widget.basketOrder.chatId,
                                          ));
                                        },
                                        child: Container(
                                          height: 30,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          // width: 108,
                                          decoration: BoxDecoration(
                                              color: AppColors.kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Написать',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 10),
                          child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Адрес доставки',
                                    style: TextStyle(
                                        color: AppColors.kPrimaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/location.svg',
                                      ),
                                      const SizedBox(width: 13),
                                      Expanded(
                                        child: Text(
                                          widget.basketOrder.productFBS?.first
                                                  .address ??
                                              'Неизвестен',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.all(16),
                          color: Colors.white,
                          height: (widget.basketOrder.productFBS?.length ?? 1) *
                              180,
                          // width: 200,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.basketOrder.productFBS?.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Container(
                                  height: 170,
                                  // width: 100,
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 12),
                                  color: Colors.white,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (widget.basketOrder.productFBS !=
                                              null &&
                                          widget.basketOrder.productFBS?[index]
                                                  .path !=
                                              null &&
                                          (widget.basketOrder.productFBS?[index]
                                                  .path?.isNotEmpty ??
                                              false))
                                        Image.network(
                                          (widget.basketOrder.productFBS?[index]
                                                      .path!.isNotEmpty ??
                                                  false)
                                              ? "http://185.116.193.73/storage/${widget.basketOrder.productFBS?[index].path?.first}"
                                              : '',
                                          width: 120,
                                          height: 120,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const ErrorImageWidget(
                                            height: 120,
                                            width: 120,
                                          ),
                                        )
                                      else
                                        const ErrorImageWidget(
                                          width: 120,
                                          height: 120,
                                        ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 185,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${widget.basketOrder.productFBS?[index].price} ₽',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  '${widget.basketOrder.productFBS?[index].count} шт',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          SizedBox(
                                            height: 50,
                                            width: 185,
                                            child: Text(
                                              '${widget.basketOrder.productFBS?[index].productName}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(height: 18),
                                          GestureDetector(
                                            onTap: () async {
                                              if (inbasket != true) {
                                                await BlocProvider.of<
                                                        BasketCubit>(context)
                                                    .basketAdd(
                                                        widget
                                                            .basketOrder
                                                            .productFBS?[index]
                                                            .id,
                                                        '1',
                                                        0,
                                                        '',
                                                        '');
                                                Get.snackbar('Успешно',
                                                    'Товар добавлен в корзину',
                                                    backgroundColor:
                                                        Colors.blueAccent);

                                                inbasket = true;
                                                setState(() {});
                                              }
                                            },
                                            child: Container(
                                              height: 38,
                                              width: 136,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: AppColors.kPrimaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                inbasket != true
                                                    ? 'В корзину'
                                                    : 'Добавлен в корзину',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          if (widget.basketOrder.statusFBS ==
                                              'end')
                                            GestureDetector(
                                              onTap: () {
                                                productId = (widget.basketOrder
                                                        .productFBS?[index].id
                                                        .toString() ??
                                                    '0');

                                                productName = widget
                                                        .basketOrder
                                                        .productFBS?[index]
                                                        .productName
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
                                                  color: const Color.fromRGBO(
                                                      29, 196, 207, 0.4),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: const Text(
                                                  'Оставить отзыв',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .kPrimaryColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            )
                                        ],
                                      )
                                    ],
                                  ));
                            },
                          ),
                        ),
                        Visibility(
                          visible: hidden,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            color: Colors.white,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Оставьте отзыв',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.start,
                                      ),
                                      RatingBar.builder(
                                        initialRating: 0,
                                        minRating: 1,
                                        itemSize: 15,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (value) {
                                          rating = value.toInt();
                                        },
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _commentController,
                                    maxLines: 5,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        hintText:
                                            'Напишите отзывь для $productName',
                                        border: InputBorder.none),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await BlocProvider.of<ReviewCubit>(
                                              context)
                                          .reviewStore(_commentController.text,
                                              rating.toString(), productId);
                                      _commentController.clear();

                                      hidden = !hidden;

                                      setState(() {});

                                      Get.snackbar('Успешно', 'отзыв добавлен',
                                          backgroundColor: Colors.blueAccent);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 39,
                                      width: 209,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(width: 0.2),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(
                                              0.2,
                                              0.2,
                                            ), //Offset
                                            blurRadius: 0.1,
                                            spreadRadius: 0.1,
                                          ), //BoxShadow
                                          BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 0.0,
                                            spreadRadius: 0.0,
                                          ), //BoxShadow
                                        ],
                                      ),
                                      child: const Text(
                                        'Оставить свой отзыв',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 55,
                                child: ListTile(
                                  title: const Text(
                                    'Товар',
                                    style: TextStyle(
                                        color: AppColors.kGray900,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  subtitle:
                                      (widget.basketOrder.productFBS ?? [])
                                              .isNotEmpty
                                          ? Text(
                                              '${widget.basketOrder.productFBS!.first.productName}',
                                              style: const TextStyle(
                                                  color: AppColors.kGray300,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          : null,
                                  trailing: Text(
                                    '${widget.basketOrder.priceFBS ?? 0} ₽ ',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              const Divider(
                                color: AppColors.kGray400,
                              ),
                              SizedBox(
                                height: 35,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: const Text('Доставка'),
                                    ),
                                    Container(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: Text(
                                          '${widget.basketOrder.deliveryPrice ?? 0} ₽ ',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ))
                                  ],
                                ),
                              ),
                              const Divider(
                                color: AppColors.kGray400,
                              ),
                              SizedBox(
                                height: 35,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: const Text(
                                        'К оплате',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: Text(
                                          '${(widget.basketOrder.priceFBS?.toInt() ?? 0) + (widget.basketOrder.deliveryPrice ?? 0)} ₽ ',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ))
                                  ],
                                ),
                              ),
                              // const Divider(
                              //   color: AppColors.kGray400,
                              // ),
                              // GestureDetector(
                              //   onTap: () {
                              //     Get.to(DeliveryNote(basketOrder: widget.basketOrder));
                              //   },
                              //   child: SizedBox(
                              //     height: 35,
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         Container(
                              //           alignment: Alignment.center,
                              //           padding: const EdgeInsets.only(left: 16),
                              //           child: const Text(
                              //             'Скачать накладную',
                              //             style: TextStyle(
                              //               fontSize: 16,
                              //               fontWeight: FontWeight.w500,
                              //               color: AppColors.kPrimaryColor,
                              //             ),
                              //           ),
                              //         ),
                              //         const SizedBox(
                              //           width: 5,
                              //         ),
                              //         const Icon(
                              //           Icons.download,
                              //           color: AppColors.kPrimaryColor,
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              const SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )
              //  AllMyOrdersRealFBSPage(fulfillment: 'realFBS'),
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        'Отсутствует заказы fbs',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff717171)),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              if (widget.basketOrder.productRealFBS?.isNotEmpty ?? false)
                ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            '${widget.basketOrder.date}',
                            style: const TextStyle(
                                color: AppColors.kGray300,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Оплачен',
                                  style: TextStyle(
                                    color: AppColors.kGray900,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TimelineTile(
                                  isFirst: true,
                                  indicatorStyle: statusProggress >= 1
                                      ? IndicatorStyle(
                                          color: AppColors.kPrimaryColor,
                                          iconStyle: IconStyle(
                                            color: Colors.white,
                                            iconData: Icons.check,
                                          ),
                                        )
                                      : IndicatorStyle(
                                          color: Colors.grey,
                                          iconStyle: IconStyle(
                                            color: Colors.white,
                                            iconData: Icons.history_toggle_off,
                                          ),
                                        ),
                                  beforeLineStyle: const LineStyle(
                                    thickness: 1.4,
                                  ),
                                  lineXY: 0.4,
                                  endChild: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 10, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Заказ оплачен',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '${widget.basketOrder.date}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: AppColors.kGray300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                TimelineTile(
                                  isFirst: false,
                                  indicatorStyle: statusProggress >= 2
                                      ? IndicatorStyle(
                                          color: AppColors.kPrimaryColor,
                                          iconStyle: IconStyle(
                                            color: Colors.white,
                                            iconData: Icons.check,
                                          ),
                                        )
                                      : IndicatorStyle(
                                          color: Colors.grey,
                                          iconStyle: IconStyle(
                                            color: Colors.white,
                                            iconData: (widget.basketOrder
                                                            .statusRealFBS ==
                                                        'end' ||
                                                    widget.basketOrder
                                                            .statusRealFBS ==
                                                        'accepted')
                                                ? Icons.check
                                                : Icons.history_toggle_off,
                                          ),
                                        ),
                                  beforeLineStyle: const LineStyle(
                                    thickness: 1.4,
                                  ),
                                  lineXY: 0.4,
                                  endChild: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 10, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.basketOrder.statusRealFBS ==
                                                      'cancel' ||
                                                  widget.basketOrder
                                                          .statusRealFBS ==
                                                      'rejected'
                                              ? 'Отменен'
                                              : 'Принять',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '${widget.basketOrder.statusRealFBS == 'cancel' ? widget.basketOrder.updated_at : widget.basketOrder.returnDate}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: AppColors.kGray300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                TimelineTile(
                                  isFirst: false,
                                  indicatorStyle: statusProggress >= 3
                                      ? IndicatorStyle(
                                          color: AppColors.kPrimaryColor,
                                          iconStyle: IconStyle(
                                            color: Colors.white,
                                            iconData: Icons.check,
                                          ),
                                        )
                                      : IndicatorStyle(
                                          color: Colors.grey,
                                          iconStyle: IconStyle(
                                            color: Colors.white,
                                            iconData: (widget.basketOrder
                                                            .statusRealFBS ==
                                                        'end' ||
                                                    widget.basketOrder
                                                            .statusRealFBS ==
                                                        'courier')
                                                ? Icons.check
                                                : Icons.history_toggle_off,
                                          ),
                                        ),
                                  beforeLineStyle: const LineStyle(
                                    thickness: 1.4,
                                  ),
                                  lineXY: 0.4,
                                  endChild: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 10, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.basketOrder.statusRealFBS ==
                                                  'cancel'
                                              ? 'Отменен'
                                              : 'Доставка',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '${widget.basketOrder.statusRealFBS == 'cancel' ? widget.basketOrder.updated_at : widget.basketOrder.returnDate}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: AppColors.kGray300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                TimelineTile(
                                  isLast: true,
                                  indicatorStyle: statusProggress >= 4
                                      ? IndicatorStyle(
                                          color: AppColors.kPrimaryColor,
                                          iconStyle: IconStyle(
                                            color: Colors.white,
                                            iconData: Icons.check,
                                          ),
                                        )
                                      : IndicatorStyle(
                                          color: Colors.grey,
                                          iconStyle: IconStyle(
                                            color: Colors.white,
                                            iconData: widget.basketOrder
                                                        .statusRealFBS ==
                                                    'end'
                                                ? Icons.check
                                                : Icons.history_toggle_off,
                                          ),
                                        ),
                                  beforeLineStyle: const LineStyle(
                                    thickness: 1.4,
                                  ),
                                  lineXY: 0.4,
                                  endChild: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 10, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Выдан',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          widget.basketOrder.statusRealFBS ==
                                                  'end'
                                              ? 'Вы получили товар'
                                              : 'Товар пока не получен',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: AppColors.kGray300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // const Divider(
                                //   height: 1,
                                //   color: AppColors.kGray500,
                                // ),
                                const SizedBox(height: 10),
                                if (widget.basketOrder.statusRealFBS ==
                                    'cancel')
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 38,
                                          width: 136,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: AppColors.kPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: const Text(
                                            'Заказ отменен',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                else
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (widget.basketOrder.statusRealFBS ==
                                            'end')
                                          const SizedBox()
                                        else
                                          BlocConsumer<OrderStatusAdminCubit,
                                                  OrderStatusAdminState>(
                                              listener: (context, state) {
                                            if (state is LoadedState) {
                                              BlocProvider.of<BasketCubit>(
                                                      context)
                                                  .basketOrderShow();
                                              Navigator.pop(context);
                                              Get.snackbar('Заказ',
                                                  'Вы совершили покупку',
                                                  backgroundColor:
                                                      Colors.blueAccent);
                                            }
                                          }, builder: (context, state) {
                                            return Expanded(
                                              child: GestureDetector(
                                                onTap: () async {
                                                  if (widget.basketOrder
                                                          .statusRealFBS !=
                                                      'courier') {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CancelOrderWidget(
                                                                  id: widget
                                                                      .basketOrder
                                                                      .id
                                                                      .toString())),
                                                    );
                                                  } else {
                                                    BlocProvider.of<
                                                                OrderStatusAdminCubit>(
                                                            context)
                                                        .basketStatus(
                                                            'end',
                                                            widget
                                                                .basketOrder.id
                                                                .toString(),
                                                            widget
                                                                .basketOrder
                                                                .product!
                                                                .first
                                                                .id
                                                                .toString(),
                                                            'fbs');
                                                    // Get.back();
                                                  }
                                                },
                                                child: Container(
                                                  height: 38,
                                                  width: 136,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppColors.kPrimaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: state is LoadingState
                                                      ? const CircularProgressIndicator
                                                          .adaptive(
                                                          strokeWidth: 2,
                                                        )
                                                      : Text(
                                                          widget.basketOrder
                                                                      .statusRealFBS ==
                                                                  'courier'
                                                              ? 'Товар получил \nПретензии не имею'
                                                              : 'Отменить',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                ),
                                              ),
                                            );
                                          }),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              // setState(() {});

                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    QRViewExample(
                                                        id: widget
                                                            .basketOrder.id!,
                                                        product_id: widget
                                                            .basketOrder
                                                            .product!
                                                            .first
                                                            .id!,
                                                        fulfillment: 'realFBS'),
                                              ));
                                            },
                                            child: Container(
                                              height: 38,
                                              width: 136,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: const Color.fromRGBO(
                                                    29, 196, 207, 0.4),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: const Text(
                                                'Возврат',
                                                style: TextStyle(
                                                    color:
                                                        AppColors.kPrimaryColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 10),
                          child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Продовец',
                                    style: TextStyle(
                                        color: AppColors.kPrimaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 54,
                                        width: 54,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(34),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "http://185.116.193.73/storage/${widget.basketOrder.product!.first.shopImage}"),
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      const SizedBox(width: 13),
                                      if (widget.basketOrder.product != null &&
                                          widget
                                              .basketOrder.product!.isNotEmpty)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${widget.basketOrder.product!.first.shopName}',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              widget.basketOrder.product?.first
                                                          .shopPhone !=
                                                      ''
                                                  ? '${widget.basketOrder.product?.first.shopPhone}'
                                                  : 'Неизвестен',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          // Get.to(() => const ChatPage());

                                          Get.to(MessagePage(
                                            userId: widget.basketOrder.shopId,
                                            name: widget.basketOrder.productFBS
                                                ?.first.shopName,
                                            avatar: widget.basketOrder
                                                .productFBS?.first.shopImage,
                                            chatId: widget.basketOrder.chatId,
                                          ));
                                        },
                                        child: Container(
                                          height: 30,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          // width: 108,
                                          decoration: BoxDecoration(
                                              color: AppColors.kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Написать',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 10),
                          child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Адрес доставки',
                                    style: TextStyle(
                                        color: AppColors.kPrimaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/location.svg',
                                      ),
                                      const SizedBox(width: 13),
                                      Expanded(
                                        child: Text(
                                          widget.basketOrder.productRealFBS
                                                  ?.first.address ??
                                              'Неизвестен',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )),
                        ),
                        Container(
                          margin: const EdgeInsets.all(16),
                          color: Colors.white,
                          height:
                              (widget.basketOrder.productRealFBS?.length ?? 1) *
                                  180,
                          // width: 200,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                widget.basketOrder.productRealFBS?.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Container(
                                  height: 170,
                                  // width: 100,
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 12),
                                  color: Colors.white,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (widget.basketOrder.productRealFBS !=
                                              null &&
                                          widget
                                                  .basketOrder
                                                  .productRealFBS?[index]
                                                  .path !=
                                              null &&
                                          (widget
                                                  .basketOrder
                                                  .productRealFBS?[index]
                                                  .path
                                                  ?.isNotEmpty ??
                                              false))
                                        Image.network(
                                          (widget
                                                      .basketOrder
                                                      .productRealFBS?[index]
                                                      .path!
                                                      .isNotEmpty ??
                                                  false)
                                              ? "http://185.116.193.73/storage/${widget.basketOrder.productRealFBS?[index].path?.first}"
                                              : '',
                                          width: 120,
                                          height: 120,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const ErrorImageWidget(
                                            height: 120,
                                            width: 120,
                                          ),
                                        )
                                      else
                                        const ErrorImageWidget(
                                          width: 120,
                                          height: 120,
                                        ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 185,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${widget.basketOrder.productRealFBS?[index].price} ₽',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  '${widget.basketOrder.productRealFBS?[index].count} шт',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          SizedBox(
                                            height: 50,
                                            width: 185,
                                            child: Text(
                                              '${widget.basketOrder.productRealFBS?[index].productName}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          const SizedBox(height: 18),
                                          GestureDetector(
                                            onTap: () async {
                                              if (inbasket != true) {
                                                await BlocProvider.of<
                                                        BasketCubit>(context)
                                                    .basketAdd(
                                                        widget
                                                            .basketOrder
                                                            .productRealFBS?[
                                                                index]
                                                            .id,
                                                        '1',
                                                        0,
                                                        '',
                                                        '');
                                                Get.snackbar('Успешно',
                                                    'Товар добавлен в корзину',
                                                    backgroundColor:
                                                        Colors.blueAccent);

                                                inbasket = true;
                                                setState(() {});
                                              }
                                            },
                                            child: Container(
                                              height: 38,
                                              width: 136,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: AppColors.kPrimaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                inbasket != true
                                                    ? 'В корзину'
                                                    : 'Добавлен в корзину',
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          if (widget.basketOrder.status ==
                                              'end')
                                            GestureDetector(
                                              onTap: () {
                                                productId = (widget
                                                        .basketOrder
                                                        .productRealFBS?[index]
                                                        .id
                                                        .toString() ??
                                                    '0');

                                                productName = widget
                                                        .basketOrder
                                                        .productRealFBS?[index]
                                                        .productName
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
                                                  color: const Color.fromRGBO(
                                                      29, 196, 207, 0.4),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: const Text(
                                                  'Оставить отзыв',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .kPrimaryColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            )
                                        ],
                                      )
                                    ],
                                  ));
                            },
                          ),
                        ),
                        Visibility(
                          visible: hidden,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            color: Colors.white,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Оставьте отзыв',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.start,
                                      ),
                                      RatingBar.builder(
                                        initialRating: 0,
                                        minRating: 1,
                                        itemSize: 15,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (value) {
                                          rating = value.toInt();
                                        },
                                      ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _commentController,
                                    maxLines: 5,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        hintText:
                                            'Напишите отзывь для $productName',
                                        border: InputBorder.none),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await BlocProvider.of<ReviewCubit>(
                                              context)
                                          .reviewStore(_commentController.text,
                                              rating.toString(), productId);
                                      _commentController.clear();

                                      hidden = !hidden;

                                      setState(() {});

                                      Get.snackbar('Успешно', 'отзыв добавлен',
                                          backgroundColor: Colors.blueAccent);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 39,
                                      width: 209,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(width: 0.2),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(
                                              0.2,
                                              0.2,
                                            ), //Offset
                                            blurRadius: 0.1,
                                            spreadRadius: 0.1,
                                          ), //BoxShadow
                                          BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 0.0,
                                            spreadRadius: 0.0,
                                          ), //BoxShadow
                                        ],
                                      ),
                                      child: const Text(
                                        'Оставить свой отзыв',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 55,
                                child: ListTile(
                                  title: const Text(
                                    'Товар',
                                    style: TextStyle(
                                        color: AppColors.kGray900,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  subtitle:
                                      (widget.basketOrder.productRealFBS ?? [])
                                              .isNotEmpty
                                          ? Text(
                                              '${widget.basketOrder.productRealFBS!.first.productName}',
                                              style: const TextStyle(
                                                  color: AppColors.kGray300,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          : null,
                                  trailing: Text(
                                    '${widget.basketOrder.priceRealFBS ?? 0} ₽ ',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              const Divider(
                                color: AppColors.kGray400,
                              ),
                              SizedBox(
                                height: 35,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: const Text('Доставка'),
                                    ),
                                    Container(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: Text(
                                          '0 ₽ ',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ))
                                  ],
                                ),
                              ),
                              const Divider(
                                color: AppColors.kGray400,
                              ),
                              SizedBox(
                                height: 35,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: const Text(
                                        'К оплате',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: Text(
                                          '${(widget.basketOrder.priceRealFBS?.toInt() ?? 0) + (widget.basketOrder.deliveryPrice ?? 0)} ₽ ',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ))
                                  ],
                                ),
                              ),
                              // const Divider(
                              //   color: AppColors.kGray400,
                              // ),
                              // GestureDetector(
                              //   onTap: () {
                              //     Get.to(DeliveryNote(basketOrder: widget.basketOrder));
                              //   },
                              //   child: SizedBox(
                              //     height: 35,
                              //     child: Row(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         Container(
                              //           alignment: Alignment.center,
                              //           padding: const EdgeInsets.only(left: 16),
                              //           child: const Text(
                              //             'Скачать накладную',
                              //             style: TextStyle(
                              //               fontSize: 16,
                              //               fontWeight: FontWeight.w500,
                              //               color: AppColors.kPrimaryColor,
                              //             ),
                              //           ),
                              //         ),
                              //         const SizedBox(
                              //           width: 5,
                              //         ),
                              //         const Icon(
                              //           Icons.download,
                              //           color: AppColors.kPrimaryColor,
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              const SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )
              //  AllMyOrdersRealFBSPage(fulfillment: 'realFBS'),
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      const Text(
                        'Отсутствует заказы realFBS',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff717171)),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              const SizedBox(),
            ],
          ),
        ));
  }
}

class QRViewExample extends StatefulWidget {
  int id;
  int product_id;
  String fulfillment;
  QRViewExample(
      {required this.id,
      required this.product_id,
      required this.fulfillment,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (result != null)
                  Container(
                      margin: const EdgeInsets.all(8),
                      child: DefaultButton(
                        width: 350,
                        color: Colors.white,
                        backgroundColor: AppColors.kPrimaryColor,
                        text: '${result?.code ?? 'Код не найден'}',
                        press: () async {
                          if (result?.code == widget.id.toString()) {
                            Get.snackbar('Заказ', 'возврат оформлен',
                                backgroundColor: Colors.greenAccent);

                            BlocProvider.of<OrderStatusAdminCubit>(context)
                                .basketStatus(
                                    'cancel',
                                    widget.id.toString(),
                                    widget.product_id.toString(),
                                    widget.fulfillment);
                          } else {
                            Get.snackbar('Заказ', 'код товара не совпал',
                                backgroundColor: Colors.greenAccent);
                          }
                        },
                      ))
                else
                  SizedBox(
                      height: 50,
                      width: 50,
                      child: const CircularProgressIndicator()),
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: <Widget>[
                //       Container(
                //         margin: const EdgeInsets.all(8),
                //         child: ElevatedButton(
                //             onPressed: () async {
                //               await controller?.toggleFlash();
                //               setState(() {});
                //             },
                //             child: FutureBuilder(
                //               future: controller?.getFlashStatus(),
                //               builder: (context, snapshot) {
                //                 return Text('Свет: ${snapshot.data != false ? 'включен' : 'выключен'}');
                //               },
                //             )),
                //       ),
                //       Container(
                //         margin: const EdgeInsets.all(8),
                //         child: ElevatedButton(
                //             onPressed: () async {
                //               await controller?.flipCamera();
                //               setState(() {});
                //             },
                //             child: FutureBuilder(
                //               future: controller?.getCameraInfo(),
                //               builder: (context, snapshot) {
                //                 if (snapshot.data != null) {
                //                   return Text(
                //                       'Камера: ${describeEnum(snapshot.data!) != 'back' ? 'передняя' : 'задняя'}');
                //                 } else {
                //                   return const Text('loading');
                //                 }
                //               },
                //             )),
                //       )
                //     ],
                //   ),
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: <Widget>[
                //       Container(
                //         margin: const EdgeInsets.all(8),
                //         child: ElevatedButton(
                //           onPressed: () async {
                //             await controller?.pauseCamera();
                //           },
                //           child: const Text('Пауза', style: TextStyle(fontSize: 20)),
                //         ),
                //       ),
                //       Container(
                //         margin: const EdgeInsets.all(8),
                //         child: ElevatedButton(
                //           onPressed: () async {
                //             await controller?.resumeCamera();
                //           },
                //           child: const Text('Продолжать', style: TextStyle(fontSize: 20)),
                //         ),
                //       )
                //     ],
                //   ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        if (result?.code != null) {
          if (result?.code == scanData.code) {
            result = scanData;
          }
        } else {
          result = scanData;
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
