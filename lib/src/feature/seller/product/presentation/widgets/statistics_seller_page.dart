import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/feature/auth/presentation/widgets/default_button.dart';
import 'package:haji_market/src/feature/product/presentation/widgets/chip_date_widget.dart';
import 'package:haji_market/src/feature/seller/product/bloc/statistic_product_seller_state.dart';
import '../../../../../core/common/constants.dart';
import '../../../../../core/constant/generated/assets.gen.dart';
import '../../../../app/widgets/error_image_widget.dart';
import '../../bloc/statistic_product_seller_cubit.dart';
import '../../data/models/product_seller_model.dart';

class StatisticsSellerPage extends StatefulWidget {
  final ProductSellerModel product;

  const StatisticsSellerPage({required this.product, Key? key})
      : super(key: key);

  @override
  State<StatisticsSellerPage> createState() => _StatisticsSellerPageState();
}

class _StatisticsSellerPageState extends State<StatisticsSellerPage> {
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
  int _summBonus = 0;
  int year = 2025;
  int _selectIndex = 0;

  @override
  void initState() {
    BlocProvider.of<StatisticsProductSellerCubit>(context)
        .statistics(widget.product.id, year, 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kGray1,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('Статистика', style: AppTextStyles.titleTextStyle),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            size: 22,
          ),
        ),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: 130,
            width: 358,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Container(
                  height: 104,
                  width: 104,
                  margin: EdgeInsets.all(13),
                  child: widget.product.images != null &&
                          widget.product.images!.isNotEmpty
                      ? Image.network(
                          'https://lunamarket.ru/storage/${widget.product.images?.first}',
                          errorBuilder: (context, error, stackTrace) {
                            return const ErrorImageWidget();
                          },
                        )
                      : const ErrorImageWidget(),
                ),
                const SizedBox(
                  width: 11,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.product.catName}',
                        style: AppTextStyles.size13Weight400
                            .copyWith(color: Color(0xff8E8E93)),
                      ),
                      SizedBox(height: 4),
                      Text('${widget.product.name}',
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.size14Weight600
                              .copyWith(color: AppColors.kLightBlackColor)),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            'Артикул: ',
                            style: AppTextStyles.size13Weight400
                                .copyWith(color: Color(0xff8E8E93)),
                          ),
                          Text('${widget.product.id}',
                              style: AppTextStyles.size13Weight500),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            'Дата добавления: ',
                            style: AppTextStyles.size13Weight400
                                .copyWith(color: Color(0xff8E8E93)),
                          ),
                          Text(
                            '${widget.product.created_at}',
                            style: AppTextStyles.size13Weight500,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(22)),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _showYearPickerBottomSheet(context, year, (value) {
                  BlocProvider.of<StatisticsProductSellerCubit>(context)
                      .statistics(widget.product.id, value, _selectIndex + 1);

                  _summBonus = 0;
                  year = value;

                  setState(() {
                    year;
                    _summBonus;
                  });
                }),
                child: Container(
                  width: 160,
                  height: 36,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Color(0xffF7F7F7),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('$year', style: AppTextStyles.size14Weight500),
                        Image.asset(Assets.icons.dropDownIcon.path, scale: 2.6),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showMonthPickerBottomSheet(context, _selectIndex,
                      (int selectedIndex) {
                    _selectIndex = selectedIndex;
                    BlocProvider.of<StatisticsProductSellerCubit>(context)
                        .statistics(widget.product.id, year, selectedIndex + 1);

                    _summBonus = 0;
                    setState(() {
                      _selectIndex;
                      _summBonus;
                    });
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(months[_selectIndex],
                            style: AppTextStyles.size14Weight500),
                        Image.asset(Assets.icons.dropDownIcon.path, scale: 2.6),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<StatisticsProductSellerCubit,
                  StatisticProductSellerState>(
                builder: (context, state) {
                  if (state is LoadedState) {
                    return ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        StatisticWidgetContainer(
                          text: state.stats.count_click.toString(),
                          subText: 'Количество кликов',
                          url: Assets.images.statiscticsProducts.path,
                        ),
                        StatisticWidgetContainer(
                          text: state.stats.count_favorite.toString(),
                          subText: 'Добавлен в избранное',
                          url: Assets.images.statisticsProductsHeart.path,
                        ),
                        StatisticWidgetContainer(
                          text: state.stats.count_basket.toString(),
                          subText: 'Добавлен в корзину',
                          url: Assets.images.statisticsProductsBasket.path,
                        ),
                        StatisticWidgetContainer(
                          text: state.stats.count_buy.toString(),
                          subText: 'Количество покупок',
                          url: Assets.images.statisticsProductsBuy.path,
                        )
                      ],
                    );
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: Colors.blueAccent));
                  }
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void _showMonthPickerBottomSheet(
    BuildContext context,
    int initialSelectedMonth,
    Function(int) onMonthSelected,
  ) {
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
                            if (index < 0 || index >= months.length)
                              return null;
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
    final List<int> years =
        List.generate(21, (index) => (baseYear + 5) - index);

    final int initialIndex = years.indexOf(initialSelectedYear);
    final FixedExtentScrollController scrollController =
        FixedExtentScrollController(
      initialItem: initialIndex == -1
          ? 0
          : initialIndex, // фолбэк, если года нет в списке
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
                          onYearSelected(year);

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
      margin: EdgeInsets.only(bottom: 12, left: 16, right: 16),
      width: double.infinity,
      height: 92,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.mainPurpleColor.withOpacity(0.1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 16),
          Image.asset(
            url,
            scale: 2,
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: AppTextStyles.size18Weight600,
              ),
              Text(
                subText,
                maxLines: 1,
                style: AppTextStyles.size13Weight400
                    .copyWith(color: AppColors.kGray300),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
