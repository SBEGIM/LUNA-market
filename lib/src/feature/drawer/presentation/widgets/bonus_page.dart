import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/widgets/custom_back_button.dart';
import 'package:haji_market/src/feature/drawer/data/bloc/bonus_cubit.dart';
import 'package:haji_market/src/feature/drawer/data/bloc/bonus_state.dart';

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
        backgroundColor: Colors.white,
        title: const Text(
          'Мои бонусы',
          style: TextStyle(
              color: AppColors.kGray900,
              fontSize: 16,
              fontWeight: FontWeight.w500),
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
          Container(
            margin: const EdgeInsets.only(top: 16, left: 16, bottom: 8),
            height: 23,
            child: const Text(
              'Бонусы продавцов',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.kGray900),
            ),
          ),
          SizedBox(
            height: bonusDesciptionHeight == true ? 300 : 200,
            child: ListView.builder(
              itemCount: titleBonus.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16, bottom: 8, right: 16),
                  height: showBonus[index] == true ? 170 : 70,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            titleBonus[index],
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.kGray900),
                          ),
                          GestureDetector(
                            onTap: () {
                              showBonus[index] = !showBonus[index];

                              bonusDesciptionHeight = !bonusDesciptionHeight;
                              setState(() {});
                            },
                            child: showBonus[index] == true
                                ? Icon(
                                    Icons.keyboard_arrow_up_outlined,
                                    color: AppColors.kPrimaryColor,
                                  )
                                : Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: AppColors.kPrimaryColor,
                                  ),
                          )
                        ],
                      ),
                      showBonus[index] == true
                          ? Text(
                              descriptionBonus[index],
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.kGray900),
                            )
                          : SizedBox(),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16, left: 16, bottom: 8),
            height: 23,
            child: const Text(
              'Ваши накопленные бонусы',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.kGray900),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16),
            height: 23,
            alignment: Alignment.centerLeft,
            color: Colors.white,
            child: const Text(
              'Магазины',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.kGray900),
            ),
          ),
          Container(
            height: 10,
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
                                child: Image.asset('assets/icons/no_data.png')),
                            const Text(
                              'У вас пока нет бонусов',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              'Для выбора вещей перейдите в маркет',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff717171)),
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
