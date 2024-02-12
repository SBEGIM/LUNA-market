import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/features/app/router/app_router.dart';
import 'package:haji_market/features/drawer/data/bloc/order_cubit.dart' as orderCubit;
import 'package:share_plus/share_plus.dart';
import '../../../../contract_of_sale.dart';
import '../../../../core/common/constants.dart';
import '../../../app/bloc/navigation_cubit/navigation_cubit.dart' as navCubit;
import '../../../drawer/data/bloc/basket_cubit.dart';
import '../../../drawer/data/bloc/basket_state.dart';
import '../../../drawer/presentation/widgets/credit_info_detail_page.dart';

@RoutePage()
class BasketOrderPage extends StatefulWidget {
  final String? address;
  bool? fbs;
  BasketOrderPage({this.fbs, Key? key, this.address}) : super(key: key);

  @override
  _BasketOrderPageState createState() => _BasketOrderPageState();
}

class _BasketOrderPageState extends State<BasketOrderPage> {
  bool isCheckedOnline = false;
  bool isCheckedCash = false;
  bool isCheckedBS = false;
  bool isCheckedTinkoff = false;
  bool isCheckedPart = false;
  bool isCheckedHalal = false;
  bool isCheckedCredit = false;
  bool isCheckedPolitic = false;
  bool isCredit = false;
  int? selectedIndex = 0;
  int? selectedIndex2 = 0;
  int creditMonth = 1;
  List textInst = [
    '3 мес',
    '6 мес',
    '9 мес',
    '12 мес',
  ];

  int price = 0;
  int bs = 0;
  int courier = 0;
  int bonus = 0;
  int count = 0;
  String? productNames;

  List<int> id = [];

  bool isSwitched = false;
  void toggleSwitch(bool value) {
    if (bonus != 0) {
      if (isSwitched == false) {
        setState(() {
          isSwitched = true;
        });
      } else {
        setState(() {
          isSwitched = false;
        });
      }
    } else {
      Get.snackbar('Ошибка', 'У вас нет бонусов от этого магазина', backgroundColor: Colors.blueAccent);
    }
  }

  Future<void> basket(BasketState state) async {
    if (state is LoadedState) {
      for (var element in state.basketShowModel) {
        id.add(element.basketId!.toInt());
        count += element.basketCount ?? 0;
        price += element.price ?? 0;
        bonus += element.userBonus ?? 0;

        if (element.fulfillment == 'fbs') courier += element.deliveryPrice ?? 0;
        productNames =
            "${productNames != null ? "$productNames ," : ''}  $kDeepLinkUrl/?product_id\u003d${element.product!.id}";
      }
      bs = (price * 0.05).toInt();
    }
  }

  Future<void> basketData() async {
    basket(BlocProvider.of<BasketCubit>(context).state);
  }

