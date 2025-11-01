import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/widgets/custom_back_button.dart';
import 'package:haji_market/src/feature/drawer/bloc/bonus_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/bonus_state.dart';

import '../../../../core/constant/generated/assets.gen.dart';

class BonusUserPage extends StatefulWidget {
  const BonusUserPage({Key? key}) : super(key: key);

  @override
  State<BonusUserPage> createState() => _BonusUserPageState();
}

class _BonusUserPageState extends State<BonusUserPage> {
  int _selectedIndex = -1;

  String currency = 'руб';

  List<String> titleBonus = [
    'Что такое бонусы продавцов ?',
    'Как накопить бонусы продавцов ?',
    'Как можно использовать бонусы ?',
  ];

  List<bool> showBonus = [
    false,
    false,
    false,
  ];

  bool bonusDesciptionHeight = false;

  List<String> descriptionBonus = [
    'Это бонусная программа в приложении LUNA market позволяющая экономить на покупках у продавцов на LUNA market.',
    'Бонусы продавцов можно накапливать у продавцов на LUNA market при покупке товаров с начислением бонусов после оставления отзыва на данный товар,И списывать при следующих покупках у этих продавцов.',
    'Вы можете оплатить бонусами до 10% от стоимости товара по курсу 1 бонус =1 рубль.Бонусы можно тратить на следующие покупки у продавцов, который их начислил.Срок жизни бонусов продавца -12 месяцев с момента начисления за покупку товара.',
  ];

  @override
  void initState() {
    BlocProvider.of<BonusCubit>(context).myBonus();

    // final appLang = GetStorage().read('app_lang');
    // if (appLang != null) {
    //   if (appLang == 'kz') {
    //     currency = 'тг';
    //   } else {
    //     currency = 'руб';
    //   }
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        surfaceTintColor: AppColors.kWhite,
        title: const Text(
          'Мои бонусы',
          style: AppTextStyles.size18Weight600,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 22.0),
          child: CustomBackButton(onTap: () {
            Navigator.pop(context);
          }),
        ),
        elevation: 0,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 220,
            child:

                //  ListView.builder(
                //   itemCount: titleBonus.length,
                //   itemBuilder: (context, index) {
                //     return

                BonusList(
              titles: titleBonus,
              descriptions: descriptionBonus,
            ),

            // Container(
            //   padding: const EdgeInsets.only(
            //       top: 8, left: 16, bottom: 8, right: 16),
            //   height: showBonus[index] == true ? 190 : 50,
            //   color: Colors.white,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             titleBonus[index],
            //             style: AppTextStyles.size18Weight500,
            //           ),
            //           GestureDetector(
            //             onTap: () {
            //               showBonus[index] = !showBonus[index];

            //               bonusDesciptionHeight = !bonusDesciptionHeight;
            //               setState(() {});
            //             },
            //             child: showBonus[index] == true
            //                 ? Icon(
            //                     Icons.keyboard_arrow_up_outlined,
            //                     color: AppColors.kGray200,
            //                   )
            //                 : Icon(
            //                     Icons.keyboard_arrow_down_outlined,
            //                     color: AppColors.kGray200,
            //                   ),
            //           )
            //         ],
            //       ),
            //       SizedBox(height: 8),
            //       showBonus[index] == true
            //           ? Text(
            //               descriptionBonus[index],
            //               style: AppTextStyles.size16Weight400
            //                   .copyWith(color: Color(0xff3A3A3C)),
            //             )
            //           : SizedBox.shrink(),
            //     ],
            //   ),
            // );
            //     },
            //   ),
          ),
          Container(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, top: 8),
            height: 23,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Text(
              'Магазины',
              style: AppTextStyles.size14Weight400
                  .copyWith(color: Color(0xff8E8E93)),
            ),
          ),
          Container(
              color: Colors.white,
              child: BlocConsumer<BonusCubit, BonusState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is NoDataState) {
                      return SizedBox(
                        height: 1000,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                                color: Colors.white,
                                margin: const EdgeInsets.only(top: 146),
                                child: Image.asset(
                                  Assets.icons.defaultNoDataIcon.path,
                                  height: 72,
                                  width: 72,
                                )),
                            SizedBox(height: 12),
                            Text(
                              'Пока здесь пусто',
                              style: AppTextStyles.size16Weight500,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Здесь появятся ваши бонусы от продавцов',
                              style: AppTextStyles.size11Weight400
                                  .copyWith(color: Color(0xff8E8E93)),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is LoadedState) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.bonusModel.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  height: 47,
                                  child: ListTile(
                                    minLeadingWidth: 100,
                                    leading: Text(
                                      '${state.bonusModel[index].name}',
                                      style: const TextStyle(
                                          color: AppColors.kGray900,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    trailing: ClipPath(
                                      clipper: TrapeziumClipper(),
                                      child: Container(
                                        height: 16,
                                        width: 60,
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                            color: AppColors.kPrimaryColor),
                                        child: Text(
                                          '${state.bonusModel[index].bonus} $currency',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })
                        ],
                      );
                    } else {
                      return const SizedBox(
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.blueAccent,
                          ),
                        ),
                      );
                    }
                  })),
          Container(
            height: 10,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class TrapeziumClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width * 0.80, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TrapeziumClipper oldClipper) => false;
}

class BonusList extends StatefulWidget {
  final List<String> titles;
  final List<String> descriptions;

  const BonusList({
    Key? key,
    required this.titles,
    required this.descriptions,
  }) : super(key: key);

  @override
  State<BonusList> createState() => _BonusListState();
}

class _BonusListState extends State<BonusList> with TickerProviderStateMixin {
  late List<bool> _isOpen; // состояние раскрытия для каждого элемента

  @override
  void initState() {
    super.initState();
    _isOpen = List<bool>.filled(widget.titles.length, false);

    _isOpen[0] = true;
  }

  void _toggle(int index) {
    setState(() {
      _isOpen[index] = !_isOpen[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(
                  16))), // не задаём фиксированную высоту, пусть само растёт
      child: ListView.builder(
        // если ты это в Column кладёшь — добавь shrinkWrap: true и physics: NeverScrollableScrollPhysics()
        itemCount: widget.titles.length,
        itemBuilder: (context, index) {
          final opened = _isOpen[index];

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                // Заголовок + стрелка
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.titles[index],
                        style: AppTextStyles.size18Weight500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _toggle(index),
                      behavior: HitTestBehavior.translucent,
                      child: Icon(
                        opened
                            ? Icons.keyboard_arrow_up_outlined
                            : Icons.keyboard_arrow_down_outlined,
                        color: AppColors.kGray200,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Тело с описанием + плавная анимация высоты
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  alignment: Alignment.topCenter,
                  child: opened
                      ? Container(
                          width: double.infinity,
                          // отдельный отступ чтобы текст не лип к стрелке
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            widget.descriptions[index],
                            style: AppTextStyles.size16Weight400.copyWith(
                              color: const Color(0xff3A3A3C),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
