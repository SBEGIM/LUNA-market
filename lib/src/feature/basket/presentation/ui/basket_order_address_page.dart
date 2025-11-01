import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/core/presentation/widgets/other/custom_switch_button.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/basket/data/models/basket_show_model.dart';
import 'package:haji_market/src/feature/basket/presentation/widgets/show_alert_country_basket_widget.dart';
import 'package:haji_market/src/feature/drawer/bloc/address_cubit.dart';
import 'package:haji_market/src/feature/drawer/bloc/country_cubit.dart'
    as countryCubit;
import 'package:haji_market/src/feature/drawer/bloc/order_cubit.dart'
    as orderCubit;
import 'package:haji_market/src/feature/drawer/presentation/widgets/metas_webview.dart';
import 'package:intl/intl.dart';
import '../../../../core/common/constants.dart';
import '../../../app/bloc/navigation_cubit/navigation_cubit.dart' as navCubit;
import '../../bloc/basket_cubit.dart';
import '../../bloc/basket_state.dart';
import '../widgets/show_alert_statictics_widget.dart';
import 'package:haji_market/src/feature/home/bloc/meta_cubit.dart' as metaCubit;
import 'package:haji_market/src/feature/home/bloc/meta_state.dart' as metaState;

@RoutePage()
class BasketOrderAddressPage extends StatefulWidget {
  final String? deleveryDay;
  final String? office;

  const BasketOrderAddressPage({this.deleveryDay, this.office, Key? key})
      : super(key: key);

  @override
  _BasketOrderAddressPageState createState() => _BasketOrderAddressPageState();
}

class _BasketOrderAddressPageState extends State<BasketOrderAddressPage> {
  bool courier = false;
  bool point = false;
  bool shop = false;
  bool fbs = false;
  String address = 'Изменить адрес доставки';
  int segmentValue = 0;

  String? office;

  void getAddress() {
    address =
        "${(GetStorage().read('country') ?? '*') + ', г. ' + (GetStorage().read('city') ?? '*') + ', ул. ' + (GetStorage().read('street') ?? '*') + ', дом ' + (GetStorage().read('home') ?? '*') + ',подъезд ' + (GetStorage().read('porch') ?? '*') + ',этаж ' + (GetStorage().read('floor') ?? '*') + ',кв ' + (GetStorage().read('room') ?? '*')}";
  }

  String formatPrice(int price) {
    final format = NumberFormat('#,###', 'ru_RU');
    return format.format(price).replaceAll(',', ' ');
  }

  List<int> id = [];
  String? productNames;

  @override
  void initState() {
    basketData();

    if (State is! metaState.LoadedState) {
      BlocProvider.of<metaCubit.MetaCubit>(context).partners();
    }
    getAddress();
    if (widget.office != null) {
      office = widget.office;
    }
    super.initState();
  }

