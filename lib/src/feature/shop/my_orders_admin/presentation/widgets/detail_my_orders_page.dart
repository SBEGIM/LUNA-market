import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/feature/shop/my_orders_admin/data/bloc/order_status_admin_cubit.dart';
import 'package:haji_market/src/feature/shop/my_orders_admin/data/models/basket_admin_order_model.dart';
import 'package:haji_market/src/feature/shop/my_orders_admin/presentation/widgets/delivery_note_widget.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/widgets/custom_switch_button.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import '../../../../app/widgets/custom_back_button.dart';
import '../../../chat/presentation/message_admin_page.dart';
import '../../data/bloc/basket_admin_cubit.dart';

@RoutePage()
class DetailMyOrdersPage extends StatefulWidget implements AutoRouteWrapper {
  final BasketAdminOrderModel basket;
  const DetailMyOrdersPage({required this.basket, Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  State<DetailMyOrdersPage> createState() => _DetailMyOrdersPageState();
}

class _DetailMyOrdersPageState extends State<DetailMyOrdersPage> {
  String statusFBS = '';
  String statusRealFBS = '';

  String postStatusFBS = '';
  String postStatusRealFBS = '';

  String postSecondStatusFBS = '';
  String postSecondStatusRealFBS = '';

  String buttonTextFBS = '';
  String buttonTextRealFBS = '';

  String buttonSecondTextFBS = '';
  String buttonSecondTextRealFBS = '';

  int segmentValue = 0;

  @override
  void initState() {
    switch (widget.basket.statusFBS) {
      case 'order':
        {
          statusFBS = 'Заказ оформлен';
          postStatusFBS = 'accepted';
          postSecondStatusFBS = 'cancel';

          buttonTextFBS = 'Принять';
          buttonSecondTextFBS = 'Отменить заказ';
        }
        break;

      case 'accepted':
        {
          statusFBS = 'Заказ оформлен';
          postStatusFBS = 'courier';
          postSecondStatusFBS = 'cancel';

          buttonTextFBS = 'Передать курьеру';
          buttonSecondTextFBS = 'Отменить заказ';
        }
        break;

      case 'courier':
        {
          statusFBS = 'Передан службе доставка';
          postStatusFBS = '';
          postSecondStatusFBS = 'error';
          buttonTextFBS = 'Ожидание клиента';
          buttonSecondTextFBS = 'Проблемы с заказом';
        }
        break;
      case 'error':
        {
          statusFBS = 'Ошибка';
          postStatusFBS = 'courier';
          postSecondStatusFBS = '';
          buttonTextFBS = 'Передать курьеру';
          buttonSecondTextFBS = 'Ошибка c заказом';
        }
        break;
      case 'cancel':
        {
          statusFBS = 'Клиент отменил заказ';
          postStatusFBS = 'end';
          postSecondStatusFBS = 'end';
          buttonTextFBS = 'Завершить';
          buttonSecondTextFBS = 'Завершить';
        }
        break;
      case 'rejected':
        {
          statusFBS = 'Магазин отменил заказ';
          postStatusFBS = 'rejected';
          postSecondStatusFBS = 'rejected';
          buttonTextFBS = 'Вы отменили заказ';
          buttonSecondTextFBS = 'Вы отменили заказ';
        }
        break;
      case 'end':
        {
          statusFBS = 'Заказ окончен';
          postStatusFBS = 'end';
          postSecondStatusFBS = 'end';
          buttonTextFBS = 'Заказ окончен';
          buttonSecondTextFBS = 'Заказ окончен';
        }
        break;
      case 'success':
        {
          statusFBS = 'Принять';
          postStatusFBS = 'courier';
          postSecondStatusFBS = 'rejected';
          buttonTextFBS = 'Передать курьеру';
          buttonSecondTextFBS = 'Отклонить';
        }
        break;
      case 'in_process':
        {
          statusFBS = 'В процессе';
          postStatusFBS = 'success';
          postSecondStatusFBS = 'rejected';
          buttonTextFBS = 'Принять';
          buttonSecondTextFBS = 'Отклонить';
        }
        break;
      default:
        {
          statusFBS = 'Неизвестно';
          buttonTextFBS = 'В ожидании';
          buttonSecondTextFBS = 'В ожидании';
        }
        break;
    }

    switch (widget.basket.statusRealFBS) {
      case 'order':
        {
          statusRealFBS = 'Заказ оформлен';
          postStatusRealFBS = 'accepted';
          postSecondStatusRealFBS = 'cancel';

          buttonTextRealFBS = 'Принять';
          buttonSecondTextRealFBS = 'Отменить заказ';
        }
        break;

      case 'accepted':
        {
          statusRealFBS = 'Заказ оформлен';
          postStatusRealFBS = 'courier';
          postSecondStatusRealFBS = 'cancel';

          buttonTextRealFBS = 'Передать курьеру';
          buttonSecondTextRealFBS = 'Отменить заказ';
        }
        break;

      case 'courier':
        {
          statusRealFBS = 'Передан службе доставка';
          postStatusRealFBS = '';
          postSecondStatusRealFBS = 'error';
          buttonTextRealFBS = 'Ожидание клиента';
          buttonSecondTextRealFBS = 'Проблемы с заказом';
        }
        break;
      case 'error':
        {
          statusRealFBS = 'Ошибка';
          postStatusRealFBS = 'courier';
          postSecondStatusRealFBS = '';
          buttonTextRealFBS = 'Передать курьеру';
          buttonSecondTextRealFBS = 'Ошибка c заказом';
        }
        break;
      case 'cancel':
        {
          statusRealFBS = 'Клиент отменил заказ';
          postStatusRealFBS = 'end';
          postSecondStatusRealFBS = 'end';
          buttonTextRealFBS = 'Завершить';
          buttonSecondTextRealFBS = 'Завершить';
        }
        break;
      case 'rejected':
        {
          statusRealFBS = 'Магазин отменил заказ';
          postStatusRealFBS = 'rejected';
          postSecondStatusRealFBS = 'rejected';
          buttonTextRealFBS = 'Вы отменили заказ';
          buttonSecondTextRealFBS = 'Вы отменили заказ';
        }
        break;
      case 'end':
        {
          statusRealFBS = 'Заказ окончен';
          postStatusRealFBS = 'end';
          postSecondStatusRealFBS = 'end';
          buttonTextRealFBS = 'Заказ окончен';
          buttonSecondTextRealFBS = 'Заказ окончен';
        }
        break;
      case 'success':
        {
          statusRealFBS = 'Принять';
          postStatusRealFBS = 'courier';
          postSecondStatusRealFBS = 'rejected';
          buttonTextRealFBS = 'Передать курьеру';
          buttonSecondTextRealFBS = 'Отклонить';
        }
        break;
      case 'in_process':
        {
          statusRealFBS = 'В процессе';
          postStatusRealFBS = 'success';
          postSecondStatusRealFBS = 'rejected';
          buttonTextRealFBS = 'Принять';
          buttonSecondTextRealFBS = 'Отклонить';
        }
        break;
      default:
        {
          statusRealFBS = 'Неизвестно';

          buttonTextRealFBS = 'В ожидании';
          buttonSecondTextRealFBS = 'В ожидании';
        }
        break;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '№${widget.basket.id}',
          style: AppTextStyles.appBarTextStyle,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            Navigator.pop(context);
          }),
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
      body: IndexedStack(
        index: segmentValue,
        children: [
          if (widget.basket.productFBS?.isNotEmpty ?? false)
            ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.basket.productFBS?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: Image.network(
                                widget.basket.productFBS![index].path != null &&
                                        widget.basket.productFBS![index].path!
                                            .isNotEmpty
                                    ? "https://lunamarket.ru/storage/${widget.basket.productFBS![index].path?.first}"
                                    : '',
                                fit: BoxFit.cover,
                                height: 104,
                                width: 104,
                                errorBuilder: (context, error, stackTrace) =>
                                    const ErrorImageWidget(
                                  height: 104,
                                  width: 104,
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.basket.productFBS?[index].productName}',
                                    style: const TextStyle(
                                        color: AppColors.kGray900,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${widget.basket.productFBS?[index].price}',
                                        style: const TextStyle(
                                            color: AppColors.kGray900,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${widget.basket.productFBS?[index].count}x',
                                        style: const TextStyle(
                                            color: AppColors.kPrimaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  // const Text(
                                  //   'Продавец: Sulpak',
                                  //   style: TextStyle(
                                  //       color: AppColors.kGray900,
                                  //       fontSize: 12,
                                  //       fontWeight: FontWeight.w400),
                                  // ),
                                  // const SizedBox(
                                  //   height: 8,
                                  // ),
                                  Text(
                                    'Доставка: ${widget.basket.deliveryDay} дней ',
                                    style: const TextStyle(
                                        color: AppColors.kGray900,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Container(
                  color: Colors.white,
                  // padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${widget.basket.preorder == 1 ? 'Инфо о предзаказе' : 'Инфо о заказе'}",
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          Container(
                            decoration:
                                const BoxDecoration(color: AppColors.kGray1),
                            padding: const EdgeInsets.all(8),
                            child: Text(statusFBS),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: AppColors.kGray400,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Сумма без доставки ',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${widget.basket.priceFBS} ₽ ',
                            style: const TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: AppColors.kGray400,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Размер',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${widget.basket.size != 'null' ? (widget.basket.size ?? 'Не выбран') : 'Не выбран'} ',
                            style: const TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: AppColors.kGray400,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Доставка',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${widget.basket.deliveryPrice}  ₽ ',
                            style: const TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: AppColors.kGray400,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Сумма покупки ',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${widget.basket.priceFBS! + widget.basket.deliveryPrice! - widget.basket.bonus!} ₽ ',
                            style: const TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: AppColors.kGray400,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Оплата бонусами  ',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${widget.basket.bonus ?? 0} ₽ ',
                            style: const TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    // const Divider(
                    //   color: AppColors.kGray400,
                    // ),
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 16.0, right: 16, top: 16),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         'Способы оплаты ',
                    //         style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w400),
                    //       ),
                    //       Text(
                    //         'Master Card **** 5169',
                    //         style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w500),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    const Divider(
                      color: AppColors.kGray400,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Адрес доставки',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: AppColors.kGray400,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.map_outlined,
                        color: AppColors.kPrimaryColor,
                      ),
                      minLeadingWidth: 12,
                      title: Text(
                        '${widget.basket.product!.first.address}',
                        style: const TextStyle(
                            color: AppColors.kGray900,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Клиент',
                        style: TextStyle(
                            color: AppColors.kGray900,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(31),
                                image: DecorationImage(
                                  image: (widget.basket.user!.avatar != null)
                                      ? NetworkImage(
                                          "https://lunamarket.ru/storage/${widget.basket.user!.avatar}")
                                      : const AssetImage(
                                              'assets/icons/profile2.png')
                                          as ImageProvider,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.basket.user!.name}',
                                  style: const TextStyle(
                                      color: AppColors.kGray700,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    Get.to(MessageAdmin(
                                        userId: widget.basket.user!.id,
                                        userName: widget.basket.user!.name,
                                        // avatar: state.tapeModel[index].shop!.image,
                                        chatId: widget.basket.chatId));
                                  },
                                  child: const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.chat_bubble,
                                        color: AppColors.kPrimaryColor,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'написать в чат',
                                        style: TextStyle(
                                            color: AppColors.kPrimaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(DeliveryNoteAdmin(basketOrder: widget.basket));
                  },
                  child: SizedBox(
                    height: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left: 16),
                          child: const Text(
                            'Скачать накладную',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.kPrimaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.download,
                          color: AppColors.kPrimaryColor,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocConsumer<OrderStatusAdminCubit, OrderStatusAdminState>(
                    listener: (context, state) {
                  if (state is LoadedState) {
                    BlocProvider.of<BasketAdminCubit>(context)
                        .basketOrderShow('fbs');
                    Navigator.pop(context);
                  } else if (state is ErrorState) {
                    Get.snackbar('Ошибка', state.message,
                        backgroundColor: Colors.redAccent);
                  }
                }, builder: (context, state) {
                  return Container(
                    height: 65,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (postStatusFBS != '' &&
                                statusFBS != 'in_process') {
                              BlocProvider.of<OrderStatusAdminCubit>(context)
                                  .basketStatus(
                                      postStatusFBS,
                                      widget.basket.id.toString(),
                                      widget.basket.product!.first.id
                                          .toString(),
                                      'fbs');

                              BlocProvider.of<BasketAdminCubit>(context)
                                  .basketOrderRealFBSshow('realFBS');

                              Get.back();
                            } else {
                              Get.snackbar(
                                  'Заказ', 'Невозможно изменить статус',
                                  backgroundColor: Colors.orangeAccent);
                            }
                          },
                          child: Container(
                            height: 42,
                            decoration: BoxDecoration(
                                color: AppColors.kPrimaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 13, horizontal: 25),
                            child: state is LoadingState
                                ? const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  )
                                : Text(
                                    buttonTextFBS,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (postSecondStatusFBS != '') {
                              BlocProvider.of<BasketAdminCubit>(context)
                                  .basketStatus(
                                      postSecondStatusFBS,
                                      widget.basket.id.toString(),
                                      widget.basket.product!.first.id
                                          .toString(),
                                      'fbs');
                              BlocProvider.of<BasketAdminCubit>(context)
                                  .basketOrderRealFBSshow('fbs');

                              Get.back();
                            } else {
                              Get.snackbar(
                                  'Заказ', 'Невозможно изменить статус',
                                  backgroundColor: Colors.orangeAccent);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(
                              13,
                            ),
                            child: Text(
                              buttonSecondTextFBS,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                })
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
          if (widget.basket.productRealFBS?.isNotEmpty ?? false)
            ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.basket.productRealFBS?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: Image.network(
                                widget.basket.productRealFBS![index].path !=
                                            null &&
                                        widget.basket.productRealFBS![index]
                                            .path!.isNotEmpty
                                    ? "https://lunamarket.ru/storage/${widget.basket.productRealFBS![index].path?.first}"
                                    : '',
                                fit: BoxFit.cover,
                                height: 104,
                                width: 104,
                                errorBuilder: (context, error, stackTrace) =>
                                    const ErrorImageWidget(
                                  height: 104,
                                  width: 104,
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.basket.productRealFBS?[index].productName}',
                                    style: const TextStyle(
                                        color: AppColors.kGray900,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${widget.basket.productRealFBS?[index].price}',
                                        style: const TextStyle(
                                            color: AppColors.kGray900,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${widget.basket.productRealFBS?[index].count}x',
                                        style: const TextStyle(
                                            color: AppColors.kPrimaryColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  // const Text(
                                  //   'Продавец: Sulpak',
                                  //   style: TextStyle(
                                  //       color: AppColors.kGray900,
                                  //       fontSize: 12,
                                  //       fontWeight: FontWeight.w400),
                                  // ),
                                  // const SizedBox(
                                  //   height: 8,
                                  // ),
                                  Text(
                                    'Доставка: ${widget.basket.deliveryDay} дней ',
                                    style: const TextStyle(
                                        color: AppColors.kGray900,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Container(
                  color: Colors.white,
                  // padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${widget.basket.preorder == 1 ? 'Инфо о предзаказе' : 'Инфо о заказе'}",
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          Container(
                            decoration:
                                const BoxDecoration(color: AppColors.kGray1),
                            padding: const EdgeInsets.all(8),
                            child: Text(statusRealFBS),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: AppColors.kGray400,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Сумма без доставки ',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${widget.basket.priceRealFBS} ₽ ',
                            style: const TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: AppColors.kGray400,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Размер',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${widget.basket.size != 'null' ? (widget.basket.size ?? 'Не выбран') : 'Не выбран'} ',
                            style: const TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: AppColors.kGray400,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Доставка',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${widget.basket.deliveryPrice}  ₽ ',
                            style: const TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: AppColors.kGray400,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Сумма покупки ',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${widget.basket.priceRealFBS! + widget.basket.deliveryPrice! - widget.basket.bonus!} ₽ ',
                            style: const TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: AppColors.kGray400,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Оплата бонусами  ',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${widget.basket.bonus ?? 0} ₽ ',
                            style: const TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    // const Divider(
                    //   color: AppColors.kGray400,
                    // ),
                    // const Padding(
                    //   padding: EdgeInsets.only(left: 16.0, right: 16, top: 16),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         'Способы оплаты ',
                    //         style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w400),
                    //       ),
                    //       Text(
                    //         'Master Card **** 5169',
                    //         style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w500),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    const Divider(
                      color: AppColors.kGray400,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16, top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Адрес доставки',
                            style: TextStyle(
                                color: AppColors.kGray900,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: AppColors.kGray400,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.map_outlined,
                        color: AppColors.kPrimaryColor,
                      ),
                      minLeadingWidth: 12,
                      title: Text(
                        '${widget.basket.productRealFBS!.first.address}',
                        style: const TextStyle(
                            color: AppColors.kGray900,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Клиент',
                        style: TextStyle(
                            color: AppColors.kGray900,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 64,
                            width: 64,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(31),
                                image: DecorationImage(
                                  image: (widget.basket.user!.avatar != null)
                                      ? NetworkImage(
                                          "https://lunamarket.ru/storage/${widget.basket.user!.avatar}")
                                      : const AssetImage(
                                              'assets/icons/profile2.png')
                                          as ImageProvider,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.basket.user!.name}',
                                  style: const TextStyle(
                                      color: AppColors.kGray700,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    Get.to(MessageAdmin(
                                        userId: widget.basket.user!.id,
                                        userName: widget.basket.user!.name,
                                        // avatar: state.tapeModel[index].shop!.image,
                                        chatId: widget.basket.chatId));
                                  },
                                  child: const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.chat_bubble,
                                        color: AppColors.kPrimaryColor,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'написать в чат',
                                        style: TextStyle(
                                            color: AppColors.kPrimaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(DeliveryNoteAdmin(basketOrder: widget.basket));
                  },
                  child: SizedBox(
                    height: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left: 16),
                          child: const Text(
                            'Скачать накладную',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.kPrimaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.download,
                          color: AppColors.kPrimaryColor,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocConsumer<OrderStatusAdminCubit, OrderStatusAdminState>(
                    listener: (context, state) {
                  if (state is LoadedState) {
                    BlocProvider.of<BasketAdminCubit>(context)
                        .basketOrderShow('fbs');
                    Navigator.pop(context);
                  } else if (state is ErrorState) {
                    Get.snackbar('Ошибка', state.message,
                        backgroundColor: Colors.redAccent);
                  }
                }, builder: (context, state) {
                  return Container(
                    height: 65,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (postStatusRealFBS != '' &&
                                statusRealFBS != 'in_process') {
                              BlocProvider.of<OrderStatusAdminCubit>(context)
                                  .basketStatus(
                                      postStatusRealFBS,
                                      widget.basket.id.toString(),
                                      widget.basket.product!.first.id
                                          .toString(),
                                      'realFBS');

                              BlocProvider.of<BasketAdminCubit>(context)
                                  .basketOrderRealFBSshow('realFBS');

                              Get.back();
                            } else {
                              Get.snackbar(
                                  'Заказ', 'Невозможно изменить статус',
                                  backgroundColor: Colors.orangeAccent);
                            }
                          },
                          child: Container(
                            height: 42,
                            decoration: BoxDecoration(
                                color: AppColors.kPrimaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 13, horizontal: 25),
                            child: state is LoadingState
                                ? const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  )
                                : Text(
                                    buttonTextRealFBS,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (postSecondStatusRealFBS != '') {
                              BlocProvider.of<BasketAdminCubit>(context)
                                  .basketStatus(
                                      postSecondStatusRealFBS,
                                      widget.basket.id.toString(),
                                      widget.basket.product!.first.id
                                          .toString(),
                                      'realFBS');
                              BlocProvider.of<BasketAdminCubit>(context)
                                  .basketOrderRealFBSshow('realFBS');

                              Get.back();
                            } else {
                              Get.snackbar(
                                  'Заказ', 'Невозможно изменить статус',
                                  backgroundColor: Colors.orangeAccent);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(
                              13,
                            ),
                            child: Text(
                              buttonSecondTextRealFBS,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                })
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
        ],
      ),
    );
  }
}
