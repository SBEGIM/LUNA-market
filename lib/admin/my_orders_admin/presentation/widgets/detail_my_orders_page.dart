import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/admin/my_orders_admin/data/bloc/order_status_admin_cubit.dart';
import 'package:haji_market/admin/my_orders_admin/data/models/basket_admin_order_model.dart';
import 'package:haji_market/admin/my_orders_admin/presentation/widgets/delivery_note_widget.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/widgets/error_image_widget.dart';
import '../../../../features/app/widgets/custom_back_button.dart';
import '../../data/bloc/basket_admin_cubit.dart';

class DetailMyOrdersPage extends StatefulWidget {
  final BasketAdminOrderModel basket;
  const DetailMyOrdersPage({required this.basket, Key? key}) : super(key: key);

  @override
  State<DetailMyOrdersPage> createState() => _DetailMyOrdersPageState();
}

class _DetailMyOrdersPageState extends State<DetailMyOrdersPage> {
  String status = '';
  String postStatus = '';
  String postSecondStatus = '';
  String buttonText = '';
  String buttonSecondText = '';

  @override
  void initState() {
    switch (widget.basket.status) {
      case 'order':
        {
          status = 'Заказ оформлен';
          postStatus = 'courier';
          postSecondStatus = 'courier';
          buttonText = 'Передать курьеру';
          buttonSecondText = 'Передать курьеру';
        }
        break;

      case 'courier':
        {
          status = 'Передан службе доставка';
          buttonText = 'Ожидание клиента';
          buttonSecondText = 'Ожидание клиента';
        }
        break;
      case 'error':
        {
          status = 'Ошибка';
          postStatus = 'error';
          postSecondStatus = 'error';
          buttonText = 'Ошибка';
          buttonSecondText = 'Ошибка';
        }
        break;
      case 'cancel':
        {
          status = 'Клиент отменил заказ';
          postStatus = 'end';
          postSecondStatus = 'end';
          buttonText = 'Завершить';
          buttonSecondText = 'Завершить';
        }
        break;
      case 'rejected':
        {
          status = 'Магазин отменил заказ';
          postStatus = 'rejected';
          postSecondStatus = 'rejected';
          buttonText = 'Вы отменили заказ';
          buttonSecondText = 'Вы отменили заказ';
        }
        break;
      case 'end':
        {
          status = 'Заказ окончен';
          postStatus = 'end';
          postSecondStatus = 'end';
          buttonText = 'Заказ окончен';
          buttonSecondText = 'Заказ окончен';
        }
        break;
      case 'in_process':
        {
          status = 'В процессе';
          postStatus = 'success';
          postSecondStatus = 'rejected';
          buttonText = 'Принят';
          buttonSecondText = 'Отклонить';
        }
        break;
      default:
        {
          status = 'Неизвестно';
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
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.basket.product!.length,
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
                          widget.basket.product![index].path!.first.isNotEmpty
                              ? "http://185.116.193.73/storage/${widget.basket.product![index].path!.first}"
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
                              '${widget.basket.product![index].productName}',
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
                                  '${widget.basket.product![index].price}',
                                  style: const TextStyle(
                                      color: AppColors.kGray900,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${widget.basket.product![index].count}x',
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
                            const Text(
                              'Доставка: сегодня',
                              style: TextStyle(
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
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Инфо о заказе',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    Container(
                      decoration: const BoxDecoration(color: AppColors.kGray1),
                      padding: const EdgeInsets.all(8),
                      child: Text(status),
                    )
                  ],
                ),
              ),
              const Divider(
                color: AppColors.kGray400,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
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
                      '${widget.basket.product?.first.price ?? 0} ₽ ',
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
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
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
                      '${widget.basket.product?.first.shopCourier ?? 0} ₽ ',
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
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
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
                      '${widget.basket.summa} ₽ ',
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
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
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
                      '${widget.basket.summa} ₽ ',
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
              const Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Способы оплаты ',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'Master Card **** 5169',
                      style: TextStyle(
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
                                    "http://185.116.193.73/storage/${widget.basket.user!.avatar}")
                                : const AssetImage('assets/icons/profile2.png')
                                    as ImageProvider,
                            fit: BoxFit.cover,
                          )),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      '${widget.basket.user!.name}',
                      style: const TextStyle(
                          color: AppColors.kGray700,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(DeliveryNoteAdmin(
                  basketOrder: widget.basket as BasketAdminOrderModel));
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
              BlocProvider.of<BasketAdminCubit>(context).basketOrderShow('fbs');
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
                      BlocProvider.of<OrderStatusAdminCubit>(context)
                          .basketStatus(
                        postStatus,
                        widget.basket.id.toString(),
                        widget.basket.product!.first.id.toString(),
                      );
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
                              buttonText,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<BasketAdminCubit>(context).basketStatus(
                          postStatus,
                          widget.basket.id.toString(),
                          widget.basket.product!.first.id.toString());
                      BlocProvider.of<BasketAdminCubit>(context)
                          .basketOrderShow('fbs');

                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(
                        13,
                      ),
                      child: Text(
                        buttonSecondText,
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
      ),
    );
  }
}
