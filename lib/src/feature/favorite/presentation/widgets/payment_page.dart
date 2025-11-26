import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/favorite/presentation/widgets/install_ment_widget.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isSwitched = false;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        appBar: AppBar(
            iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
            backgroundColor: Colors.white,
            elevation: 0,
            // leading: IconButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   icon: const Icon(
            //     Icons.arrow_back_ios,
            //     color: AppColors.kPrimaryColor,
            //   ),
            // ),
            centerTitle: true,
            title: const Text(
              'Оплата',
              style: TextStyle(
                color: Colors.black,
              ),
            )),
        bottomSheet: Container(
          color: Colors.white,
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 26),
          child: InkWell(
            onTap: () {
              //            Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) =>  PaymentPage()),
              // );
              // Navigator.pop(context);
            },
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.kPrimaryColor,
                ),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Оформить заказ',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                  textAlign: TextAlign.center,
                )),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  const ListTile(
                    title: Text('Товары'),
                    subtitle: Text('2 товара'),
                    trailing: Text('1 009 870 ₸ '),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  const ListTile(
                    title: Text('Доставка'),
                    // subtitle: Text('2 товара'),
                    trailing: Text('1 009 870 ₸ '),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  const ListTile(
                    title: Text('Сумма покупки'),
                    // subtitle: Text('2 товара'),
                    trailing: Text('1 009 870 ₸ '),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  ListTile(
                    leading: Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          // print(isSwitched);
                        });
                      },
                      activeTrackColor: AppColors.kPrimaryColor,
                      activeColor: Colors.white,
                    ),
                    title: const Text('520 Бонусов'),
                    subtitle: const Text('Накоплено'),
                    // subtitle: Text('2 товара'),
                    trailing: const Text(
                      'Потратить',
                      style: TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  const ListTile(
                    title: Text('К оплате'),
                    // subtitle: Text('2 товара'),
                    trailing: Text('1 009 870 ₸ '),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  const ListTile(
                    title: Text('Способы оплаты'),
                    trailing: Text(
                      'Добавить новую карту',
                      style: TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 1.0, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              // fillColor: WidgetStateProperty.resolveWith(Colors.),
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                            const Text('Kaspi Gold'),
                          ],
                        ),
                        const Text(
                          '1 278 987 ₸ ',
                          style: TextStyle(
                              color: AppColors.kPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 1.0, right: 10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              // fillColor: WidgetStateProperty.resolveWith(Colors.),
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('В рассрочку'),
                                const SizedBox(
                                  height: 5,
                                ),
                                const InstallMentWidget(),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Text('Платеж в месяц:'),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      padding: const EdgeInsets.all(4),
                                      child: const Text(
                                        '336 957',
                                        style: TextStyle(
                                            color: AppColors.kGray900,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
