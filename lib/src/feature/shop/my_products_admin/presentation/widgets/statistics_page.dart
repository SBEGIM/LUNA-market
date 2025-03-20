import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/feature/shop/my_products_admin/data/bloc/statistics_product_state.dart';
import 'package:haji_market/src/feature/drawer/presentation/ui/products_page.dart';
import '../../../../../core/common/constants.dart';
import '../../../../app/widgets/error_image_widget.dart';
import '../../data/bloc/statistics_product_cubit.dart';
import '../../data/models/admin_products_model.dart';

class StatisticsPage extends StatefulWidget {
  final AdminProductsModel product;

  const StatisticsPage({required this.product, Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
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
  int year = 2023;
  int _selectIndex = -1;

  @override
  void initState() {
    BlocProvider.of<StatisticsProductCubit>(context)
        .statistics(widget.product.id, year, 1);
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
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding:
                const EdgeInsets.only(top: 16, bottom: 16, left: 15, right: 5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                SizedBox(
                  height: 106,
                  width: 106,
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
                    Text(
                      'Дата добавления: ${widget.product.created_at}',
                      style: const TextStyle(
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
                child: const Icon(
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
                style: const TextStyle(
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
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                  size: 15.0,
                ),
              ),
            ],
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
                        BlocProvider.of<StatisticsProductCubit>(context)
                            .statistics(widget.product.id, year, index + 1);

                        _summBonus = 0;
                        setState(() {
                          _selectIndex;
                          _summBonus;
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
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<StatisticsProductCubit, StatisticsProductState>(
                builder: (context, state) {
                  if (state is LoadedState) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StatisticWidgetContainer(
                              text: state.stats.count_click.toString(),
                              subText: 'Количество кликов',
                              url: 'assets/icons/click1.svg',
                            ),
                            StatisticWidgetContainer(
                              text: state.stats.count_favorite.toString(),
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
                          children: [
                            StatisticWidgetContainer(
                              text: state.stats.count_basket.toString(),
                              subText: 'Добавлен в корзину ',
                              url: 'assets/icons/click3.svg',
                            ),
                            StatisticWidgetContainer(
                              text: state.stats.count_buy.toString(),
                              subText: 'Количество покупок',
                              url: 'assets/icons/click4.svg',
                            )
                          ],
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