  ///
  bool isCheckedOnline = true;
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
  int courierPrice = 0;
  int bs = 0;
  int bonus = 0;
  int count = 0;

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
      Get.snackbar('Ошибка', 'У вас нет бонусов от этого магазина',
          backgroundColor: Colors.blueAccent);
    }
  }

  List<String> metas = [
    'Пользовательское соглашение',
    'Оферта для продавцов',
    'Политика конфиденциальности',
    'Типовой договор купли-продажи',
    'Типовой договор на оказание рекламных услуг'
  ];

  List<String> metasBody = [];

  Future<void> basket(BasketState state) async {
    if (state is LoadedState) {
      for (var element in state.basketShowModel) {
        id.add(element.basketId!.toInt());
        count += element.basketCount ?? 0;
        price += element.price ?? 0;
        bonus += element.userBonus ?? 0;

        if (element.fulfillment == 'fbs')
          courierPrice += element.deliveryPrice ?? 0;
        productNames =
            "${productNames != null ? "$productNames ," : ''}  $kDeepLinkUrl/?product_id\u003d${element.product!.id}";
      }
      bs = (price * 0.05).toInt();
    }
  }

  Future<void> basketData() async {
    basket(BlocProvider.of<BasketCubit>(context).state);
  }

  String getTotalCount(BasketState state) {
    int totalCount = 0;
    if (state is LoadedState) {
      for (final BasketShowModel basketItem in state.basketShowModel) {
        totalCount += basketItem.basketCount ?? 0;
      }
      return totalCount.toString();
    } else {
      return '....';
    }
  }

  String getTotalPrice(BasketState state) {
    int totalPrice = 0;
    if (state is LoadedState) {
      for (final BasketShowModel basketItem in state.basketShowModel) {
        totalPrice += basketItem.price ?? 0;
      }
      return formatPrice(totalPrice);
    } else {
      return '....';
    }
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
              color: AppColors.kLightBlackColor,
            ),
          ),
          title: const Text(
            'Оформление заказа',
            style: AppTextStyles.appBarTextStylea,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Column(
              children: [
                Container(
                  color: AppColors.kWhite,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 0,
                    left: 16,
                    bottom: 12,
                    right: 16,
                  ),
                  child: CustomSwitchButton<int>(
                    groupValue: segmentValue,
                    backgroundColor: Color(0xffEAECED),
                    thumbColor: AppColors.kWhite,
                    children: {
                      0: Container(
                        alignment: Alignment.center,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('Самовывоз',
                            style: AppTextStyles.size14Weight500.copyWith(
                                color: segmentValue == 0
                                    ? Colors.black
                                    : const Color(0xff636366))),
                      ),
                      1: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text('Курьером',
                            style: AppTextStyles.size14Weight500.copyWith(
                                color: segmentValue == 1
                                    ? Colors.black
                                    : const Color(0xff636366))),
                      ),
                    },
                    onValueChanged: (int? value) async {
                      segmentValue = value!;
                      if (segmentValue == 0) {
                        courier = false;
                        shop = false;
                        point = true;
                        fbs = false;
                      } else {
                        courier = true;
                        shop = false;
                        point = false;
                        fbs = false;
                      }
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body:
            BlocConsumer<BasketCubit, BasketState>(listener: (context, state) {
          if (state is OrderState) {
            BlocProvider.of<navCubit.NavigationCubit>(context)
                .getNavBarItem(const navCubit.NavigationState.home());
            // Get.to(const Base(index: 1));
            context.router
                .popUntil((route) => route.settings.name == LauncherRoute.name);
          }
        }, builder: (context, state) {
          if (state is ErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(fontSize: 20.0, color: Colors.grey),
              ),
            );
          }

          if (state is LoadedState) {
            return ListView(children: [
              const SizedBox(height: 12),
              segmentValue == 0
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      height: 88,
                      child: Material(
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Адрес доставки',
                                  style: AppTextStyles.size18Weight600,
                                ),
                                const SizedBox(height: 8),
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 32,
                                        width: 32,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: AppColors
                                                .mainBackgroundPurpleColor),
                                        child: Image.asset(
                                          Assets.icons.location.path,
                                          scale: 2.1,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      GestureDetector(
                                        onTap: () async {
                                          //  final data = await Get.to(() => const Mapp());
                                          // final data = '';
                                          Future.wait([
                                            BlocProvider.of<
                                                    countryCubit
                                                    .CountryCubit>(context)
                                                .country()
                                          ]);
                                          showAlertCountryBasketWidget(context,
                                              () {
                                            // context.router.pop();
                                            // setState(() {});
                                          }, true);
                                          // office = data;
                                          setState(() {});
                                        },
                                        child: Text(
                                          office ?? 'Изменить адрес самовывоза',
                                          style: AppTextStyles.size16Weight500,
                                        ),
                                      ),
                                      Spacer(),
                                      Image.asset(
                                        Assets
                                            .icons.defaultArrowForwardIcon.path,
                                        scale: 1.9,
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              segmentValue == 1
                  ? Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      height: 88,
                      width: MediaQuery.of(context).size.width,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Future.wait([
                              BlocProvider.of<AddressCubit>(context).address()
                            ]);
                            showAlertAddressWidget(context, () {
                              getAddress();
                              setState(() {});
                            });
                          },
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 16, right: 16, top: 8),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Aдрес доставки',
                                      style: AppTextStyles.size18Weight600),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 32,
                                        width: 32,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: AppColors
                                                .mainBackgroundPurpleColor),
                                        child: Image.asset(
                                          Assets.icons.location.path,
                                          scale: 2.1,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      SizedBox(
                                        width: 278,
                                        child: Text(
                                          address,
                                          style: AppTextStyles.size16Weight500,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Spacer(),
                                      Image.asset(
                                        Assets
                                            .icons.defaultArrowForwardIcon.path,
                                        scale: 1.9,
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              const SizedBox(height: 8),
              BlocBuilder<BasketCubit, BasketState>(builder: (context, state) {
                if (state is LoadedState) {
                  return SizedBox(
                    height: (175 * state.basketShowModel.length).toDouble(),
                    width: double.infinity,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: state.basketShowModel.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(top: 8),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 38,
                                  width: double.infinity,
                                  padding: EdgeInsets.only(left: 16),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 190, 0, 0.2),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12)),
                                  ),
                                  child: Text(
                                    'Дата доставки: ${state.basketShowModel[index].deliveryDay} дня',
                                    style: AppTextStyles.size16Weight500,
                                  ),
                                ),
                                Container(
                                  height: 123,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: AppColors.kWhite,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(16),
                                        bottomRight: Radius.circular(16)),
                                  ),
                                  padding: EdgeInsets.only(left: 16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8),
                                      Text('1 товар(a)',
                                          style: AppTextStyles.size14Weight500
                                              .copyWith(
                                                  color: Color(0xff8E8E93))),
                                      SizedBox(height: 8),
                                      Container(
                                        height: 54,
                                        width: 54,
                                        decoration: BoxDecoration(
                                          color: AppColors.kWhite,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                12), // Slightly smaller than container
                                            child: Image.network(
                                              state.basketShowModel[index]
                                                          .image !=
                                                      null
                                                  ? "https://lunamarket.ru/storage/${state.basketShowModel[index].image!.first}"
                                                  : "https://lunamarket.ru/storage/banners/2.png",
                                              fit: BoxFit.cover,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Container(
                                                  color: Colors.grey[100],
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              loadingProgress
                                                                  .expectedTotalBytes!
                                                          : null,
                                                      strokeWidth: 2,
                                                    ),
                                                  ),
                                                );
                                              },
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Container(
                                                color: Colors.grey[100],
                                                child: const Icon(
                                                    Icons.broken_image,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                          '${formatPrice(state.basketShowModel[index].price!)} ₽',
                                          style: AppTextStyles.size11Weight400
                                              .copyWith(
                                                  color: Color(0xff8E8E93))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 16),
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Сумма заказа',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$count товаров',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "$price ₽",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Скидка',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Color(0xFF7D2DFF), Color(0xFF41DDFF)],
                          ).createShader(bounds),
                          child: Text(
                            '- ${courierPrice} ₽',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -1,
                              color: Colors
                                  .white, // Неважно — будет заменён градиентом
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Доставка',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Без доплат',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.green),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 1,
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          const dashWidth = 5.0;
                          final dashHeight = 0.5;
                          final dashCount = 30;
                          return Flex(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            direction: Axis.horizontal,
                            children: List.generate(dashCount, (_) {
                              return SizedBox(
                                width: dashWidth,
                                height: dashHeight,
                                child: DecoratedBox(
                                  decoration:
                                      BoxDecoration(color: AppColors.kGray300),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Switch(
                                value: isSwitched,
                                onChanged: toggleSwitch,
                                activeColor: AppColors.mainPurpleColor,
                                activeTrackColor:
                                    AppColors.mainBackgroundPurpleColor,
                                inactiveThumbColor: Colors.white,
                                inactiveTrackColor: AppColors.kBackgroundColor,
                                trackOutlineColor:
                                    const WidgetStatePropertyAll<Color>(
                                        Colors.white),
                                thumbColor: const WidgetStatePropertyAll<Color>(
                                    Colors.white),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Потратить бонусы',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Накоплено $bonus Б',
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
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 1,
                      child: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          const dashWidth = 5.0;
                          final dashHeight = 0.5;
                          final dashCount = 30;
                          return Flex(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            direction: Axis.horizontal,
                            children: List.generate(dashCount, (_) {
                              return SizedBox(
                                width: dashWidth,
                                height: dashHeight,
                                child: DecoratedBox(
                                  decoration:
                                      BoxDecoration(color: AppColors.kGray300),
                                ),
                              );
                            }),
                          );
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Итого',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            ' ${isSwitched == true ? (bonus < (price * 0.1) ? ((price - bonus) + courierPrice) : ((price - price * 0.1) + courierPrice)).toInt() : (courierPrice + price)} ₽',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ]),
                    SizedBox(height: 16)

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const Text(
                    //       'Онлайн оплата',
                    //       style: TextStyle(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w400,
                    //       ),
                    //     ),
                    //     Checkbox(
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(4)),
                    //       checkColor: Colors.white,
                    //       activeColor: AppColors.mainPurpleColor,
                    //       value: isCheckedOnline,
                    //       onChanged: (bool? value) {
                    //         setState(() {
                    //           isCheckedTinkoff = false;
                    //           isCheckedOnline = value!;
                    //           isCheckedCash = false;
                    //           isCheckedPart = false;
                    //           isCheckedHalal = false;
                    //         });
                    //       },
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(height: 1),
                  ],
                ),
              ),
            ]);
          } else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent));
          }
        }),
        bottomSheet: BlocConsumer<orderCubit.OrderCubit, orderCubit.OrderState>(
            listener: (context, state) {
          if (state is orderCubit.LoadedState) {
            context.router.push(PaymentWebviewRoute(url: state.url));
          }
        }, builder: (context, state) {
          return SafeArea(
            bottom: false,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              padding:
                  const EdgeInsets.only(left: 23, right: 23, bottom: 8, top: 8),
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       '$count товаров',
                  //       style: AppTextStyles.size16Weight500,
                  //     ),
                  //     Text(
                  //       "$price ₽",
                  //       style: AppTextStyles.size16Weight500,
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle),
                      SizedBox(
                        width: 8,
                      ),
                      BlocBuilder<metaCubit.MetaCubit, metaState.MetaState>(
                          builder: (context, state) {
                        if (state is metaState.LoadedState) {
                          metasBody.addAll([
                            state.metas.terms_of_use!,
                            state.metas.privacy_policy!,
                            state.metas.contract_offer!,
                            state.metas.shipping_payment!,
                            state.metas.TTN!,
                          ]);
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => MetasPage(
                                    title: metas[3],
                                    body: metasBody[3],
                                  ));
                            },
                            child: RichText(
                              textAlign: TextAlign.left,
                              text: const TextSpan(
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        "Нажимая «Оплатить», вы принимаете\nусловия ",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.kGray300,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text: "Типового договора купли-продажи\n",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.mainPurpleColor),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.indigoAccent));
                        }
                      }),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      if (point == false && courier == false && shop == false) {
                        AppSnackBar.show(
                          context,
                          'Выберите способ доставки',
                          type: AppSnackType.error,
                        );
                        return;
                      }

                      if (point == true) {
                        if (office == null) {
                          AppSnackBar.show(
                            context,
                            'Выберите адрес самовывоза',
                            type: AppSnackType.error,
                          );
                          return;
                        }
                      }

                      if (courier == true) {
                        if (address.isEmpty) {
                          AppSnackBar.show(
                            context,
                            'Напишите адрес для курьера',
                            type: AppSnackType.error,
                          );
                          return;
                        }
                      }

                      if (shop == true) {
                        if (address.isEmpty) {
                          AppSnackBar.show(
                            context,
                            'Напишите адрес для курьера',
                            type: AppSnackType.error,
                          );
                          return;
                        }
                      }

                      BlocProvider.of<orderCubit.OrderCubit>(context).payment(
                          address: address,
                          bonus: isSwitched == true
                              ? (bonus < (price * 0.1) ? bonus : (price * 0.1))
                                  .toString()
                              : '0',
                          fulfillment: 'fbs');
                    },
                    child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.mainPurpleColor,
                        ),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: state is orderCubit.LoadingState
                            ? Center(
                                child: CircularProgressIndicator.adaptive())
                            : Text(
                                'Оплатить',
                                style: AppTextStyles.size18Weight600
                                    .copyWith(color: AppColors.kWhite),
                                textAlign: TextAlign.center,
                              )),
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
