import 'package:flutter/material.dart';
import 'package:haji_market/features/drawer/presentation/ui/products_page.dart';

import '../../../../core/common/constants.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
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
            'Статистика',
            style: TextStyle(
              color: Colors.black,
            ),
          )),
      body: ListView(shrinkWrap: true, children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding:
                const EdgeInsets.only(top: 16, bottom: 16, left: 15, right: 5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Image.asset('assets/images/mac.png'),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Silver MacBook M1 13.1in. Apple 256GB',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Артикул: 1920983974',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Дата добавления:',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Месяцы',
                style: TextStyle(
                    color: AppColors.kGray900,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        chipDate(
                          'Январь',
                        ),
                        chipDate(
                          'Февраль',
                        ),
                        chipDate(
                          'Март',
                        ),
                        chipDate(
                          'Апрель',
                        ),
                        chipDate(
                          'Май',
                        ),
                        chipDate(
                          'Июнь',
                        ),
                      ],
                    ),
                  )),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        chipDate(
                          'Июль',
                        ),
                        chipDate(
                          'Август',
                        ),
                        chipDate(
                          'Сентябрь',
                        ),
                        chipDate(
                          'Октябрь',
                        ),
                        chipDate(
                          'Ноябрь',
                        ),
                        chipDate(
                          'Декабрь',
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  StatisticWidgetContainer(
                    text: '129',
                    subText: 'Количество кликов',
                  ),
                  StatisticWidgetContainer(
                    text: '110',
                    subText: 'Добавлен в избранное',
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  StatisticWidgetContainer(
                    text: '110',
                    subText: 'Добавлен в корзину ',
                  ),
                  StatisticWidgetContainer(
                    text: '129',
                    subText: 'Количество покупок',
                  )
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}

class StatisticWidgetContainer extends StatelessWidget {
  final String text;
  final String subText;
  const StatisticWidgetContainer({
    required this.text,
    required this.subText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 12,
            color: Color.fromRGBO(0, 0, 0, 0.08),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/temp/tape1.png',
            width: 44,
            height: 44,
          ),
          Text(
            text,
            style: const TextStyle(
                color: AppColors.kGray900,
                fontSize: 24,
                fontWeight: FontWeight.w700),
          ),
          Text(
            subText,
            style: const TextStyle(
                color: AppColors.kGray900,
                fontSize: 14,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