  @override
  void initState() {
    basketData();
    // BlocProvider.of<BasketCubit>(context).basketShow();
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
                child: GestureDetector(
                    onTap: () async {
                      await Share.share('$productNames');
                    },
                    child: SvgPicture.asset('assets/icons/share.svg')))
          ],
          title: const Text(
            'Оплата',
            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          )),
      body: BlocConsumer<BasketCubit, BasketState>(listener: (context, state) {
        if (state is OrderState) {
          BlocProvider.of<navCubit.NavigationCubit>(context).getNavBarItem(const navCubit.NavigationState.home());
          context.router.popUntil((route) => route.settings.name == LauncherRoute.name);
          // Get.to(const Base(index: 1));
        }
      }, builder: (context, state) {
        return ListView(children: [
          Column(
            children: [
              const SizedBox(height: 12),
              Container(
                  //margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  alignment: Alignment.center,
                  color: Colors.white,
                  height: 73,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                            '$count товара',
                            style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      Text(
                        "$price ₽",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 1,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 16),
                  alignment: Alignment.center,
                  color: Colors.white,
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Доставка',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          '$courier ₽',
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
                  padding: const EdgeInsets.only(left: 16),
                  alignment: Alignment.center,
                  color: Colors.white,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Сумма покупки',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          ' ${courier + price} ₽',
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
              // Container(
              //     alignment: Alignment.center,
              //     color: Colors.white,
              //     height: 55,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Row(
              //           children: [
              //             Checkbox(
              //               shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(4)),
              //               checkColor: Colors.white,
              //               activeColor: AppColors.kPrimaryColor,
              //               value: isCheckedBS,
              //               onChanged: (bool? value) {
              //                 setState(() {
              //                   isCheckedBS = value!;
              //                   value == true ? price += bs : price -= bs;
              //                 });
              //               },
              //             ),
              //             const Text(
              //               'Безопасная сделка',
              //               style: TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //           ],
              //         ),
              //         Container(
              //           padding: const EdgeInsets.only(right: 16),
              //           child: Text(
              //             '${bs} ₸',
              //             style: const TextStyle(
              //               fontSize: 16,
              //               fontWeight: FontWeight.w500,
              //             ),
              //           ),
              //         ),
              //       ],
              //     )),

              const SizedBox(height: 1),
              Container(
                  padding: const EdgeInsets.only(left: 5),
                  alignment: Alignment.center,
                  color: Colors.white,
                  height: 73,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Container(
                              // padding: EdgeInsets.only(bottom: 18),
                              alignment: Alignment.center,
                              child: Switch(
                                onChanged: toggleSwitch,
                                value: isSwitched,
                                activeColor: AppColors.kPrimaryColor,
                                activeTrackColor: AppColors.kPrimaryColor,
                                inactiveThumbColor: const Color.fromRGBO(245, 245, 245, 1),
                                inactiveTrackColor: const Color.fromRGBO(237, 237, 237, 1),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$bonus Бонусов',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Text(
                                  'Оплатить можно 10% от суммы товара',
                                  style: TextStyle(
                                    color: AppColors.steelGray,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
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
                  padding: const EdgeInsets.only(left: 16),
                  alignment: Alignment.center,
                  color: Colors.white,
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'К оплате',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          ' ${isSwitched == true ? (bonus < (price * 0.1) ? ((price - bonus) + courier) : ((price - price * 0.1) + courier)).toInt() : (courier + price)} ₽',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  )),
              // const SizedBox(
              //   height: 1,
              // ),
              // Container(
              //     padding: const EdgeInsets.only(left: 16, right: 16),
              //     alignment: Alignment.center,
              //     color: Colors.white,
              //     height: 55,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: const [
              //         Text(
              //           'Способы оплаты',
              //           style: TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.w400,
              //           ),
              //         ),
              //         Text(
              //           'Добавить новую карту',
              //           style: TextStyle(
              //             color: AppColors.kPrimaryColor,
              //             fontSize: 16,
              //             fontWeight: FontWeight.w400,
              //           ),
              //         ),
              //       ],
              //     )),
              // const SizedBox(
              //   height: 1,
              // ),
              // Container(
              //     padding: const EdgeInsets.only(left: 16, top: 16),
              //     alignment: Alignment.topLeft,
              //     color: Colors.white,
              //     height: 60,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Container(
              //             child: Row(
              //           children: [
              //             Checkbox(
              //               shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(4)),
              //               checkColor: Colors.white,
              //               activeColor: AppColors.kPrimaryColor,
              //               value: isCheckedKaspi,
              //               onChanged: (bool? value) {
              //                 setState(() {
              //                   isCheckedKaspi = value!;
              //                 });
              //               },
              //             ),
              //             const Text(
              //               'Kaspi Gold',
              //               style: TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //           ],
              //         )),
              //         Container(
              //           padding: const EdgeInsets.only(right: 16),
              //           child: Text(
              //             ' ${isSwitched == true ? (courier + price - bonus) : (courier + price)} ₸',
              //             style: const TextStyle(
              //               fontSize: 16,
              //               fontWeight: FontWeight.w500,
              //             ),
              //           ),
              //         ),
              //       ],
              //     )),
              const SizedBox(
                height: 1,
              ),
              // Container(
              //     // padding: const EdgeInsets.only(left: 16),
              //     alignment: Alignment.center,
              //     color: Colors.white,
              //     height: 45,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Row(
              //           children: [
              //             Checkbox(
              //               shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(4)),
              //               checkColor: Colors.white,
              //               activeColor: AppColors.kPrimaryColor,
              //               value: isCheckedCredit,
              //               onChanged: (bool? value) {
              //                 setState(() {
              //                   isCheckedCredit = value!;
              //                 });
              //               },
              //             ),
              //             const Text(
              //               'В рассрочку',
              //               style: TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //           ],
              //         )
              //       ],
              //     )),
              // Container(
              //   padding: const EdgeInsets.only(left: 44, top: 14),
              //   alignment: Alignment.topLeft,
              //   color: Colors.white,
              //   height: 45,
              //   child: SizedBox(
              //     width: MediaQuery.of(context).size.width * 0.595, // 229,
              //     height: 32,
              //     child: ListView.builder(
              //       itemCount: textInst.length,
              //       shrinkWrap: true,
              //       physics: const NeverScrollableScrollPhysics(),
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (context, index) {
              //         return InkWell(
              //           onTap: () {
              //             setState(() {
              //               if (index == 0) {
              //                 setState(() {
              //                   creditMonth = 3;
              //                 });
              //               }
              //               if (index == 1) {
              //                 setState(() {
              //                   creditMonth = 6;
              //                 });
              //               }
              //               if (index == 2) {
              //                 setState(() {
              //                   creditMonth = 12;
              //                 });
              //               }
              //               if (index == 3) {
              //                 setState(() {
              //                   creditMonth = 24;
              //                 });
              //               }
              //               selectedIndex2 = index;
              //             });
              //           },
              //           child: Container(
              //             // margin: EdgeInsets.only(right: 2),
              //             width: 58,
              //             alignment: Alignment.center,
              //             decoration: BoxDecoration(
              //               color: selectedIndex2 == index
              //                   ? AppColors.kPrimaryColor
              //                   : Colors.white,
              //               border: Border.all(
              //                 color: AppColors.kPrimaryColor,
              //                 width: 0.4,
              //               ),
              //               borderRadius: BorderRadius.circular(0),
              //             ),
              //             // padding: const EdgeInsets.only(
              //             //   top: 8,
              //             //   bottom: 8,
              //             // ),
              //             child: Text(
              //               textInst[index],
              //               textAlign: TextAlign.center,
              //               style: TextStyle(
              //                   color: selectedIndex2 == index
              //                       ? Colors.white
              //                       : AppColors.kGray900,
              //                   fontSize: 14,
              //                   fontWeight: FontWeight.w400),
              //             ),
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ),
              // Container(
              //     padding: const EdgeInsets.only(left: 44, top: 14),
              //     alignment: Alignment.topLeft,
              //     color: Colors.white,
              //     child: Row(
              //       children: [
              //         const Text('Платеж в месяц: '),
              //         Container(
              //           height: 28,
              //           decoration: BoxDecoration(
              //             color: AppColors.kYellowLight,
              //             borderRadius: BorderRadius.circular(3),
              //           ),
              //           alignment: Alignment.center,
              //           child: Text(
              //             ' ${isSwitched == true ? ((courier + price - bonus) / (isCheckedCredit == true ? creditMonth : 1)).toInt() : ((courier + price) / (isCheckedCredit == true ? creditMonth : 1)).toInt()}',
              //             style: const TextStyle(
              //               fontSize: 14,
              //               fontWeight: FontWeight.w500,
              //             ),
              //           ),
              //         ),
              //       ],
              //     )),
              // Container(
              //   color: Colors.white,
              //   height: 10,
              // ),
              //const SizedBox(height: 1),

              Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  alignment: Alignment.center,
                  color: Colors.white,
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Онлайн оплата',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Checkbox(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        checkColor: Colors.white,
                        activeColor: AppColors.kPrimaryColor,
                        value: isCheckedOnline,
                        onChanged: (bool? value) {
                          setState(() {
                            isCheckedTinkoff = false;
                            isCheckedOnline = value!;
                            isCheckedCash = false;
                            isCheckedPart = false;
                            isCheckedHalal = false;
                          });
                        },
                      ),
                    ],
                  )),
              const SizedBox(height: 1),

              // Container(
              //     padding: const EdgeInsets.only(left: 16, right: 16),
              //     alignment: Alignment.center,
              //     color: Colors.white,
              //     height: 55,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         const Text(
              //           'Наличными',
              //           style: TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.w400,
              //           ),
              //         ),
              //         Checkbox(
              //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              //           checkColor: Colors.white,
              //           activeColor: AppColors.kPrimaryColor,
              //           value: isCheckedCash,
              //           onChanged: (bool? value) {
              //             setState(() {
              //               isCheckedTinkoff = false;
              //               isCheckedOnline = false;
              //               isCheckedCash = value!;
              //               isCheckedPart = false;
              //               isCheckedHalal = false;
              //             });
              //           },
              //         ),
              //       ],
              //     )),
              // const SizedBox(height: 1),

              // Container(
              //     padding: const EdgeInsets.only(left: 16, right: 16),
              //     alignment: Alignment.center,
              //     color: Colors.white,
              //     height: 55,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Row(
              //           children: [
              //             Image.asset(
              //               'assets/icons/tinkoff2.png',
              //               height: 34,
              //               width: 34,
              //             ),
              //             const SizedBox(width: 8),
              //             const Text(
              //               'Рассрочка Тинькофф',
              //               style: TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //           ],
              //         ),
              //         Checkbox(
              //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              //           checkColor: Colors.white,
              //           activeColor: AppColors.kPrimaryColor,
              //           value: isCheckedTinkoff,
              //           onChanged: (bool? value) {
              //             Get.snackbar('Нет доступа', 'данная оплата пока недоступно...',
              //                 backgroundColor: Colors.orangeAccent);
              //             // setState(() {
              //             //   isCheckedTinkoff = value!;
              //             //   isCheckedPart = false;
              //             //   isCheckedHalal = false;
              //             // });
              //           },
              //         ),
              //       ],
              //     )),
              // const SizedBox(height: 1),

              // Container(
              //     padding: const EdgeInsets.only(left: 16, right: 16),
              //     alignment: Alignment.center,
              //     color: Colors.white,
              //     height: 55,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Row(
              //           children: [
              //             Image.asset(
              //               'assets/icons/part.png',
              //               height: 34,
              //               width: 34,
              //             ),
              //             const SizedBox(width: 8),
              //             const Text(
              //               'Долями',
              //               style: TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //           ],
              //         ),
              //         Checkbox(
              //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              //           checkColor: Colors.white,
              //           activeColor: AppColors.kPrimaryColor,
              //           value: isCheckedPart,
              //           onChanged: (bool? value) {
              //             Get.snackbar('Нет доступа', 'данная оплата пока недоступно...',
              //                 backgroundColor: Colors.orangeAccent);

              //             // setState(() {
              //             //   isCheckedTinkoff = false;
              //             //   isCheckedPart = value!;
              //             //   isCheckedHalal = false;
              //             // });
              //           },
              //         ),
              //       ],
              //     )),
              // const SizedBox(height: 1),
              // Container(
              //     padding: const EdgeInsets.only(left: 16, right: 16),
              //     alignment: Alignment.center,
              //     color: Colors.white,
              //     height: 55,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Row(
              //           children: [
              //             Image.asset(
              //               'assets/icons/halal_installment plan.png',
              //               height: 34,
              //               width: 34,
              //             ),
              //             const SizedBox(width: 8),
              //             const Text(
              //               'Рассрочка Halal',
              //               style: TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //           ],
              //         ),
              //         Checkbox(
              //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              //           checkColor: Colors.white,
              //           activeColor: AppColors.kPrimaryColor,
              //           value: isCheckedHalal,
              //           onChanged: (bool? value) {
              //             // Get.snackbar('Нет доступа',
              //             //     'данная оплата пока недоступно...',
              //             //     backgroundColor: Colors.orangeAccent);

              //             setState(() {
              //               isCheckedTinkoff = false;
              //               isCheckedOnline = false;
              //               isCheckedCash = false;
              //               isCheckedPart = false;
              //               isCheckedHalal = value!;
              //             });
              //           },
              //         ),
              //       ],
              //     )),

              // const SizedBox(height: 1),
              GestureDetector(
                onTap: () {
                  Get.to(const ContractOfSale());
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 8, left: 16),
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: const TextSpan(
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Нажимая «Оформить заказ», вы принимаете\nусловия ",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        TextSpan(
                          text: "Типового договора купли-продажи\n",
                          style: TextStyle(fontSize: 16, color: AppColors.kPrimaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 57,
              ),
            ],
          ),
        ]);
      }),
      bottomSheet: BlocConsumer<orderCubit.OrderCubit, orderCubit.OrderState>(listener: (context, state) {
        if (state is orderCubit.LoadedState) {
          context.router.push(PaymentWebviewRoute(url: state.url));
        }
      }, builder: (context, state) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          child: InkWell(
            onTap: () async {
              if (isCheckedHalal == true) {
                Get.to(CreditInfoDetailPage(
                  title: 'Рассрочка Halal',
                ));
              } else if (isCheckedOnline == true) {
                BlocProvider.of<orderCubit.OrderCubit>(context).payment(
                    address: widget.address.toString(),
                    bonus: isSwitched == true ? (bonus < (price * 0.1) ? bonus : (price * 0.1)).toString() : '0');
              } else {
                Get.snackbar('Ошибка', 'Выберите способ оплаты', backgroundColor: Colors.redAccent);
              }

              // Navigator.pop(context);
            },
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.kPrimaryColor,
                ),
                width: MediaQuery.of(context).size.width,
                child: state is orderCubit.LoadingState
                    ? const SizedBox(height: 51, child: Center(child: CircularProgressIndicator.adaptive()))
                    : const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Оформить заказ',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      )),
          ),
        );
      }),
    );
  }
}
