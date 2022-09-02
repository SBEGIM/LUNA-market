import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/my_order/presentation/widget/cancel_order_widget.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyOrderStatusPage extends StatefulWidget {
  const MyOrderStatusPage({Key? key}) : super(key: key);

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
          title: const Text(
            '№12345678 ',
            style: TextStyle(
              color: Colors.black,
            ),
          )),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Сегодня',
                  style: TextStyle(
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
                        indicatorStyle: const IndicatorStyle(
                          width: 10,
                          color: Colors.black,
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
                              Text('Заказ оплачен'),
                              Text(
                                '11 июля',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: AppColors.kGray300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      TimelineTile(
                        indicatorStyle: const IndicatorStyle(
                          width: 10,
                          color: Colors.black,
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
                              Text('Заказ оплачен'),
                              Text(
                                '11 июля',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
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
                        color: AppColors.kGray500,
                      ),
                      InkWell(
                        onTap: (){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  CancelOrderWidget()),
  );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 10, bottom: 10),
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
                            SvgPicture.asset(
                              'assets/icons/user.svg',
                            ),
                            const Text('+7 777 777 77 77')
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
                              'assets/icons/user.svg',
                            ),
                            const Text('Алматы, улица Байзакова, 280')
                          ],
                        )
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/images/wireles.png',
                  height: 80,
                  width: 80,
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: const [
                    ListTile(
                      title: Text(
                        'Товар',
                        style: TextStyle(
                            color: AppColors.kGray900,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      subtitle: Text(
                        'Беспроводные наушники Sony',
                        style: TextStyle(
                            color: AppColors.kGray300,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                      trailing: Text('1 009 870 ₸ '),
                    ),
                    Divider(
                      color: AppColors.kGray400,
                    ),
                    ListTile(
                      title: Text('Доставка'),
                      trailing: Text('1 009 870 ₸ '),
                    ),
                    Divider(
                      color: AppColors.kGray400,
                    ),
                    ListTile(
                      title: Text('К оплате'),
                      trailing: Text('1 009 870 ₸ '),
                    ),
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
