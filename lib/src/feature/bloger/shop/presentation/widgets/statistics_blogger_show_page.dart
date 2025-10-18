import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
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
  int _selectIndex = DateTime.now().month - 1;

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
    return Container(
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
      child: Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: Colors.transparent,
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
          Container(
              height: 268,
              padding: EdgeInsets.only(top: 60, left: 16, right: 16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
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
                          textAlign: TextAlign.center,
                          style: AppTextStyles.size18Weight600.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 28),
                  Container(
                    height: 126,
                    // width: 358,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${_total} ₽',
                          style: AppTextStyles.size29Weight700
                              .copyWith(color: Colors.white),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Сумма,которую вы заработали',
                          style: AppTextStyles.size16Weight400
                              .copyWith(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  )
                ],
              )),
          Container(
            height: 600,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => _showYearPickerBottomSheet(
                          context, selectedYear, (year) {
                        _summConfirm = 0;
                        _summFreeze = 0;
                        selectedYear = year;
                        setState(() {});
                        BlocProvider.of<ProfileMonthStaticsBloggerCubit>(
                                context)
                            .statics(
                          _selectIndex + 1,
                          selectedYear,
                        );
                      }),
                      child: Container(
                        width: 160,
                        height: 36,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            color: AppColors.kBackgroundColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '$selectedYear',
                              style: AppTextStyles.size14Weight500,
                            ),
                            Image.asset(
                              Assets.icons.dropDownIcon.path,
                              height: 16,
                              width: 16,
                              color: AppColors.kNeutralBlackColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
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
                      child: Container(
                        width: 160,
                        height: 36,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Color(0xffF7F7F7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              months[_selectIndex],
                              style: AppTextStyles.size14Weight500,
                            ),
                            Image.asset(
                              Assets.icons.dropDownIcon.path,
                              height: 16,
                              width: 16,
                              color: AppColors.kNeutralBlackColor,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BlocConsumer<ProfileMonthStaticsBloggerCubit,
                          ProfileMonthStaticsBloggerState>(
                        listener: (context, state) {
                          if (state is LoadedState) {
                            // ✅ пересчитали суммы "с нуля"
                            _total = state.loadedProfile.isNotEmpty
                                ? (state.loadedProfile.first.total ?? 0)
                                : 0;
                            _summConfirm = 0;
                            _summFreeze = 0;

                            for (final e in state.loadedProfile) {
                              if ((e.status ?? '') == 'CONFIRMED') {
                                _summConfirm += e.price ?? 0;
                              } else {
                                _summFreeze += e.price ?? 0;
                              }
                            }

                            setState(
                                () {}); // можно убрать и считать в builder, если хотите без setState здесь
                          }
                        },
                        builder: (context, state) {
                          if (state is LoadedState) {
                            return ListView.separated(
                              // 🔧 ключевые строки — превращаем внутренний список во "вкладываемый" виджет
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,

                              itemCount: state.loadedProfile.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final item = state.loadedProfile[index];

                                // Пустой список (id == 0) — показываем заглушку
                                if (item.id == 0) {
                                  return Center(
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 130),
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Image.asset(
                                              Assets.icons.emptyIcon.path,
                                              height: 72,
                                              width: 72),
                                          const SizedBox(height: 10),
                                          Text(
                                            'Список пока пуст',
                                            style: AppTextStyles.aboutTextStyle
                                                .copyWith(
                                                    color: AppColors.kGray300),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                // Обычная карточка
                                return Container(
                                  height: 148,
                                  width: double
                                      .infinity, // ❗ лучше не фиксировать 343 — пусть адаптируется
                                  margin: EdgeInsets.zero,
                                  padding: const EdgeInsets.only(
                                      top: 12, bottom: 10, left: 12, right: 12),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF7F7F7),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 88,
                                        width: 88,
                                        decoration: BoxDecoration(
                                          color: AppColors.kWhite,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              12), // Slightly smaller than container
                                          child: Image.network(
                                            item.path != null
                                                ? "https://lunamarket.ru/storage/${item.path}"
                                                : "https://lunamarket.ru/storage/banners/2.png",
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Container(
                                                color: Colors.grey[100],
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                    strokeWidth: 2,
                                                  ),
                                                ),
                                              );
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Container(
                                              color: Colors.grey[100],
                                              child: const Icon(
                                                  Icons.broken_image,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 16),
                                      // Контент справа
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Название
                                            Text(item.name ?? 'Без имени',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: AppTextStyles
                                                    .size14Weight500),
                                            const SizedBox(height: 5),
                                            // Магазин
                                            Row(
                                              children: [
                                                Text(
                                                  'Магазин: ',
                                                  style: AppTextStyles
                                                      .size14Weight400
                                                      .copyWith(
                                                    color: Color(0xff8E8E93),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      '${GetStorage().read('seller_name')} ',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppTextStyles
                                                          .size14Weight500),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            // Комиссия
                                            Row(
                                              children: [
                                                Text(
                                                  'Комиссия: ',
                                                  style: AppTextStyles
                                                      .size14Weight400
                                                      .copyWith(
                                                    color: Color(0xff8E8E93),
                                                  ),
                                                ),
                                                Text('${item.bonusPercent} %',
                                                    style: AppTextStyles
                                                        .size14Weight500),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            // Вознаграждение
                                            Row(
                                              children: [
                                                Text(
                                                  'Вознаграждение блогера: ',
                                                  style: AppTextStyles
                                                      .size14Weight400
                                                      .copyWith(
                                                    color: Color(0xff8E8E93),
                                                  ),
                                                ),
                                                Text('${item.bonus ?? '0'} %',
                                                    style: AppTextStyles
                                                        .size14Weight500),
                                              ],
                                            ),
                                            const SizedBox(height: 12),
                                            // Цена x Кол-во = Итого
                                            Row(
                                              children: [
                                                Text(' ${item.price ?? 0} ₽',
                                                    style: AppTextStyles
                                                        .size14Weight400),
                                                const SizedBox(width: 45),
                                                Text(
                                                  'x${item.count ?? 0}',
                                                  style: AppTextStyles
                                                      .size14Weight400
                                                      .copyWith(
                                                    color: Color(0xff8E8E93),
                                                  ),
                                                ),
                                                const SizedBox(width: 45),
                                                Text(
                                                  '= ${(item.price ?? 0) * (item.count ?? 0)} ₽',
                                                  style: AppTextStyles
                                                      .size14Weight600
                                                      .copyWith(
                                                          color: AppColors
                                                              .mainPurpleColor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }

                          if (state is LoadingState) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 40),
                              child: Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.indigoAccent)),
                            );
                          }

                          if (state is ErrorState) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child: Center(
                                  child: Text(state.message,
                                      style: const TextStyle(fontSize: 18))),
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      )
                    ]),
              ],
            ),
          ),
        ]),
      ),
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
