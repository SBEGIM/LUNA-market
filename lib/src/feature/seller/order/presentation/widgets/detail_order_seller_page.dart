import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/feature/seller/order/bloc/order_status_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/order/data/models/basket_order_seller_model.dart';
import 'package:haji_market/src/feature/seller/order/presentation/widgets/delivery_note_seller_widget.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import '../../../chat/presentation/message_seller_page.dart';
import '../../bloc/basket_seller_cubit.dart';

@RoutePage()
class DetailOrderSellerPage extends StatefulWidget implements AutoRouteWrapper {
  final BasketOrderSellerModel basket;
  const DetailOrderSellerPage({required this.basket, Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  State<DetailOrderSellerPage> createState() => _DetailOrderSellerPageState();
}

class _DetailOrderSellerPageState extends State<DetailOrderSellerPage> {
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
    switch (widget.basket.status) {
      case 'order':
        {
          statusFBS = 'Заказ оформлен';
          postStatusFBS = 'accepted';
          postSecondStatusFBS = 'cancel';

          buttonTextFBS = 'Принять';
          buttonSecondTextFBS = 'Отклонить';
        }
        break;

      case 'accepted':
        {
          statusFBS = 'Заказ оформлен';
          postStatusFBS = 'courier';
          postSecondStatusFBS = 'cancel';

          buttonTextFBS = 'Передать курьеру';
          buttonSecondTextFBS = 'Отклонить';
        }
        break;

      case 'courier':
        {
          statusFBS = 'Доставка в пути';
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

    switch (widget.basket.status) {
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
          statusRealFBS = 'Доставка в пути';
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
        title: Text('№${widget.basket.id}', style: AppTextStyles.appBarTextStyle),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: AppColors.arrowColor, size: 30),
        ),
      ),
      body: (widget.basket.product?.isNotEmpty ?? false)
          ? ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: widget.basket.product?.length ?? 0,
                    separatorBuilder: (context, index) => SizedBox(height: 12),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 18, bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 72,
                              width: 72,
                              child: Image.network(
                                widget.basket.product![index].path != null &&
                                        widget.basket.product![index].path!.isNotEmpty
                                    ? "https://lunamarket.ru/storage/${widget.basket.product![index].path?.first}"
                                    : '',
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    const ErrorImageWidget(height: 72, width: 72),
                              ),
                            ),
                            SizedBox(width: 16),
                            SizedBox(
                              width: 220,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${widget.basket.product?[index].productName}',
                                    style: AppTextStyles.size14Weight500,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Сумма:',
                                        style: AppTextStyles.size14Weight400.copyWith(
                                          color: Color(0xff8E8E93),
                                        ),
                                      ),
                                      Text(
                                        '${widget.basket.product?[index].price}₽',
                                        style: AppTextStyles.size14Weight500,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Количество',
                                        style: AppTextStyles.size14Weight400.copyWith(
                                          color: Color(0xff8E8E93),
                                        ),
                                      ),
                                      Text(
                                        '${widget.basket.product?[index].count}',
                                        style: AppTextStyles.size14Weight500,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Доставка:',
                                        style: AppTextStyles.size14Weight400.copyWith(
                                          color: Color(0xff8E8E93),
                                        ),
                                      ),
                                      Text(
                                        ' ${widget.basket.deliveryDay} дней ',
                                        style: AppTextStyles.size14Weight500,
                                      ),
                                    ],
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
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.basket.preorder == 1 ? 'Статус заказа предзаказа' : 'Статус заказа'}",
                              style: AppTextStyles.size14Weight500.copyWith(
                                color: Color(0xff8E8E93),
                              ),
                            ),
                            Text(
                              statusFBS,
                              style: AppTextStyles.size16Weight600.copyWith(
                                color: AppColors.mainPurpleColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Сумма без доставки',
                              style: AppTextStyles.size14Weight500.copyWith(
                                color: Color(0xff8E8E93),
                              ),
                            ),
                            Text('${widget.basket.summa} ₽ ', style: AppTextStyles.size16Weight600),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Размер',
                              style: AppTextStyles.size14Weight500.copyWith(
                                color: Color(0xff8E8E93),
                              ),
                            ),
                            Text(
                              '${widget.basket.size != 'null' ? (widget.basket.size ?? 'Не выбран') : 'Не выбран'} ',
                              style: AppTextStyles.size16Weight600,
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Доставка',
                              style: AppTextStyles.size14Weight500.copyWith(
                                color: Color(0xff8E8E93),
                              ),
                            ),
                            Text(
                              '${widget.basket.deliveryPrice}  ₽ ',
                              style: AppTextStyles.size16Weight600,
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Сумма покупки ',
                              style: AppTextStyles.size14Weight500.copyWith(
                                color: Color(0xff8E8E93),
                              ),
                            ),
                            Text(
                              '${widget.basket.summa! + widget.basket.deliveryPrice! - widget.basket.bonus!} ₽ ',
                              style: AppTextStyles.size16Weight600,
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Оплата бонусами  ',
                              style: AppTextStyles.size14Weight500.copyWith(
                                color: Color(0xff8E8E93),
                              ),
                            ),
                            Text(
                              '${widget.basket.bonus ?? 0} ₽ ',
                              style: AppTextStyles.size16Weight600,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding: EdgeInsets.only(top: 16.0, bottom: 16, left: 16),
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Тип доставки',
                          style: AppTextStyles.size14Weight500.copyWith(color: Color(0xffAEAEB2)),
                        ),
                        SizedBox(height: 2),
                        Text('Курьер', style: AppTextStyles.size16Weight600),
                        SizedBox(height: 12),
                        Text(
                          'Сервис доставки',
                          style: AppTextStyles.size14Weight500.copyWith(color: Color(0xffAEAEB2)),
                        ),
                        SizedBox(height: 2),
                        Text('CDEK ', style: AppTextStyles.size16Weight600),
                        SizedBox(height: 12),
                        Text(
                          'Адрес доставки',
                          style: AppTextStyles.size14Weight500.copyWith(color: Color(0xffAEAEB2)),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '${widget.basket.product!.first.address}',
                          style: AppTextStyles.size16Weight600,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Клиент',
                        style: AppTextStyles.aboutTextStyle.copyWith(color: AppColors.kGray300),
                      ),
                      const SizedBox(height: 10),
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
                                        "https://lunamarket.ru/storage/${widget.basket.user!.avatar}",
                                      )
                                    : const AssetImage('assets/icons/profile2.png')
                                          as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.basket.user!.fullName}',
                                  style: AppTextStyles.defaultButtonTextStyle,
                                ),
                                const SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    Get.to(
                                      MessageSeller(
                                        userId: widget.basket.user!.id,
                                        userName: widget.basket.user!.fullName,
                                        // avatar: state.tapeModel[index].shop!.image,
                                        chatId: widget.basket.chatId,
                                      ),
                                    );
                                  },
                                  child: const Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.chat_bubble,
                                        color: AppColors.mainPurpleColor,
                                        size: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Написать в чат',
                                        style: TextStyle(
                                          color: AppColors.mainPurpleColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(DeliveryNoteSellerPage(basketOrder: widget.basket));
                  },
                  child: SizedBox(
                    height: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.download, color: AppColors.mainPurpleColor),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            'Скачать накладную',
                            style: AppTextStyles.defaultButtonTextStyle.copyWith(
                              color: AppColors.mainPurpleColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                BlocConsumer<OrderStatusSellerCubit, OrderStatusSellerState>(
                  listener: (context, state) {
                    if (state is LoadedState) {
                      BlocProvider.of<BasketSellerCubit>(context).basketOrderShow('fbs');
                      Navigator.pop(context);
                    } else if (state is ErrorState) {
                      Get.snackbar('Ошибка', state.message, backgroundColor: Colors.redAccent);
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      height: 65,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (postStatusFBS != '' && statusFBS != 'in_process') {
                                BlocProvider.of<OrderStatusSellerCubit>(context).basketStatus(
                                  postStatusFBS,
                                  widget.basket.id.toString(),
                                  widget.basket.product!.first.id.toString(),
                                  'fbs',
                                );

                                BlocProvider.of<BasketSellerCubit>(
                                  context,
                                ).basketOrderRealFBSshow('realFBS');

                                Get.back();
                              } else {
                                Get.snackbar(
                                  'Заказ',
                                  'Невозможно изменить статус',
                                  backgroundColor: Colors.orangeAccent,
                                );
                              }
                            },
                            child: Container(
                              height: 40,
                              width: 173,
                              decoration: BoxDecoration(
                                color: Color(0xffEAECED),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: state is LoadingState
                                  ? const Center(child: CircularProgressIndicator.adaptive())
                                  : Text(buttonTextFBS, style: AppTextStyles.size16Weight600),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (postSecondStatusFBS != '') {
                                BlocProvider.of<BasketSellerCubit>(context).basketStatus(
                                  postSecondStatusFBS,
                                  widget.basket.id.toString(),
                                  widget.basket.product!.first.id.toString(),
                                  'fbs',
                                );
                                BlocProvider.of<BasketSellerCubit>(
                                  context,
                                ).basketOrderRealFBSshow('fbs');

                                Get.back();
                              } else {
                                Get.snackbar(
                                  'Заказ',
                                  'Невозможно изменить статус',
                                  backgroundColor: Colors.orangeAccent,
                                );
                              }
                            },
                            child: Container(
                              height: 40,
                              width: 173,
                              decoration: BoxDecoration(
                                color: AppColors.mainPurpleColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                buttonSecondTextFBS,
                                style: AppTextStyles.size16Weight600.copyWith(
                                  color: AppColors.kWhite,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            )
          : Container(
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
                      color: Color(0xff717171),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
    );
  }
}
