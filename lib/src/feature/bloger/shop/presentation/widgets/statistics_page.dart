import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/feature/bloger/shop/bloc/blogger_product_statistics_state.dart';
import 'package:haji_market/src/feature/product/presentation/widgets/chip_date_widget.dart';

import '../../../../../core/common/constants.dart';
import '../../bloc/blogger_product_statistics_cubit.dart';
import '../../data/models/blogger_shop_products_model.dart';

class StatisticsBloggerPage extends StatefulWidget {
  final BloggerShopProductModel product;
  const StatisticsBloggerPage({required this.product, Key? key})
      : super(key: key);

  @override
  State<StatisticsBloggerPage> createState() => _StatisticsBloggerPagetate();
}

class _StatisticsBloggerPagetate extends State<StatisticsBloggerPage> {
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

  @override
  void initState() {
    BlocProvider.of<BloggerProductStatisticsCubit>(context).statistics();
    super.initState();
  }

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
        body: BlocConsumer<BloggerProductStatisticsCubit,
                BloggerProductStatisticsState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is LoadedState) {
                return ListView(shrinkWrap: true, children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 16, bottom: 16, left: 15, right: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Image.asset('assets/images/mac.png'),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.product.name}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: AppColors.kGray900,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Артикул: ${widget.product.id}',
                                style: const TextStyle(
                                    color: AppColors.kGray900,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // Text(
                              //   'Дата добавления:${widget.product.}',
                              //   style: TextStyle(
                              //       color: AppColors.kGray900,
                              //       fontSize: 12,
                              //       fontWeight: FontWeight.w500),
                              // )
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
                                    BlocProvider.of<
                                                BloggerProductStatisticsCubit>(
                                            context)
                                        .statistics();

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
                                    BlocProvider.of<
                                                BloggerProductStatisticsCubit>(
                                            context)
                                        .statistics();

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
                            children: [
                              StatisticWidgetContainer(
                                text: state.statistics.clickCount.toString(),
                                subText: 'Количество кликов',
                                url: 'assets/icons/click1.svg',
                                png: false,
                              ),
                              StatisticWidgetContainer(
                                text: state.statistics.favoriteCount.toString(),
                                subText: 'Добавлен в\nизбранное',
                                url: 'assets/icons/click2.svg',
                                png: false,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StatisticWidgetContainer(
                                text: state.statistics.basketCount.toString(),
                                subText: 'Добавлен в корзину ',
                                url: 'assets/icons/click3.svg',
                                png: false,
                              ),
                              StatisticWidgetContainer(
                                text: state.statistics.buyCount.toString(),
                                subText: 'Количество покупок',
                                url: 'assets/icons/click4.svg',
                                png: false,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StatisticWidgetContainer(
                                text: "${state.statistics.bonus.toString()}%",
                                subText: 'Вознаграждение ',
                                url: 'assets/icons/2.png',
                                png: true,
                              ),
                              StatisticWidgetContainer(
                                text: state.statistics.sumPrice.toString(),
                                subText: 'Мой заработок',
                                url: 'assets/icons/3.png',
                                png: true,
                              ),
                            ],
                          )
                        ],
                      )),
                ]);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}

class StatisticWidgetContainer extends StatelessWidget {
  final String text;
  final String subText;
  final String url;
  final bool? png;
  const StatisticWidgetContainer({
    required this.text,
    required this.subText,
    required this.url,
    required this.png,
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
          png == false
              ? SvgPicture.asset(
                  url,
                  // color: AppColors.kPrimaryColor,
                )
              : Image.asset(url),
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
