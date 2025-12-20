import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/drawer/bloc/order_cubit.dart' as order_cubit;
import 'package:haji_market/src/feature/drawer/presentation/widgets/metas_webview.dart';
import 'package:haji_market/src/feature/home/bloc/meta_cubit.dart' as meta_cubit;
import 'package:haji_market/src/feature/home/bloc/meta_state.dart' as meta_state;
import 'package:share_plus/share_plus.dart';
import '../../../../core/common/constants.dart';
import '../../../app/bloc/navigation_cubit/navigation_cubit.dart' as nav_cubit;
import '../../bloc/basket_cubit.dart';
import '../../bloc/basket_state.dart';
import '../../../drawer/presentation/widgets/credit_info_detail_page.dart';

@RoutePage()
class BasketOrderPage extends StatefulWidget {
  final String? address;
  final bool? fbs;
  final String fulfillment;

  const BasketOrderPage({this.fbs, super.key, this.address, required this.fulfillment});

  @override
  State<BasketOrderPage> createState() => _BasketOrderPageState();
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
  List textInst = ['3 мес', '6 мес', '9 мес', '12 мес'];

  int price = 0;
  int bs = 0;
  int courier = 0;
  int bonus = 0;
  int count = 0;
  String? productNames;

  List<int> basketIds = [];

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('У вас нет бонусов от этого магазина'),
          backgroundColor: Colors.blueAccent,
        ),
      );
    }
  }

  Future<void> basket(BasketState state) async {
    if (state is LoadedState) {
      for (var element in state.basketShowModel) {
        basketIds.add(element.basketId!.toInt());
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
    if (BlocProvider.of<meta_cubit.MetaCubit>(context).state is! meta_state.MetaStateLoaded) {
      BlocProvider.of<meta_cubit.MetaCubit>(context).partners();
    }
    // BlocProvider.of<BasketCubit>(context).basketShow();
    super.initState();
  }

  List<String> metas = [
    'Пользовательское соглашение',
    'Оферта для продавцов',
    'Политика конфиденциальности',
    'Типовой договор купли-продажи',
    'Типовой договор на оказание рекламных услуг',
  ];

  List<String> metasBody = [];

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
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.kPrimaryColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 22.0),
            child: GestureDetector(
              onTap: () async {
                await Share.share('$productNames');
              },
              child: SvgPicture.asset('assets/icons/share.svg'),
            ),
          ),
        ],
        title: const Text(
          'Оплата',
          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: BlocConsumer<BasketCubit, BasketState>(
        listener: (context, state) {
          if (state is OrderState) {
            BlocProvider.of<nav_cubit.NavigationCubit>(
              context,
            ).getNavBarItem(const nav_cubit.NavigationState.home());
            context.router.popUntil((route) => route.settings.name == LauncherRoute.name);
          }
        },
        builder: (context, state) {
          return ListView(
            children: [
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
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '$count товара',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "$price ₽",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 1),
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
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            '$courier ₽',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 1),
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
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            ' ${courier + price} ₽',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 1),
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
                                  activeThumbColor: AppColors.kPrimaryColor,
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
                              ),
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
                    ),
                  ),
                  const SizedBox(height: 8),
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
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            ' ${isSwitched == true ? (bonus < (price * 0.1) ? ((price - bonus) + courier) : ((price - price * 0.1) + courier)).toInt() : (courier + price)} ₽',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
                    ),
                  ),
                  const SizedBox(height: 1),
                  BlocBuilder<meta_cubit.MetaCubit, meta_state.MetaState>(
                    builder: (context, state) {
                      if (state is meta_state.MetaStateLoaded) {
                        metasBody.addAll([
                          state.metas.terms_of_use!,
                          state.metas.privacy_policy!,
                          state.metas.contract_offer!,
                          state.metas.shipping_payment!,
                          state.metas.TTN!,
                        ]);
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MetasPage(title: metas[3], body: metasBody[3]),
                              ),
                            );
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
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.indigoAccent),
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 57),
                ],
              ),
            ],
          );
        },
      ),
      bottomSheet: BlocConsumer<order_cubit.OrderCubit, order_cubit.OrderState>(
        listener: (context, state) {
          if (state is order_cubit.LoadedState) {
            context.router.push(PaymentWebviewRoute(url: state.url));
          }
        },
        builder: (context, state) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
            child: InkWell(
              onTap: () async {
                if (isCheckedHalal == true) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreditInfoDetailPage(title: 'Рассрочка Halal'),
                    ),
                  );
                } else if (isCheckedOnline == true) {
                  BlocProvider.of<order_cubit.OrderCubit>(context).payment(
                    context: context,
                    basketIds: basketIds,
                    address: widget.address.toString(),
                    bonus: isSwitched == true
                        ? (bonus < (price * 0.1) ? bonus : (price * 0.1)).toString()
                        : '0',
                    fulfillment: widget.fulfillment,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Выберите способ оплаты'),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }

                // Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.kPrimaryColor,
                ),
                width: MediaQuery.of(context).size.width,
                child: state is order_cubit.LoadingState
                    ? const SizedBox(
                        height: 51,
                        child: Center(child: CircularProgressIndicator.adaptive()),
                      )
                    : const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Оформить заказ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
