import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/basket/data/models/basket_order_model.dart';
import 'package:haji_market/src/feature/my_order/presentation/widget/my_order_status_page.dart';

class MyOrderCardWidget extends StatefulWidget {
  int index;
  final BasketOrderModel basketOrder;

  MyOrderCardWidget({Key? key, required this.index, required this.basketOrder}) : super(key: key);

  @override
  State<MyOrderCardWidget> createState() => _MyOrderCardWidgetState();
}

class _MyOrderCardWidgetState extends State<MyOrderCardWidget> {
  // Текст статуса
  String get _statusText {
    switch (widget.basketOrder.status) {
      case 'order':
        return 'Заказ оформлен';
      case 'accepted':
        return 'Заказ принят';
      case 'courier':
        return 'Передан службе доставки';
      case 'in_process':
        return 'В процессе';
      case 'end':
        return 'Выдан'; // или 'Заказ окончен'
      case 'cancel':
        return 'Клиент отменил заказ';
      case 'rejected':
        return 'Магазин отменил заказ';
      case 'error':
        return 'Ошибка';
      case 'success':
        return 'Принят';
      // если есть статусы типа спорный / возврат — добавь тут:
      // case 'dispute':
      //   return 'Спорный';
      // case 'refund':
      //   return 'Возврат';
      default:
        return 'Неизвестно';
    }
  }

  // Цвет статуса
  String statusTitle(String? status) {
    switch (status) {
      case 'order':
        return 'Заказ оформлен';
      case 'accepted':
        return 'Заказ принят';
      case 'courier':
        return 'Передан службе доставки';
      case 'in_process':
        return 'В процессе';
      case 'success':
        return 'Выдан';
      case 'end':
        return 'Завершён';
      case 'cancel':
        return 'Отменён клиентом';
      case 'rejected':
        return 'Отменён магазином';
      case 'error':
        return 'Ошибка';
      default:
        return 'Неизвестно';
    }
  }

  Color statusColor(String? status) {
    switch (status) {
      case 'order':
        return const Color(0xFF6C5CE7); // фиолетовый
      case 'accepted':
        return const Color(0xFF00B894); // мятный
      case 'courier':
        return const Color(0xFF0984E3); // синий
      case 'in_process':
        return const Color(0xFFE84393); // розово-фиолетовый
      case 'success':
        return const Color(0xFF00C853); // зелёный
      case 'end':
        return const Color(0xFF2ECC71); // спокойный зелёный
      case 'cancel':
        return const Color(0xFFD63031); // красный
      case 'rejected':
        return const Color(0xFFE17055); // оранжевый
      case 'error':
        return const Color(0xFF636E72); // серый
      default:
        return const Color(0xFF8E8E93); // дефолт
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.basketOrder.id != null
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MyOrderStatusPage(index: widget.index, basketOrder: widget.basketOrder),
                ),
              )
            : printError();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '№${widget.basketOrder.id}',
                      textAlign: TextAlign.right,
                      style: AppTextStyles.size14Weight500.copyWith(color: const Color(0xff8E8E93)),
                    ),
                    Text(
                      _statusText,
                      style: AppTextStyles.size14Weight500.copyWith(
                        color: statusColor(widget.basketOrder.status),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                if (widget.basketOrder.product?.isNotEmpty ?? false)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.basketOrder.deliveryDay} дней',
                            style: AppTextStyles.size16Weight500.copyWith(
                              color: const Color(0xff3A3A3C),
                            ),
                          ),
                          Text(
                            '${widget.basketOrder.summa} ₽',
                            style: AppTextStyles.size16Weight700.copyWith(
                              color: const Color(0xff3A3A3C),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                // дальше твой код с картинками
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.basketOrder.product?.length ?? 0,
                    itemBuilder: (BuildContext context, int i) {
                      final path = widget.basketOrder.product?[i].path?.isNotEmpty == true
                          ? widget.basketOrder.product![i].path!.first
                          : null;
                      final url = path != null ? 'https://lunamarket.ru/storage/$path' : null;

                      final dpr = MediaQuery.of(context).devicePixelRatio;
                      final cacheSize = (48 * dpr).round();

                      return Container(
                        height: 48,
                        width: 48,
                        margin: const EdgeInsets.only(right: 9, top: 12),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.kGray200,
                        ),
                        child: url == null
                            ? const Icon(Icons.image_not_supported_outlined)
                            : Image.network(
                                url,
                                fit: BoxFit.cover,
                                cacheWidth: cacheSize,
                                cacheHeight: cacheSize,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return const Center(
                                    child: SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stack) =>
                                    const Icon(Icons.broken_image_outlined),
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
