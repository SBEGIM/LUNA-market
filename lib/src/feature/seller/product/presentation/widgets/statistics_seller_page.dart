import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
      body: ListView(shrinkWrap: true, children: [
        const SizedBox(
          height: 10,
        ),
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
                  height: 106,
                  width: 106,
                  padding: EdgeInsets.all(3),
                  margin: EdgeInsets.all(8),
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
                  width: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.product.catName}',
                        style: AppTextStyles.categoryTextStyle
                            .copyWith(color: AppColors.kGray200),
                      ),
                      SizedBox(height: 4),
                      Text('${widget.product.name}',
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.counterSellerProfileTextStyle
                              .copyWith(color: AppColors.kLightBlackColor)),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            'Артикул: ',
                            style: AppTextStyles.categoryTextStyle
                                .copyWith(color: AppColors.kGray200),
                          ),
                          Text('${widget.product.id}',
                              style: AppTextStyles.categoryTextStyle),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            'Дата добавления: ',
                            style: AppTextStyles.categoryTextStyle
                                .copyWith(color: AppColors.kGray200),
                          ),
                          Text(
                            '${widget.product.created_at}',
                            style: AppTextStyles.categoryTextStyle,
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
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          // color: Colors.white,
          margin: const EdgeInsets.only(top: 0),
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),

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
                      onTap: () => _showYearPickerBottomSheet(context, year),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$year',
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
                          BlocProvider.of<StatisticsProductSellerCubit>(context)
                              .statistics(
                                  widget.product.id, year, selectedIndex + 1);

                          _summBonus = 0;
                          setState(() {
                            _selectIndex;
                            _summBonus;
                          });
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
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<StatisticsProductSellerCubit,
                  StatisticProductSellerState>(
                builder: (context, state) {
                  if (state is LoadedState) {
                    return SizedBox(
                      height: 400,
                      child: ListView(
                        children: [
                          StatisticWidgetContainer(
                            text: state.stats.count_click.toString(),
                            subText: 'Количество кликов',
                            url: Assets.images.statiscticsProducts.path,
                          ),
                          StatisticWidgetContainer(
                            text: state.stats.count_favorite.toString(),
                            subText: 'Добавлен в\nизбранное',
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
                      ),
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
        final List<int> years =
            List.generate(50, (index) => currentYear - index);

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
      margin: EdgeInsets.all(10),
      width: 500,
      height: 92,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.mainPurpleColor.withOpacity(0.15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            // blurRadius: 1,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
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
                style: const TextStyle(
                    color: AppColors.kGray900,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                subText,
                maxLines: 1,
                style: const TextStyle(
                    color: AppColors.kGray300,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
