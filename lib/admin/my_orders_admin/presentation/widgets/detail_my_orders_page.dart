import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';

import '../../../../features/app/widgets/custom_back_button.dart';

class DetailMyOrdersPage extends StatefulWidget {
  DetailMyOrdersPage({Key? key}) : super(key: key);

  @override
  State<DetailMyOrdersPage> createState() => _DetailMyOrdersPageState();
}

class _DetailMyOrdersPageState extends State<DetailMyOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '№1920-293',
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
                itemCount: 2,
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
                        leading: Image.asset(
                          'assets/images/mac.png',
                          fit: BoxFit.cover,
                          height: 104,
                          width: 104,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Silver MacBook M1 13.1in. Apple 256GB',
                              style: TextStyle(
                                  color: AppColors.kGray900,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: const [
                                Text(
                                  '556 900 ₸',
                                  style: TextStyle(
                                      color: AppColors.kGray900,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '1x',
                                  style: TextStyle(
                                      color: AppColors.kPrimaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              'Продавец: Sulpak',
                              style: TextStyle(
                                  color: AppColors.kGray900,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
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
                      child: const Text('Товар у продавца'),
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
                  children: const [
                    Text(
                      'Сумма без доставки ',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '1 009 870 ₸ ',
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
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Доставка',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '1 009 870 ₸ ',
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
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Сумма покупки ',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '1 009 870 ₸ ',
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
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Оплата бонусами  ',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '1 009 870 ₸ ',
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
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
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
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
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
              const ListTile(
                leading: Icon(
                  Icons.map_outlined,
                  color: AppColors.kPrimaryColor,
                ),
                minLeadingWidth: 12,
                title: Text(
                  'Алматы, улица Байзакова, 280',
                  style: TextStyle(
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
                    Image.asset(
                      'assets/images/kana.png',
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      'Қанат Тұрғанбай',
                      style: TextStyle(
                          color: AppColors.kGray700,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(
                    13,
                  ),
                  child: const Text(
                    'Управление заказами',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(
                    13,
                  ),
                  child: const Text(
                    'Обработка заказов',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
