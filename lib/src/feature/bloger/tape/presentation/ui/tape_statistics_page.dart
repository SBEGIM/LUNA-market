import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
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
            child: Image.asset(
              Assets.icons.defaultBackIcon.path,
              scale: 1.9,
              width: 18,
              height: 14,
            )),
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
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 114,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.network(
                    'https://lunamarket.ru/storage/${widget.tape.image}',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const ErrorImageWidget(
                      height: 114,
                      width: 120,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        '${widget.tape.catName}',
                        style: AppTextStyles.size13Weight400
                            .copyWith(color: Color(0xFF8E8E93)),
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
                          style: AppTextStyles.size14Weight600
                              .copyWith(color: Color(0xFF8E8E93)),
                        ),
                        Text('${widget.tape.id}',
                            style: AppTextStyles.size14Weight500),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'Дата добавления: ',
                          style: AppTextStyles.size14Weight600
                              .copyWith(color: Color(0xFF8E8E93)),
                        ),
                        Text('${widget.tape.shop?.createdAt}',
                            style: AppTextStyles.size14Weight500),
                      ],
                    )
                  ],
                )
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
                        Container(
                          width: 160,
                          height: 36,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                              color: Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(12)),
                          child: GestureDetector(
                            onTap: () =>
                                _showYearPickerBottomSheet(context, year),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('$year',
                                    style: AppTextStyles.size14Weight500),
                                Image.asset(
                                  Assets.icons.dropDownIcon.path,
                                  height: 6,
                                  width: 12,
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 160,
                          height: 36,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Color(0xFFF7F7F7),
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

                                //   BlocProvider.of<ProfileMonthStaticsBloggerCubit>(context)
                                //       .statics(
                                //     _selectIndex + 1,
                                //     year,
                                //   );
                                // });
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(months[_selectIndex],
                                    style: AppTextStyles.size14Weight500),
                                Image.asset(
                                  Assets.icons.dropDownIcon.path,
                                  height: 6,
                                  width: 12,
                                )
                              ],
                            ),
                          ),
                        )
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
          )
        ],
      ),
    );
  }
}

void _showMonthPickerBottomSheet(
    BuildContext context, int selectedMonth, Function(int) onMonthSelected) {
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

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return SizedBox(
        height: 400,
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
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: months.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedMonth == index;
                  return ListTile(
                    title: Text(
                      months[index],
                      style: TextStyle(
                        fontSize: 16,
                        color: isSelected
                            ? AppColors.mainBackgroundPurpleColor
                            : AppColors.kGray900,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      onMonthSelected(index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

void _showYearPickerBottomSheet(BuildContext context, int currentYear) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      final List<int> years = List.generate(50, (index) => currentYear - index);

      return SizedBox(
        height: 400,
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
            const Divider(),
            Expanded(
              child: ListView.separated(
                itemCount: years.length,
                separatorBuilder: (_, __) => Divider(),
                itemBuilder: (context, index) {
                  final year = years[index];
                  return ListTile(
                    title: Text(
                      '$year',
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.kGray900,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      // сделай что-то с выбранным годом
                      print("Selected year: $year");
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

class StatisticTile extends StatelessWidget {
  final String value;
  final String label;
  final String icon;

  const StatisticTile({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
  });

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
                style: AppTextStyles.size13Weight400
                    .copyWith(color: const Color(0xFF8E8E93)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
