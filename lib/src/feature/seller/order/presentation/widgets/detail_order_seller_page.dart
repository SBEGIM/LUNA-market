import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/feature/seller/order/bloc/order_status_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/order/data/models/basket_order_seller_model.dart';
import 'package:haji_market/src/feature/seller/order/presentation/widgets/delivery_note_seller_widget.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import 'package:haji_market/src/feature/seller/order/presentation/widgets/show_module_order_seller_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../chat/presentation/message_seller_page.dart';
import '../../bloc/basket_seller_cubit.dart';

@RoutePage()
class DetailOrderSellerPage extends StatefulWidget implements AutoRouteWrapper {
  final BasketOrderSellerModel basketOrder;
  const DetailOrderSellerPage({required this.basketOrder, Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  State<DetailOrderSellerPage> createState() => _DetailOrderSellerPageState();
}

class _DetailOrderSellerPageState extends State<DetailOrderSellerPage> {
  late BasketOrderSellerModel _basketOrder;

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  Future<void> onRefresh() async {
    try {
      final data = await context.read<BasketSellerCubit>().basketOrderShowById(
        id: widget.basketOrder.id!,
      );

      if (!mounted) return;

      setState(() {
        _basketOrder = data;
        basketStatusLine(data.status ?? '');
      });

      _refreshController.refreshCompleted();
    } catch (_) {
      if (!mounted) return;
      _refreshController.refreshFailed();
    }
  }

  String statusFBS = '';

  String postStatusFBS = '';

  String postSecondStatusFBS = '';

  String buttonTextFBS = '';

  String buttonSecondTextFBS = '';
  int segmentValue = 0;

  String textSnackBar = '';

  String reasonPrimaryFBS = '';
  String reasonSecondFBS = '';

  String shopStepText = '';
  String shopStepsFBS = '';

  @override
  void initState() {
    _basketOrder = widget.basketOrder;

    basketStatusLine(_basketOrder.status!);

    super.initState();
  }

  basketStatusLine(String status) {
    statusFBS = '';
    postStatusFBS = '';
    postSecondStatusFBS = '';
    buttonTextFBS = '';
    buttonSecondTextFBS = '';
    textSnackBar = '';
    reasonPrimaryFBS = '';
    reasonSecondFBS = '';
    shopStepText = '';
    shopStepsFBS = '';

    switch (status) {
      case 'order':
        {
          statusFBS = 'Заказ оформлен';
          postStatusFBS = 'accepted';
          postSecondStatusFBS = 'cancel';

          buttonTextFBS = 'Принять';
          buttonSecondTextFBS = 'Отклонить';

          shopStepText = 'Отлично, заказ принят!';
          shopStepsFBS =
              '1. Соберите и упакуйте товар.\n'
              '2. Нажмите «Передать службе доставки»,\n когда будете готовы.\n'
              '3. Дождитесь подтверждения передачи.\nМы уведомим покупателя.';
        }
        break;

      case 'accepted':
        {
          statusFBS = 'Заказ принят';
          postStatusFBS = 'courier';
          postSecondStatusFBS = 'cancel';

          textSnackBar = 'Заказ принят';

          buttonTextFBS = 'Передать службе доставки';
          buttonSecondTextFBS = 'Отклонить';

          shopStepText = 'Отлично, заказ передан\nслужбе доставки!';
          shopStepsFBS =
              '1. Когда товар прибудет в пункт выдачи,\n нажмите «Готов к выдаче»'
              '2. Если возникла проблема при передаче,\n нажмите «Проблемы с заказом».';
        }
        break;

      case 'courier':
        {
          statusFBS = 'Доставка в пути';
          postStatusFBS = 'error';
          postSecondStatusFBS = 'ready_for_pickup';

          textSnackBar = 'Готов к выдаче';

          buttonTextFBS = 'Проблемы с заказом';
          buttonSecondTextFBS = 'Готов к выдаче';

          shopStepText = 'Отлично, заказ готов \nк выдаче покупателю!';
          shopStepsFBS =
              '1. Дождитесь, когда покупатель получит\n заказ в пункте выдачи..\n'
              '2. После получения статус обновится\n автоматически.';
        }
        break;

      case 'ready_for_pickup':
        {
          statusFBS = 'Готов к выдаче';
          postStatusFBS = '';
          postSecondStatusFBS = '';

          textSnackBar = 'Ожидайте, клиент забирает заказ';
          buttonTextFBS = 'Клиент забирает заказ';
          buttonSecondTextFBS = '';

          reasonPrimaryFBS =
              '1. Дождитесь, когда покупатель получит\nзаказ в пункте выдачи.\n'
              '2. Этот этап не переводится вручную.\nСтатус изменится автоматически после\n того, как покупатель получит заказ.';
          reasonSecondFBS = '';

          shopStepText = 'Ожидаем, когда покупатель \nзаберёт заказ';
          shopStepsFBS =
              '1. Дождитесь, когда покупатель получит\n заказ в пункте выдачи..\n'
              '2. Этот этап не переводится вручную.\n Статус изменится автоматически после\n того, как покупатель получит заказ.';
        }
        break;

      case 'delivered':
        {
          statusFBS = 'Заказ доставлен';
          postStatusFBS = 'end';
          postSecondStatusFBS = 'end';

          buttonTextFBS = 'Завершить';
          buttonSecondTextFBS = 'Завершить';
        }
        break;

      case 'return':
        {
          statusFBS = 'Возврат заказа';
          postStatusFBS = 'end';
          postSecondStatusFBS = 'end';

          buttonTextFBS = 'Завершить';
          buttonSecondTextFBS = 'Завершить';
        }
        break;

      case 'error':
        {
          statusFBS = 'Ошибка';
          postStatusFBS = 'courier';
          postSecondStatusFBS = '';

          buttonTextFBS = 'Передать службе доставки';
          buttonSecondTextFBS = 'Ошибка c заказом';

          // у второй кнопки нет перехода — это инфо/справка
          reasonPrimaryFBS = '';
          reasonSecondFBS =
              'По этому заказу зафиксирована проблема. Создайте обращение/уточните причину ошибки. Перевод во второй статус недоступен.';
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
          statusFBS = 'Заказ завершён';
          postStatusFBS = '';
          postSecondStatusFBS = '';

          textSnackBar = 'Клиент получил товар';

          buttonTextFBS = 'Заказ завершён';
          buttonSecondTextFBS = '';

          reasonPrimaryFBS =
              'Покупатель получил свою посылку. Дальнейшие изменения статуса недоступны.';
          reasonSecondFBS = '';
          shopStepsFBS = 'Заказ завершён. Дополнительных действий не требуется.';
        }
        break;

      case 'success':
        {
          statusFBS = 'Заказ оформлен';
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

          postStatusFBS = '';
          postSecondStatusFBS = '';
          reasonPrimaryFBS = 'Нет доступных действий для текущего статуса.';
          reasonSecondFBS = '';
        }
        break;
    }
    setState(() {});
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        surfaceTintColor: AppColors.kWhite,
        backgroundColor: AppColors.kWhite,
        elevation: 0,
        centerTitle: true,
        title: Text('№${_basketOrder.id}', style: AppTextStyles.appBarTextStyle),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: AppColors.arrowColor, size: 30),
        ),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: false,
        onRefresh: () {
          onRefresh();
        },
        child: (_basketOrder.product?.isNotEmpty ?? false)
            ? ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _basketOrder.product?.length ?? 0,
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
                                  _basketOrder.product![index].path != null &&
                                          _basketOrder.product![index].path!.isNotEmpty
                                      ? "https://lunamarket.ru/storage/${_basketOrder.product![index].path?.first}"
                                      : '',
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const ErrorImageWidget(height: 72, width: 72),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${_basketOrder.product?[index].productName}',
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
                                          '${_basketOrder.product?[index].price}₽',
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
                                          '${_basketOrder.product?[index].count}',
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
                                          ' ${_basketOrder.deliveryDay} дней ',
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
                                "${_basketOrder.preorder == 1 ? 'Статус заказа предзаказа' : 'Статус заказа'}",
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
                              Text(
                                '${_basketOrder.summa} ₽ ',
                                style: AppTextStyles.size16Weight600,
                              ),
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
                                '${_basketOrder.size != 'null' ? (_basketOrder.size ?? 'Не выбран') : 'Не выбран'} ',
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
                                '${_basketOrder.deliveryPrice}  ₽ ',
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
                                '${_basketOrder.summa! + _basketOrder.deliveryPrice! - _basketOrder.bonus!} ₽ ',
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
                                '${_basketOrder.bonus ?? 0} ₽ ',
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
                            '${_basketOrder.product!.first.address}',
                            style: AppTextStyles.size16Weight600,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 116,
                    width: 358,
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
                          style: AppTextStyles.size14Weight500.copyWith(color: Color(0xffAEAEB2)),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(31),
                                image: DecorationImage(
                                  image: (_basketOrder.user!.avatar != null)
                                      ? NetworkImage(
                                          "https://lunamarket.ru/storage/${_basketOrder.user!.avatar}",
                                        )
                                      : const AssetImage('assets/icons/profile2.png')
                                            as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${_basketOrder.user?.fullName ?? ''}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.size16Weight600,
                                ),
                                const SizedBox(height: 2),
                                InkWell(
                                  onTap: () {
                                    Get.to(
                                      MessageSeller(
                                        userId: _basketOrder.user!.id,
                                        userName: _basketOrder.user!.fullName,
                                        chatId: _basketOrder.chatId,
                                        role: 'user',
                                      ),
                                    );
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.chat_bubble,
                                        color: AppColors.mainPurpleColor,
                                        size: 20,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'Написать в чат',
                                        style: AppTextStyles.size14Weight400.copyWith(
                                          color: AppColors.mainPurpleColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(DeliveryNoteSellerPage(basketOrder: _basketOrder));
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
                  BlocBuilder<OrderStatusSellerCubit, OrderStatusSellerState>(
                    builder: (context, state) {
                      return Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  if (reasonPrimaryFBS.isNotEmpty) {
                                    showModuleOrderSeller(
                                      context,
                                      'Заказ №${_basketOrder.id}',
                                      statusFBS,
                                      reasonPrimaryFBS,
                                    );
                                    return;
                                  }
                                  if (postStatusFBS.isEmpty) return;

                                  if (shopStepsFBS.isNotEmpty) {
                                    showModuleOrderSeller(
                                      context,
                                      'Заказ №${_basketOrder.id}',
                                      shopStepText,
                                      shopStepsFBS,
                                    );
                                  }

                                  await context.read<OrderStatusSellerCubit>().basketStatus(
                                    postStatusFBS,
                                    _basketOrder.id.toString(),
                                    _basketOrder.product!.first.id.toString(),
                                    '',
                                  );

                                  await onRefresh();
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: _basketOrder.status != 'accepted'
                                        ? Color(0xffEAECED)
                                        : AppColors.mainPurpleColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: state is LoadingState
                                      ? const Center(child: CircularProgressIndicator.adaptive())
                                      : Text(
                                          buttonTextFBS,
                                          style: AppTextStyles.size16Weight600.copyWith(
                                            color: _basketOrder.status != 'accepted'
                                                ? AppColors.kLightBlackColor
                                                : AppColors.kWhite,
                                          ),
                                        ),
                                ),
                              ),
                            ),

                            _basketOrder.status != 'accepted'
                                ? SizedBox(width: 12)
                                : SizedBox.shrink(),

                            _basketOrder.status == 'accepted' ||
                                    _basketOrder.status == 'ready_for_pickup' ||
                                    _basketOrder.status == 'end'
                                ? SizedBox.shrink()
                                : Expanded(
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (reasonPrimaryFBS.isNotEmpty) {
                                          showModuleOrderSeller(
                                            context,
                                            'Заказ №${_basketOrder.id}',
                                            statusFBS,
                                            reasonPrimaryFBS,
                                          );
                                          return;
                                        }
                                        if (postSecondStatusFBS.isEmpty) return;

                                        await context.read<OrderStatusSellerCubit>().basketStatus(
                                          postSecondStatusFBS,
                                          _basketOrder.id.toString(),
                                          _basketOrder.product!.first.id.toString(),
                                          '',
                                        );

                                        await onRefresh();

                                        if (shopStepsFBS.isNotEmpty) {
                                          showModuleOrderSeller(
                                            context,
                                            'Заказ №${_basketOrder.id}',
                                            shopStepText,
                                            shopStepsFBS,
                                          );
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: AppColors.mainPurpleColor,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        alignment: Alignment.center,
                                        child: state is LoadingState
                                            ? const Center(
                                                child: CircularProgressIndicator.adaptive(),
                                              )
                                            : Text(
                                                buttonSecondTextFBS,
                                                style: AppTextStyles.size16Weight600.copyWith(
                                                  color: AppColors.kWhite,
                                                ),
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
      ),
    );
  }
}
