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
      extendBodyBehindAppBar: false,
      backgroundColor: AppColors.kGray2,
      appBar: AppBar(
        backgroundColor: AppColors.kGray2,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              size: 25,
              color: AppColors.kLightBlackColor,
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
            Text(
          'Статистика',
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        // ],
        // ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 12, left: 16, right: 16),
            height: 164,
            decoration: BoxDecoration(
                color: AppColors.kWhite,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 124,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 104,
                              width: 104,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  // Добавляем линию вокруг контейнера
                                  color: AppColors.kGray200,
                                  // Цвет линии (можно изменить на нужный)
                                  width: 1, // Толщина линии
                                ),
                              ),
                              child: Image.network(
                                'https://lunamarket.ru/storage/${widget.tape.image}',
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    const ErrorImageWidget(
                                  height: 104,
                                  width: 104,
                                ),
                                // loadingBuilder: (context, child,
                                //     loadingProgress) {
                                //   if (loadingProgress == null)
                                //     return child;
                                //   return const Center(
                                //       child:
                                //           CircularProgressIndicator(
                                //               strokeWidth: 2));
                                // },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 180,
                                  child: Text(
                                    '${widget.tape.name}',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${(widget.tape.price!.toInt() - ((widget.tape.price! / 100) * widget.tape.compound!).toInt())} ₽ ',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          '${widget.tape.price} ₽',
                                          style: const TextStyle(
                                              color: AppColors.kGray300,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor:
                                                  AppColors.kGray300),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      width: 100,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: AppColors.mainPurpleColor
                                              .withOpacity(0.2)),
                                      child: Text(
                                        '${(widget.tape.price!.toInt() - ((widget.tape.price! / 100) * widget.tape.compound!).toInt()) ~/ 3} ₽/ мес',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            constraints: BoxConstraints(maxHeight: 500),
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.kWhite,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 160,
                        height: 36,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: AppColors.kGray2,
                            borderRadius: BorderRadius.circular(12)),
                        child: GestureDetector(
                          onTap: () =>
                              _showYearPickerBottomSheet(context, year),
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
                          color: AppColors.kGray2,
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
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color:
                                  AppColors.mainPurpleColor.withOpacity(0.1)),
                          height: 100,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 12),
                                Image.asset(
                                  Assets.icons.statisticsBasket.path,
                                  scale: 1.6,
                                ),
                                SizedBox(width: 12),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '10%',
                                      style:
                                          AppTextStyles.defaultButtonTextStyle,
                                    ),
                                    Text(
                                      'Вознаграждение',
                                      style: AppTextStyles.aboutTextStyle
                                          .copyWith(color: AppColors.kGray300),
                                    )
                                  ],
                                )
                              ]),
                        ),
                        SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color:
                                  AppColors.mainPurpleColor.withOpacity(0.1)),
                          height: 100,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 12),
                                Image.asset(
                                  Assets.icons.statisticsBonus.path,
                                  scale: 1.6,
                                ),
                                SizedBox(width: 12),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '30.000 руб',
                                      style:
                                          AppTextStyles.defaultButtonTextStyle,
                                    ),
                                    Text(
                                      'Мой заработок',
                                      style: AppTextStyles.aboutTextStyle
                                          .copyWith(color: AppColors.kGray300),
                                    )
                                  ],
                                )
                              ]),
                        ),
                        SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color:
                                  AppColors.mainPurpleColor.withOpacity(0.1)),
                          height: 100,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 12),
                                Image.asset(
                                  Assets.icons.statisticsClick.path,
                                  scale: 1.6,
                                ),
                                SizedBox(width: 12),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '1000',
                                      style:
                                          AppTextStyles.defaultButtonTextStyle,
                                    ),
                                    Text(
                                      'Количество кликов',
                                      style: AppTextStyles.aboutTextStyle
                                          .copyWith(color: AppColors.kGray300),
                                    )
                                  ],
                                )
                              ]),
                        ),
                        SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color:
                                  AppColors.mainPurpleColor.withOpacity(0.1)),
                          height: 100,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 12),
                                Image.asset(
                                  Assets.icons.statisticsFavorite.path,
                                  scale: 1.6,
                                ),
                                SizedBox(width: 12),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '3 000',
                                      style:
                                          AppTextStyles.defaultButtonTextStyle,
                                    ),
                                    Text(
                                      'Добавлен в избранное',
                                      style: AppTextStyles.aboutTextStyle
                                          .copyWith(color: AppColors.kGray300),
                                    )
                                  ],
                                ),
                              ]),
                        ),
                        SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color:
                                  AppColors.mainPurpleColor.withOpacity(0.1)),
                          height: 100,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 12),
                                Image.asset(
                                  Assets.icons.statisticsBasket.path,
                                  scale: 1.6,
                                ),
                                SizedBox(width: 12),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '500',
                                      style:
                                          AppTextStyles.defaultButtonTextStyle,
                                    ),
                                    Text(
                                      'Добавлен в корзину',
                                      style: AppTextStyles.aboutTextStyle
                                          .copyWith(color: AppColors.kGray300),
                                    )
                                  ],
                                ),
                              ]),
                        ),
                        SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color:
                                  AppColors.mainPurpleColor.withOpacity(0.1)),
                          height: 100,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(width: 12),
                                Image.asset(
                                  Assets.icons.statisticsBasket.path,
                                  scale: 1.6,
                                ),
                                SizedBox(width: 12),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '99',
                                      style:
                                          AppTextStyles.defaultButtonTextStyle,
                                    ),
                                    Text(
                                      'Количество покупок',
                                      style: AppTextStyles.aboutTextStyle
                                          .copyWith(color: AppColors.kGray300),
                                    )
                                  ],
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
