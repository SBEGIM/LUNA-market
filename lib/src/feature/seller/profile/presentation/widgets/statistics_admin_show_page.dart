import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:haji_market/src/feature/seller/profile/data/bloc/profile_month_statics_admin_cubit.dart';
import 'package:haji_market/src/feature/seller/profile/data/bloc/profile_month_statics_admin_state.dart';
import '../../../../../core/common/constants.dart';

class StatisticsAdminShowPage extends StatefulWidget {
  const StatisticsAdminShowPage({Key? key}) : super(key: key);

  @override
  State<StatisticsAdminShowPage> createState() =>
      _StatisticsAdminShowPageState();
}

class _StatisticsAdminShowPageState extends State<StatisticsAdminShowPage> {
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
  int year = 2025;
  int selectedYear = 2025;

  int _selectIndex = 0;
  int _summConfirm = 0;
  int _summFreeze = 0;

  int _total = 0;

  Function? summPrice;

  @override
  void initState() {
    BlocProvider.of<ProfileMonthStaticsAdminCubit>(context).statics(year, 1);

    super.initState();
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
                height: 240,
                width: double.infinity,
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
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          height: 24,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Image.asset(
                                    Assets.icons.defaultBackIcon.path,
                                    height: 24,
                                    width: 24,
                                    scale: 1.9,
                                    color: AppColors.kWhite,
                                  ),
                                ),
                              ),
                              Text(
                                'Аналитика продаж',
                                style: AppTextStyles.size18Weight600
                                    .copyWith(color: AppColors.kWhite),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 28),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16)),
                                child: Column(
                                  children: [
                                    SizedBox(height: 12.5),
                                    Image.asset(
                                      Assets.icons.moneyIcon.path,
                                      height: 16.5,
                                      width: 22.5,
                                    ),
                                    SizedBox(height: 6.5),
                                    Text(
                                      '$_summConfirm ₽',
                                      style: AppTextStyles.appBarTextStylea
                                          .copyWith(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'SFProDisplay'),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'Мой заработок',
                                      style: AppTextStyles.bannerTextStyle,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16)),
                                child: Column(
                                  children: [
                                    SizedBox(height: 12.5),
                                    Image.asset(
                                      Assets.icons.lock.path,
                                      height: 16.5,
                                      width: 22.5,
                                    ),
                                    SizedBox(height: 6.5),
                                    Text(
                                      '$_summFreeze ₽',
                                      style: AppTextStyles.appBarTextStylea
                                          .copyWith(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'SFProDisplay'),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'В заморозке',
                                      style: AppTextStyles.bannerTextStyle,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 4),
                            Expanded(
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16)),
                                child: Column(
                                  children: [
                                    SizedBox(height: 12.5),
                                    Image.asset(
                                      Assets.icons.sumMoney.path,
                                      height: 16.5,
                                      width: 22.5,
                                    ),
                                    SizedBox(height: 6.5),
                                    Text(
                                      '$_total ₽',
                                      style: AppTextStyles.appBarTextStylea
                                          .copyWith(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'SFProDisplay'),
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      'Заработок за год',
                                      style: AppTextStyles.bannerTextStyle,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              // color: Colors.white,
              margin: const EdgeInsets.only(top: 210),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 175,
                        height: 36,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
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
                              Text('$selectedYear',
                                  style: AppTextStyles.size14Weight500),
                              Image.asset(
                                Assets.icons.dropDownIcon.path,
                                width: 12,
                                height: 6,
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 175,
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

                              BlocProvider.of<ProfileMonthStaticsAdminCubit>(
                                      context)
                                  .statics(
                                year,
                                _selectIndex + 1,
                              );
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(months[_selectIndex],
                                  style: AppTextStyles.size14Weight500),
                              Image.asset(
                                Assets.icons.dropDownIcon.path,
                                width: 12,
                                height: 6,
                              )
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
                        children: [
                          BlocConsumer<ProfileMonthStaticsAdminCubit,
                              ProfileMonthStaticsAdminState>(
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
                                                margin:
                                                    EdgeInsets.only(top: 10),
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
                                                                'Вознаградение блогера: ',
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
                                                                '${state.loadedProfile[index].pointBlogger ?? '0'} %',
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

  // Текущий месяц (индекс с 0)
  final int currentMonthIndex = DateTime.now().month - 1;

  final FixedExtentScrollController scrollController =
      FixedExtentScrollController(
    initialItem: initialSelectedMonth ?? currentMonthIndex,
  );

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Color(0xffF7F7F7),
    builder: (context) {
      int selectedMonth = initialSelectedMonth;

      return StatefulBuilder(
        builder: (context, setModalState) {
          return SizedBox(
            height: 402,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Выберите месяц',
                        style: AppTextStyles.size16Weight500,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(
                          Assets.icons.defaultCloseIcon.path,
                          scale: 1.9,
                          width: 24,
                          height: 24,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 326,
                    height: 212,
                    decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(16)),
                    child: ListWheelScrollView.useDelegate(
                      controller: scrollController,
                      itemExtent: 50,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        setModalState(() {
                          selectedMonth = index;
                        });
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          if (index < 0 || index >= months.length) return null;
                          final month = months[index];
                          final isSelected = index == selectedMonth;

                          return Container(
                            height: 36,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Color(0xffEAECED)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('$month',
                                style: AppTextStyles.size20Weight500.copyWith(
                                  color: isSelected
                                      ? AppColors.kGray900
                                      : Color(0xff8E8E93),
                                )),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16, top: 16, bottom: 50),
                  child: DefaultButton(
                      text: 'Выбрать',
                      press: () {
                        onMonthSelected(selectedMonth);

                        Navigator.of(context).pop();
                      },
                      color: AppColors.kWhite,
                      backgroundColor: AppColors.mainPurpleColor,
                      width: double.infinity),
                )
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
  const int baseYear = 2025;
  final List<int> years = List.generate(21, (index) => (baseYear + 5) - index);

  final int initialIndex = years.indexOf(initialSelectedYear);
  final FixedExtentScrollController scrollController =
      FixedExtentScrollController(
    initialItem:
        initialIndex == -1 ? 0 : initialIndex, // фолбэк, если года нет в списке
  );

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Color(0xffF7F7F7),
    builder: (context) {
      int selectedYear =
          initialSelectedYear; // Локальный selectedYear для обновления в билдере

      return StatefulBuilder(
        builder: (context, setModalState) {
          return SizedBox(
            height: 402,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Выберите год',
                        style: AppTextStyles.size16Weight500,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(
                          Assets.icons.defaultCloseIcon.path,
                          scale: 1.9,
                          width: 24,
                          height: 24,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 326,
                    height: 212,
                    decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(16)),
                    child: ListWheelScrollView.useDelegate(
                      controller: scrollController,
                      itemExtent: 50,
                      physics: const FixedExtentScrollPhysics(),
                      onSelectedItemChanged: (index) {
                        setModalState(() {
                          selectedYear = years[index];
                        });
                      },
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          if (index < 0 || index >= years.length) return null;
                          final year = years[index];
                          final isSelected = year == selectedYear;

                          return Container(
                            height: 36,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Color(0xffEAECED)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 24),
                            child: Text('$year',
                                style: AppTextStyles.size20Weight500.copyWith(
                                  color: isSelected
                                      ? AppColors.kGray900
                                      : Color(0xff8E8E93),
                                )),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16, top: 16, bottom: 50),
                  child: DefaultButton(
                      text: 'Выбрать',
                      press: () {
                        onYearSelected(selectedYear);

                        Navigator.of(context).pop();
                      },
                      color: AppColors.kWhite,
                      backgroundColor: AppColors.mainPurpleColor,
                      width: double.infinity),
                )
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
