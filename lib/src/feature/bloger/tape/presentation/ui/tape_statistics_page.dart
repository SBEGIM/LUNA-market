import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:haji_market/src/feature/bloger/tape/data/model/tape_blogger_model.dart';

class TapeStatisticsPage extends StatefulWidget {
  final TapeBloggerModel tape;

  const TapeStatisticsPage({required this.tape, super.key});

  @override
  State<TapeStatisticsPage> createState() => _TapeStatisticsPageState();
}

class _TapeStatisticsPageState extends State<TapeStatisticsPage> {
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
  int _selectIndex = 0;
  int _summConfirm = 0;
  int _summFreeze = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        surfaceTintColor: AppColors.kWhite,
        backgroundColor: AppColors.kWhite,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Image.asset(Assets.icons.defaultBackIcon.path, scale: 1.9, width: 18, height: 14),
        ),
        centerTitle: true,
        title:
            //  Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(5),
            //   child: Image.network(
            //     'https://lunamarket.ru/storage/}',
            //     height: 30.6,
            //     width: 30.6,
            //     errorBuilder: (context, error, stackTrace) =>
            //         const ErrorImageWidget(
            //       height: 30.6,
            //       width: 30.6,
            //     ),
            //   ),
            // ),
            //  SizedBox(width: 10),
            Text('Статистика', style: AppTextStyles.size18Weight600),
        // ],
        // ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 130,
            margin: EdgeInsets.only(top: 12, left: 16, right: 16),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 114,
                  width: 120,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  child: Image.network(
                    'https://lunamarket.ru/storage/${widget.tape.image}',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const ErrorImageWidget(height: 114, width: 120),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        '${widget.tape.catName}',
                        style: AppTextStyles.size13Weight400.copyWith(color: Color(0xFF8E8E93)),
                      ),
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      width: 180,
                      child: Text(
                        '${widget.tape.name}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.size14Weight600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'Артикул: ',
                          style: AppTextStyles.size14Weight600.copyWith(color: Color(0xFF8E8E93)),
                        ),
                        Text('${widget.tape.id}', style: AppTextStyles.size14Weight500),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'Дата добавления: ',
                          style: AppTextStyles.size14Weight600.copyWith(color: Color(0xFF8E8E93)),
                        ),
                        Text(
                          '${widget.tape.shop?.createdAt}',
                          style: AppTextStyles.size14Weight500,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color: AppColors.kWhite,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => _showYearPickerBottomSheet(context, year, (value) {
                            year = value;
                            setState(() {});
                          }),
                          child: Container(
                            width: 160,
                            height: 36,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('$year', style: AppTextStyles.size14Weight500),
                                Image.asset(Assets.icons.dropDownIcon.path, height: 6, width: 12),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showMonthPickerBottomSheet(context, _selectIndex, (int selectedIndex) {
                              _selectIndex = selectedIndex;
                              _summConfirm = 0;
                              _summFreeze = 0;

                              setState(() {}); // достаточно одного вызова

                              //   BlocProvider.of<ProfileMonthStaticsBloggerCubit>(context)
                              //       .statics(
                              //     _selectIndex + 1,
                              //     year,
                              //   );
                              // });
                            });
                          },
                          child: Container(
                            width: 160,
                            height: 36,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(months[_selectIndex], style: AppTextStyles.size14Weight500),
                                Image.asset(Assets.icons.dropDownIcon.path, height: 6, width: 12),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          StatisticTile(
                            value: '10%',
                            label: 'Вознаграждение',
                            icon: Assets.icons.statisticsBasket.path,
                          ),
                          const SizedBox(height: 12),
                          StatisticTile(
                            value: '${widget.tape.price} руб',
                            label: 'Мой заработок',
                            icon: Assets.icons.statisticsBonus.path,
                          ),
                          const SizedBox(height: 12),
                          StatisticTile(
                            value: '${widget.tape.viewCount}',
                            label: 'Количество кликов',
                            icon: Assets.icons.statisticsClick.path,
                          ),
                          const SizedBox(height: 12),
                          StatisticTile(
                            value: '${widget.tape.statistics?.favorite ?? 0}',
                            label: 'Добавлен в избранное',
                            icon: Assets.icons.statisticsFavorite.path,
                          ),
                          const SizedBox(height: 12),
                          StatisticTile(
                            value: '${widget.tape.basketCount}',
                            label: 'Добавлен в корзину',
                            icon: Assets.icons.statisticsBasket.path,
                          ),
                          const SizedBox(height: 12),
                          StatisticTile(
                            value: '${widget.tape.statistics?.like ?? 0}',
                            label: 'Количество покупок',
                            icon: Assets.icons.statisticsBasket.path,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
    'Декабрь',
  ];

  final FixedExtentScrollController scrollController = FixedExtentScrollController(
    initialItem: initialSelectedMonth,
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
                      Text('Выберите месяц', style: AppTextStyles.size16Weight500),
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
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 326,
                    height: 212,
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(16),
                    ),
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
                              color: isSelected ? Color(0xffEAECED) : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '$month',
                              style: AppTextStyles.size20Weight500.copyWith(
                                color: isSelected ? AppColors.kGray900 : Color(0xff8E8E93),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 50),
                  child: DefaultButton(
                    text: 'Выбрать',
                    press: () {
                      onMonthSelected(selectedMonth);

                      Navigator.of(context).pop();
                    },
                    color: AppColors.kWhite,
                    backgroundColor: AppColors.mainPurpleColor,
                    width: double.infinity,
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
  final List<int> years = List.generate(50, (index) => DateTime.now().year - index);
  final FixedExtentScrollController scrollController = FixedExtentScrollController(
    initialItem: years.indexOf(initialSelectedYear),
  );

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Color(0xffF7F7F7),
    builder: (context) {
      int selectedYear = initialSelectedYear; // Локальный selectedYear для обновления в билдере

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
                      Text('Выберите год', style: AppTextStyles.size16Weight500),
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
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 326,
                    height: 212,
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(16),
                    ),
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
                              color: isSelected ? Color(0xffEAECED) : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                            child: Text(
                              '$year',
                              style: AppTextStyles.size20Weight500.copyWith(
                                color: isSelected ? AppColors.kGray900 : Color(0xff8E8E93),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16, bottom: 50),
                  child: DefaultButton(
                    text: 'Выбрать',
                    press: () {
                      onYearSelected(selectedYear);

                      Navigator.of(context).pop();
                    },
                    color: AppColors.kWhite,
                    backgroundColor: AppColors.mainPurpleColor,
                    width: double.infinity,
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

class StatisticTile extends StatelessWidget {
  final String value;
  final String label;
  final String icon;

  const StatisticTile({super.key, required this.value, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.mainPurpleColor.withOpacity(0.1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 12),
          Image.asset(icon, height: 44, width: 44),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: AppTextStyles.size18Weight600),
              const SizedBox(height: 2),
              Text(
                label,
                style: AppTextStyles.size13Weight400.copyWith(color: const Color(0xFF8E8E93)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
