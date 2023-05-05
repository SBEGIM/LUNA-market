import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/features/drawer/presentation/ui/products_page.dart';

import '../../../../core/common/constants.dart';
import '../../../profile_admin/presentation/data/bloc/profile_month_statics_blogger_cubit.dart';
import '../../../profile_admin/presentation/data/bloc/profile_month_statics_blogger_state.dart';

class StatisticsBloggerShowPage extends StatefulWidget {
  const StatisticsBloggerShowPage({Key? key}) : super(key: key);

  @override
  State<StatisticsBloggerShowPage> createState() =>
      _StatisticsBloggerShowPageState();
}

class _StatisticsBloggerShowPageState extends State<StatisticsBloggerShowPage> {
  List<String> months = [
    'Январь',
    'Февраль',
    'Март',
    'Апрель',
    'Май',
    'Июнь',
    'Июль',
    'Август',
    'Сентябрь',
    'Ноябрь',
    'Декабрь',
  ];
  int year = 2023;
  int _selectIndex = -1;
  final int _SelectSecondIndex = -1;
  int _summBonus = 0;

  incrementSumm(int Bonus) {
    _summBonus += Bonus;
  }

  @override
  void initState() {
    BlocProvider.of<ProfileMonthStaticsBloggerCubit>(context).statics();
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
      body: ListView(shrinkWrap: true, children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          // color: Colors.white,
          padding: const EdgeInsets.all(16),

          child: Row(
            children: [
              const Text(
                'Год',
                style: TextStyle(
                    color: AppColors.kGray900,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              const SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () {
                  year--;
                  setState(() {});
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 15.0,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                '$year',
                style: TextStyle(
                    color: AppColors.kGray900,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              const SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  year++;
                  setState(() {});
                },
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 15.0,
                ),
              ),
            ],
          ),
        ),
        Container(
          // color: Colors.white,
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      BlocProvider.of<ProfileMonthStaticsBloggerCubit>(context)
                          .statics();

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

            BlocConsumer<ProfileMonthStaticsBloggerCubit,
                ProfileMonthStaticsBloggerState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is LoadedState) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 2.3,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: state.loadedProfile.length,
                        itemBuilder: (context, index) {
                          incrementSumm(
                              state.loadedProfile[index].bonus!.toInt());
                          // setState(() {
                          //   _summBonus;
                          // });

                          return Container(
                            height: 80,
                            width: 343,
                            margin: const EdgeInsets.only(top: 10),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 16, bottom: 10, left: 10, right: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  SizedBox(
                                      height: 60,
                                      width: 60,
                                      child:
                                          Image.asset('assets/images/mac.png')),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.loadedProfile[index].name
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: AppColors.kGray900,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        'Магазин: Sulpak',
                                        style: TextStyle(
                                            color: AppColors.kGray900,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),

                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            state.loadedProfile[index].price
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          const SizedBox(width: 45),
                                          Text(
                                              'x${state.loadedProfile[index].count.toString()}',
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400)),
                                          const SizedBox(width: 45),
                                          Text(
                                              '${state.loadedProfile[index].bonusPercent.toString()} %',
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400)),
                                          const SizedBox(width: 45),
                                          Text(
                                              '${state.loadedProfile[index].bonus.toString()}тг',
                                              style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400)),
                                        ],
                                      )
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
                          );
                        }),
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: Colors.indigoAccent));
                }
              },
            ),

            Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Мой заработок',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  Text('$_summBonus тг',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400)),
                ],
              ),
            )
          ]),
        ),
      ]),
    );
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
