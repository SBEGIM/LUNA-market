import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/features/drawer/presentation/ui/products_page.dart';

import '../../../../core/common/constants.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

List<String> months = [
  'Январь',
  'Февраль',
  'Март',
  'Апрель',
  'Май',
];
List<String> monthsSecond = [
  'Июнь',
  'Июль',
  'Август',
  'Сентябрь',
  'Ноябрь',
  'Декабрь',
];

int _selectIndex = -1;
int _SelectSecondIndex = -1;

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
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Silver MacBook M1 13.1in. Apple\n256GB',
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
              SizedBox(
                height: 50,
                width: 500,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: months.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _selectIndex = index;
                        setState(() {
                          _selectIndex;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 4, left: 4, right: 4),
                        child: chipDate(
                          months[index],
                          index,
                          _selectIndex,
                        ),
                      ),

                      // GestureDetector(
                      //   child: chipDate('Январь', false),
                      // ),
                      // chipDate('Февраль', false),
                      // chipDate('Март', false),
                      // chipDate('Апрель', false),
                      // chipDate('Май', false),
                      // chipDate('Июнь', false),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 50,
                width: 500,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: monthsSecond.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _SelectSecondIndex = index;
                        setState(() {
                          _SelectSecondIndex;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 4, left: 4, right: 4),
                        child: chipDate(
                          monthsSecond[index],
                          index,
                          _SelectSecondIndex,
                        ),
                        // GestureDetector(
                        //   child: chipDate('Январь', false),
                        // ),
                        // chipDate('Февраль', false),
                        // chipDate('Март', false),
                        // chipDate('Апрель', false),
                        // chipDate('Май', false),
                        // chipDate('Июнь', false),
                      ),
                    );
                  },
                ),
              ),
              // SingleChildScrollView(
              //     scrollDirection: Axis.horizontal,
              //     child: Padding(
              //       padding: const EdgeInsets.only(bottom: 8),
              //       child: Wrap(
              //         spacing: 6,
              //         runSpacing: 6,
              //         children: [
              //           chipDate('Июль', true),
              //           chipDate('Август', false),
              //           chipDate('Сентябрь', false),
              //           chipDate('Октябрь', false),
              //           chipDate('Ноябрь', false),
              //           chipDate('Декабрь', false),
              //         ],
              //       ),
              //     )),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  StatisticWidgetContainer(
                    text: '129',
                    subText: 'Количество кликов',
                    url: 'assets/icons/click1.svg',
                  ),
                  StatisticWidgetContainer(
                    text: '110',
                    subText: 'Добавлен в\nизбранное',
                    url: 'assets/icons/click2.svg',
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
                    url: 'assets/icons/click3.svg',
                  ),
                  StatisticWidgetContainer(
                    text: '129',
                    subText: 'Количество покупок',
                    url: 'assets/icons/click4.svg',
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
  final String url;
  const StatisticWidgetContainer({
    required this.text,
    required this.subText,
    required this.url,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168,
      height: 156,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            // blurRadius: 1,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            url,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            text,
            style: const TextStyle(
                color: AppColors.kGray900,
                fontSize: 24,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 4,
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
