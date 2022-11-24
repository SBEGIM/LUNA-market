import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/features/basket/data/models/basket_show_model.dart';
import 'package:haji_market/features/home/presentation/ui/home_page.dart';

import '../../../../core/common/constants.dart';
import '../../../app/bloc/navigation_cubit/navigation_cubit.dart' as navCubit;
import '../../../app/presentaion/base.dart';
import '../../../drawer/data/bloc/basket_cubit.dart';
import '../../../drawer/data/bloc/basket_state.dart';
import '../../data/DTO/basketOrderDto.dart';

class BasketOrderPage extends StatefulWidget {
  BasketOrderPage({Key? key}) : super(key: key);

  @override
  _BasketOrderPageState createState() => _BasketOrderPageState();
}

class _BasketOrderPageState extends State<BasketOrderPage> {
  bool isCheckedKaspi = false;
  bool isCheckedCredit = false;
  bool isCredit = false;
  int? selectedIndex = 0;
  int? selectedIndex2 = 0;
  int creditMonth = 1;
  List textInst = [
    '3 мес',
    '6 мес',
    '12 мес',
    '24 мес',
  ];

  int price = 0;
  int courier = 0;
  int bonus = 300;
  int count = 0;

  List<int> id = [];

  bool isSwitched = false;
  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  Future<void> basket(List<BasketShowModel>? basketShowModel) async {
    basketShowModel!.forEach((element) {
      id.add(element.basketId!.toInt());
      count += element.basketCount!.toInt();
      price += element.price!.toInt();
      courier += element.priceCourier!.toInt();
    });
  }

  Future<void> basketData() async {
    final BasketDataCubit =
        await BlocProvider.of<BasketCubit>(context).basketData();
    basket(BasketDataCubit as List<BasketShowModel>);
  }

  @override
  void initState() {
    basketData();
    BlocProvider.of<BasketCubit>(context).basketShow();
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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.kPrimaryColor,
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 22.0),
                child: SvgPicture.asset('assets/icons/share.svg'))
          ],
          title: const Text(
            'Оплата',
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          )),
      body: BlocConsumer<BasketCubit, BasketState>(listener: (context, state) {
        if (state is OrderState) {
          BlocProvider.of<navCubit.NavigationCubit>(context)
              .getNavBarItem(const navCubit.NavigationState.home());
          Get.to(const Base(index: 1));
        }
      }, builder: (context, state) {
        if (state is ErrorState) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(fontSize: 20.0, color: Colors.grey),
            ),
          );
        }

        if (state is LoadedState) {
          return Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  alignment: Alignment.topLeft,
                  color: Colors.white,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            const Text(
                              'Товары',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${count} товара',
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          "${price} ₸",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 1,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  alignment: Alignment.topLeft,
                  color: Colors.white,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Доставка',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          '${courier} ₸',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 1,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  alignment: Alignment.topLeft,
                  color: Colors.white,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Сумма покупки',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          ' ${courier + price} ₸',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 1,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  alignment: Alignment.topLeft,
                  color: Colors.white,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 18),
                              child: Switch(
                                onChanged: toggleSwitch,
                                value: isSwitched,
                                activeColor: AppColors.kPrimaryColor,
                                activeTrackColor: AppColors.kPrimaryColor,
                                inactiveThumbColor:
                                    const Color.fromRGBO(245, 245, 245, 1),
                                inactiveTrackColor:
                                    const Color.fromRGBO(237, 237, 237, 1),
                              ),
                            ),
                            Container(
                                child: Column(
                              children: [
                                Text(
                                  '300 Бонусов',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'Накоплено',
                                  style: TextStyle(
                                    color: AppColors.steelGray,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 16),
                        child: const Text(
                          'Потратить',
                          style: TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 8,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  alignment: Alignment.topLeft,
                  color: Colors.white,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'К оплате',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          ' ${isSwitched == true ? (courier + price - bonus) : (courier + price)} ₸',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 1,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  alignment: Alignment.topLeft,
                  color: Colors.white,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: const Text(
                          'Способы оплаты',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 16),
                        child: const Text(
                          'Добавить новую карту',
                          style: TextStyle(
                            color: AppColors.kPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 1,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  alignment: Alignment.topLeft,
                  color: Colors.white,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: Row(
                        children: [
                          Checkbox(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            checkColor: Colors.white,
                            activeColor: AppColors.kPrimaryColor,
                            value: isCheckedKaspi,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedKaspi = value!;
                              });
                            },
                          ),
                          const Text(
                            'Kaspi Gold',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )),
                      Container(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          ' ${isSwitched == true ? (courier + price - bonus) : (courier + price)} ₸',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 1,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  alignment: Alignment.topLeft,
                  color: Colors.white,
                  height: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: Row(
                        children: [
                          Checkbox(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            checkColor: Colors.white,
                            activeColor: AppColors.kPrimaryColor,
                            value: isCheckedCredit,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedCredit = value!;
                              });
                            },
                          ),
                          Text(
                            'В рассрочку',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )),
                    ],
                  )),
              Container(
                padding: const EdgeInsets.only(left: 44, top: 14),
                alignment: Alignment.topLeft,
                color: Colors.white,
                height: 45,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.585, // 229,
                  height: 32,
                  child: ListView.builder(
                    itemCount: textInst.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (index == 0) {
                              setState(() {
                                creditMonth = 3;
                              });
                            }
                            if (index == 1) {
                              setState(() {
                                creditMonth = 6;
                              });
                            }
                            if (index == 2) {
                              setState(() {
                                creditMonth = 12;
                              });
                            }
                            if (index == 3) {
                              setState(() {
                                creditMonth = 24;
                              });
                            }
                            selectedIndex2 = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 2),
                          width: 54,
                          decoration: BoxDecoration(
                            color: selectedIndex2 == index
                                ? AppColors.kPrimaryColor
                                : Colors.white,
                            border: Border.all(
                              color: AppColors.kPrimaryColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 8,
                          ),
                          child: Text(
                            textInst[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: selectedIndex2 == index
                                    ? Colors.white
                                    : AppColors.kGray900,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(left: 44, top: 14),
                  alignment: Alignment.topLeft,
                  color: Colors.white,
                  child: Row(
                    children: [
                      const Text('Платеж в месяц: '),
                      Container(
                        height: 28,
                        decoration: BoxDecoration(
                          color: AppColors.kYellowLight,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          ' ${isSwitched == true ? (courier + price - bonus) / (isCheckedCredit == true ? creditMonth : 1) : (courier + price) / (isCheckedCredit == true ? creditMonth : 1)}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                color: Colors.white,
                height: 10,
              ),
              const SizedBox(
                height: 57,
              ),
            ],
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(color: Colors.indigoAccent));
        }
      }),
      bottomSheet: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        child: InkWell(
          onTap: () {
            BlocProvider.of<BasketCubit>(context).basketOrder(id);
            // Navigator.pop(context);
          },
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.kPrimaryColor,
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Оформить заказ',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}
