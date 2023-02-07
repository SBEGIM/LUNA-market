import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/basket/data/models/basket_order_model.dart';
import 'package:haji_market/features/my_order/presentation/widget/cancel_order_widget.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyOrderStatusPage extends StatefulWidget {
  final BasketOrderModel basketOrder;

  const MyOrderStatusPage({required this.basketOrder, Key? key})
      : super(key: key);

  @override
  State<MyOrderStatusPage> createState() => _MyOrderStatusPageState();
}

class _MyOrderStatusPageState extends State<MyOrderStatusPage> {
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
          )),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
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
                        indicatorStyle: IndicatorStyle(
                          color: AppColors.kPrimaryColor,
                          iconStyle: IconStyle(
                            color: Colors.white,
                            iconData: Icons.check,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                        isLast: true,
                        indicatorStyle: IndicatorStyle(
                          color: Colors.grey,
                          iconStyle: IconStyle(
                            color: Colors.grey,
                            iconData: Icons.start,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Доставка',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '11 июля',
                                style: TextStyle(
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
                      const Divider(
                        height: 1,
                        color: AppColors.kGray500,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 8.5),
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CancelOrderWidget()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'Отменить заказ',
                                style: TextStyle(
                                    color: AppColors.kPrimaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.kPrimaryColor,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
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
                                  borderRadius: BorderRadius.circular(34),
                                  image: const DecorationImage(
                                    image: NetworkImage(
                                        "http://80.87.202.73:8001/storage/shops/1.png"),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            const SizedBox(width: 13),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  '+7${widget.basketOrder.product!.first.shopPhone}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
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
                            Text(
                              '${widget.basketOrder.product!.first.address}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            )
                          ],
                        )
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 12),
                child: Image.network(
                  "http://80.87.202.73:8001/storage/${widget.basketOrder.product!.first.path!.first.toString()}",
                  width: 120,
                  height: 120,
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: 55,
                      child: ListTile(
                        title: const Text(
                          'Товар',
                          style: TextStyle(
                              color: AppColors.kGray900,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        subtitle: Text(
                          '${widget.basketOrder.product!.first.productName}',
                          style: const TextStyle(
                              color: AppColors.kGray300,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                        trailing: Text(
                          '${widget.basketOrder.summa} ₸ ',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const Divider(
                      color: AppColors.kGray400,
                    ),
                    Container(
                      height: 35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 16),
                            child: const Text('Доставка'),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 16),
                            child: Text(
                              '${widget.basketOrder.product!.first.shopCourier!.toInt()} ₸ ',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: AppColors.kGray400,
                    ),
                    Container(
                      height: 35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 16),
                            child: const Text(
                              'К оплате',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 16),
                            child: Text(
                              '${widget.basketOrder.summa!.toInt() + widget.basketOrder.product!.first.shopCourier!.toInt()} ₸ ',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
