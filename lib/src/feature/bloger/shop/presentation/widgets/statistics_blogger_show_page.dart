import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/bloger/profile/bloc/profile_month_statics_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/profile/bloc/profile_month_statics_blogger_state.dart';
import '../../../../../core/common/constants.dart';

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
    'Октябрь',
    'Ноябрь',
    'Декабрь',
  ];
  int selectedYear = 2025;
  int _selectIndex = 0;
  int _summConfirm = 0;
  int _summFreeze = 0;

  int _total = 0;

  Function? summPrice;

  @override
  void initState() {
    BlocProvider.of<ProfileMonthStaticsBloggerCubit>(context)
        .statics(1, selectedYear);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      // appBar: AppBar(
      //     iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
      //     backgroundColor: Colors.white,
      //     elevation: 0,
      //     centerTitle: true,
      //     title: const Text(
      //       'Мой заработок',
      //       style: TextStyle(
      //         color: Colors.black,
      //       ),
      //     )),
      body: ListView(shrinkWrap: true, padding: EdgeInsets.zero, children: [
        Stack(
          children: [
            Container(
                height: 258,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-0.75, -1),
                    end: Alignment(1, 1),
                    colors: [
                      Color(0xFF7D2DFF),
                      Color(0xFF41DDFF),
                    ],
                    stops: [0.2685, 1.0],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 105),
                          Text(
                            'Мой заработок',
                            style:
                                AppTextStyles.defaultButtonTextStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 126,
                        width: 358,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 6.5),
                            Text(
                              '${_total} ₽',
                              style: AppTextStyles.defaultButtonTextStyle
                                  .copyWith(
                                      color: Colors.white,
                                      fontFamily: 'SFProDisplay'),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Сумма,которую вы заработали',
                              style: AppTextStyles.defaultButtonTextStyle
                                  .copyWith(
                                      color: Colors.white,
                                      fontFamily: 'SFProDisplay'),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              // color: Colors.white,
              margin: const EdgeInsets.only(top: 230),
              padding: const EdgeInsets.all(16),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 160,
                        height: 36,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: AppColors.kBackgroundColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: GestureDetector(
                          onTap: () => _showYearPickerBottomSheet(
                              context, selectedYear, (year) {
                            print(year);
                            setState(() {
                              selectedYear = year;
                            });
                          }),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$selectedYear',
                                style: const TextStyle(
                                  color: AppColors.kGray900,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 160,
                        height: 36,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.kBackgroundColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            _showMonthPickerBottomSheet(context, _selectIndex,
                                (int selectedIndex) {
                              _selectIndex = selectedIndex;
                              _summConfirm = 0;
                              _summFreeze = 0;

                              setState(() {}); // достаточно одного вызова

                              BlocProvider.of<ProfileMonthStaticsBloggerCubit>(
                                      context)
                                  .statics(
                                _selectIndex + 1,
                                selectedYear,
                              );
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                months[_selectIndex],
                                style: const TextStyle(
                                  color: AppColors.kGray900,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.kGray900,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BlocConsumer<ProfileMonthStaticsBloggerCubit,
                              ProfileMonthStaticsBloggerState>(
                            listener: (context, state) {
                              // if (state is LoadedState) {}
                              if (state is LoadedState) {
                                _total = state.loadedProfile.first.total ?? 0;

                                state.loadedProfile.map((e) {
                                  if (e.status == 'CONFIRMED') {
                                    _summConfirm += e.price ?? 0;
                                  } else {
                                    _summFreeze += e.price ?? 0;
                                  }
                                }).toList();
                              }
                              setState(() {});
                            },
                            builder: (context, state) {
                              if (state is LoadedState) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 1.9,
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: state.loadedProfile.length,
                                      itemBuilder: (context, index) {
                                        _total =
                                            state.loadedProfile[index].total ??
                                                0;

                                        return state.loadedProfile[index].id ==
                                                0
                                            ? Center(
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 130),
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    children: [
                                                      Image.asset(
                                                        Assets.icons.emptyIcon
                                                            .path,
                                                        height: 72,
                                                        width: 72,
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        'Список пока пуст',
                                                        style: AppTextStyles
                                                            .aboutTextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .kGray300),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                height: 148,
                                                width: 343,
                                                margin: EdgeInsets.only(top: 0),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 16,
                                                          bottom: 10,
                                                          left: 10,
                                                          right: 20),
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .kBackgroundColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 88,
                                                        width: 88,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              AppColors.kWhite,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                        child: Center(
                                                          child: Image.network(
                                                            'https://lunamarket.ru/storage/${state.loadedProfile[index].path}',
                                                            height: 72,
                                                            width: 72,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 16,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: 200,
                                                            child: Text(
                                                              state
                                                                      .loadedProfile[
                                                                          index]
                                                                      .name ??
                                                                  '',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                              style: AppTextStyles
                                                                  .kcolorPrimaryTextStyle
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .kLightBlackColor),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'Магазин: ',
                                                                style: AppTextStyles
                                                                    .drawer2TextStyle
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .kGray300,
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            'SFProDisplay'),
                                                              ),
                                                              Text(
                                                                '${GetStorage().read('seller_name')} ',
                                                                style: AppTextStyles
                                                                    .drawer2TextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            'SFProDisplay'),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'Комиссия: ',
                                                                style: AppTextStyles
                                                                    .drawer2TextStyle
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .kGray300,
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            'SFProDisplay'),
                                                              ),
                                                              Text(
                                                                '${state.loadedProfile[index].bonusPercent} %',
                                                                style: AppTextStyles
                                                                    .drawer2TextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            'SFProDisplay'),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                'Вознаграждение блогера: ',
                                                                style: AppTextStyles.drawer2TextStyle.copyWith(
                                                                    color: AppColors
                                                                        .kGray300,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300,
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'SFProDisplay'),
                                                              ),
                                                              Text(
                                                                '${state.loadedProfile[index].bonus ?? '0'} %',
                                                                style: AppTextStyles
                                                                    .drawer2TextStyle
                                                                    .copyWith(
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            'SFProDisplay'),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 5),
                                                          Row(
                                                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              Text(
                                                                ' ${state.loadedProfile[index].price.toString()}₽',
                                                                style: AppTextStyles
                                                                    .statisticsTextStyle,
                                                              ),
                                                              const SizedBox(
                                                                  width: 45),
                                                              Text(
                                                                  'x${state.loadedProfile[index].count.toString()}',
                                                                  style: AppTextStyles
                                                                      .statisticsTextStyle
                                                                      .copyWith(
                                                                          color:
                                                                              AppColors.kGray200)),
                                                              const SizedBox(
                                                                  width: 45),
                                                              Text(
                                                                  '= ${(state.loadedProfile[index].price! * state.loadedProfile[index].count!)} ₽',
                                                                  style: AppTextStyles
                                                                      .statisticsTextStyle
                                                                      .copyWith(
                                                                          color:
                                                                              AppColors.mainPurpleColor)),
                                                            ],
                                                          )
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
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ]),
    );
  }
}

void _showMonthPickerBottomSheet(
  BuildContext context,
  int initialSelectedMonth,
  Function(int) onMonthSelected,
) {
  final List<String> months = [
    'Январь',
    'Февраль',
    'Март',
    'Апрель',
    'Май',
    'Июнь',
    'Июль',
    'Август',
    'Сентябрь',
    'Октябрь',
    'Ноябрь',
    'Декабрь'
  ];

  final FixedExtentScrollController scrollController =
      FixedExtentScrollController(
    initialItem: initialSelectedMonth,
  );

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      int selectedMonth = initialSelectedMonth;

      return StatefulBuilder(
        builder: (context, setModalState) {
          return SizedBox(
            height: 300,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Выберите месяц',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kGray900,
                    ),
                  ),
                ),
                Expanded(
                  child: ListWheelScrollView.useDelegate(
                    controller: scrollController,
                    itemExtent: 50,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      setModalState(() {
                        selectedMonth = index;
                      });
                      onMonthSelected(index);
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        if (index < 0 || index >= months.length) return null;
                        final isSelected = index == selectedMonth;
                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.kGray2
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 24),
                            child: Text(
                              months[index],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected
                                    ? AppColors.mainBackgroundPurpleColor
                                    : AppColors.kGray900,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

void _showYearPickerBottomSheet(
  BuildContext context,
  int initialSelectedYear,
  void Function(int) onYearSelected,
) {
  final List<int> years =
      List.generate(50, (index) => DateTime.now().year - index);
  final FixedExtentScrollController scrollController =
      FixedExtentScrollController(
    initialItem: years.indexOf(initialSelectedYear),
  );

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      int selectedYear =
          initialSelectedYear; // Локальный selectedYear для обновления в билдере

      return StatefulBuilder(
        builder: (context, setModalState) {
          return SizedBox(
            height: 300,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Выберите год',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kGray900,
                    ),
                  ),
                ),
                Expanded(
                  child: ListWheelScrollView.useDelegate(
                    controller: scrollController,
                    itemExtent: 50,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      setModalState(() {
                        selectedYear = years[index];
                      });
                      onYearSelected(years[index]);
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        if (index < 0 || index >= years.length) return null;
                        final year = years[index];
                        final isSelected = year == selectedYear;

                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.kGray2
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 24),
                            child: Text(
                              '$year',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: isSelected
                                    ? AppColors.kGray900
                                    : AppColors.kGray700,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
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
