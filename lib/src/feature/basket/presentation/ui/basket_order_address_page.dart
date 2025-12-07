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
import 'package:haji_market/src/feature/basket/presentation/widgets/show_alert_basket_widget.dart';
import 'package:haji_market/src/feature/basket/presentation/widgets/show_alert_country_widget.dart';
import 'package:haji_market/src/feature/drawer/bloc/country_cubit.dart' as countryCubit;
import 'package:haji_market/src/feature/drawer/bloc/order_cubit.dart' as orderCubit;
import 'package:haji_market/src/feature/drawer/data/models/address_model.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/metas_webview.dart';
import 'package:haji_market/src/feature/home/data/model/city_model.dart';
import 'package:intl/intl.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/bloc/navigation_cubit/navigation_cubit.dart'
    as navCubit;
import 'package:haji_market/src/feature/basket/bloc/basket_cubit.dart';
import 'package:haji_market/src/feature/basket/bloc/basket_state.dart';
import 'package:haji_market/src/feature/home/bloc/meta_cubit.dart' as metaCubit;
import 'package:haji_market/src/feature/home/bloc/meta_state.dart' as metaState;

@RoutePage()
class BasketOrderAddressPage extends StatefulWidget {
  final String? deleveryDay;
  final String? office;

  const BasketOrderAddressPage({this.deleveryDay, this.office, super.key});

  @override
  State<BasketOrderAddressPage> createState() => _BasketOrderAddressPageState();
}

class _BasketOrderAddressPageState extends State<BasketOrderAddressPage> {
  bool courier = false;
  bool point = true;
  bool shop = false;
  bool fbs = false;
  AddressModel? address;

  String? addressLine;
  String? phoneText;

  int segmentValue = 0;

  String? office;

  void getAddress(AddressModel addressItem) {
    final a = addressItem;
    final parts = <String>[
      if ((a.city ?? '').isNotEmpty) a.city!,
      if ((a.street ?? '').isNotEmpty) a.street!,
      if ((a.home ?? '').isNotEmpty) a.home!,
      if ((a.entrance ?? '').isNotEmpty) 'подъезд ${a.entrance!}',
      if ((a.floor ?? '').isNotEmpty) 'этаж ${a.floor!}',
      if ((a.apartament ?? '').isNotEmpty) 'кв. ${a.apartament!}',
    ];
    addressLine = parts.join(', ');

    phoneText = _formatKzPhone(a.phone);

    setState(() {});
    // address =
    // "${(GetStorage().read('country') ?? '*') + ', г. ' + (GetStorage().read('city') ?? '*') + ', ул. ' + (GetStorage().read('street') ?? '*') + ', дом ' + (GetStorage().read('home') ?? '*') + ',подъезд ' + (GetStorage().read('porch') ?? '*') + ',этаж ' + (GetStorage().read('floor') ?? '*') + ',кв ' + (GetStorage().read('room') ?? '*')}";
  }

  String _formatKzPhone(String? input) {
    if (input == null || input.trim().isEmpty) return '+0 (000) 000-00-00';
    // Оставляем только цифры
    var d = input.replaceAll(RegExp(r'\D'), '');

    // Приводим 8XXXXXXXXXX → 7XXXXXXXXXX
    if (d.startsWith('8')) d = '7${d.substring(1)}';

    // Если нет кода страны — добавим 7
    if (!d.startsWith('7')) d = '7$d';

    // Нужно минимум 11 цифр (включая код страны)
    if (d.length < 11) return '+$d';

    final c = d[0]; // 7
    final p1 = d.substring(1, 4); // XXX
    final p2 = d.substring(4, 7); // XXX
    final p3 = d.substring(7, 9); // XX
    final p4 = d.substring(9, 11); // XX

    return '+$c ($p1) $p2-$p3-$p4';
  }

  String formatPrice(int price) {
    final format = NumberFormat('#,###', 'ru_RU');
    return format.format(price).replaceAll(',', ' ');
  }

  List<int> basketIds = [];
  String? productNames;

  CityModel? city;
  CityModel? loadCity() {
    final data = GetStorage().read('city');
    if (data == null) return null;

    if (data is! Map<String, dynamic>) {
      return null;
    }

    return CityModel.fromStorageJson(Map<String, dynamic>.from(data));
  }

  @override
  void initState() {
    basketData();
    city = loadCity();

    if (State is! metaState.LoadedState) {
      BlocProvider.of<metaCubit.MetaCubit>(context).partners();
    }
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
  List textInst = ['3 мес', '6 мес', '9 мес', '12 мес'];
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
      AppSnackBar.show(context, 'У вас нет бонусов от этого магазина', type: AppSnackType.error);
    }
  }

  List<String> metas = [
    'Пользовательское соглашение',
    'Оферта для продавцов',
    'Политика конфиденциальности',
    'Типовой договор купли-продажи',
    'Типовой договор на оказание рекламных услуг',
  ];

  List<String> metasBody = [];

  Future<void> basket(BasketState state) async {
    if (state is LoadedState) {
      for (var element in state.basketShowModel) {
        basketIds.add(element.basketId!.toInt());
        count += element.basketCount ?? 0;
        price += (element.product?.price ?? 0) * (element.basketCount ?? 0);
        bonus += element.userBonus ?? 0;

        if (element.fulfillment == 'fbs') courierPrice += element.deliveryPrice ?? 0;
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

  String getTotalCompound(BasketState state) {
    int total = 0;

    if (state is LoadedState) {
      for (final item in state.basketShowModel) {
        // final int price = item.product?.price?.toInt() ?? 0;
        // final int percent = item.product?.compound?.toInt() ?? 0;

        // print(item.product?.compound);

        // final int discounted =
        //     (price * (100 - percent) / 100).round(); // тут округляем в конце

        total += (item.product?.compound?.toInt() ?? 0) * (item?.basketCount ?? 1);
      }

      return formatPrice(total);
    } else {
      return '....';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        surfaceTintColor: AppColors.kWhite,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            await BlocProvider.of<BasketCubit>(context).basketBackSelectProducts();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.kLightBlackColor),
        ),
        title: const Text('Оформление заказа', style: AppTextStyles.appBarTextStylea),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Column(
            children: [
              Container(color: AppColors.kWhite),
              Container(
                padding: const EdgeInsets.only(top: 0, left: 16, bottom: 12, right: 16),
                child: CustomSwitchButton<int>(
                  groupValue: segmentValue,
                  backgroundColor: Color(0xFFeaeced),
                  thumbColor: AppColors.kWhite,
                  children: {
                    0: Container(
                      alignment: Alignment.center,
                      height: 36,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        'Самовывоз',
                        style: AppTextStyles.size14Weight500.copyWith(
                          color: segmentValue == 0 ? Colors.black : const Color(0xff646466),
                        ),
                      ),
                    ),
                    1: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      height: 36,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        'Курьером',
                        style: AppTextStyles.size14Weight500.copyWith(
                          color: segmentValue == 1 ? Colors.black : const Color(0xff646466),
                        ),
                      ),
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
      body: BlocConsumer<BasketCubit, BasketState>(
        listener: (context, state) {
          if (state is OrderState) {
            BlocProvider.of<navCubit.NavigationCubit>(
              context,
            ).getNavBarItem(const navCubit.NavigationState.home());
            // Get.to(const Base(index: 1));
            context.router.popUntil((route) => route.settings.name == LauncherRoute.name);
          }
        },
        builder: (context, state) {
          if (state is ErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(fontSize: 20.0, color: Colors.grey),
              ),
            );
          }

          if (state is LoadedState) {
            return ListView(
              children: [
                const SizedBox(height: 12),
                segmentValue == 0
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        height: 88,
                        child: Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Адрес доставки', style: AppTextStyles.size18Weight600),
                                const SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 32,
                                      width: 32,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.mainBackgroundPurpleColor,
                                      ),
                                      child: Image.asset(Assets.icons.location.path, scale: 2.1),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (!GetStorage().hasData('city')) {
                                            Future.wait([
                                              BlocProvider.of<countryCubit.CountryCubit>(
                                                context,
                                              ).country(),
                                            ]);
                                            showAlertCountryWidget(context, () {
                                              setState(() {});
                                            }, false);

                                            return;
                                          }

                                          print(city.toString());

                                          print(city?.lat.toString());
                                          print(city?.long.toString());

                                          // ждём результат от карты
                                          final result =
                                              await context.router.push(
                                                    MapPickerRoute(
                                                      cc: city?.code ?? 4756,
                                                      lat: city?.lat ?? 43.238949,
                                                      long: city?.long ?? 76.889709,
                                                    ),
                                                  )
                                                  as String?;

                                          if (!mounted) return;

                                          if (result != null) {
                                            setState(() {
                                              office = result;
                                              point = true;
                                            });
                                          }
                                        },
                                        child: Text(
                                          office ?? 'Изменить адрес самовывоза',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyles.size16Weight500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Image.asset(
                                      Assets.icons.defaultArrowForwardIcon.path,
                                      scale: 1.9,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                segmentValue == 1
                    ? Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        height: phoneText != null ? 99 : 88,
                        width: MediaQuery.of(context).size.width,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              final result = await context.router.push(AddressRoute(select: true));

                              if (result is AddressModel) {
                                setState(() {
                                  address = result;
                                });

                                getAddress(address!);
                              }

                              // Future.wait([
                              //   BlocProvider.of<AddressCubit>(context).address()
                              // ]);
                              // showAlertAddressWidget(context, () {
                              //   getAddress();
                              //   setState(() {});
                              // });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Aдрес доставки', style: AppTextStyles.size18Weight600),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 32,
                                        width: 32,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: AppColors.mainBackgroundPurpleColor,
                                        ),
                                        child: Image.asset(Assets.icons.location.path, scale: 2.1),
                                      ),
                                      SizedBox(width: 12),
                                      SizedBox(
                                        width: 278,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Заголовок адреса
                                            Text(
                                              addressLine ?? 'Изменить адрес доставки',
                                              style: AppTextStyles.size16Weight500,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),

                                            phoneText != null
                                                ? const SizedBox(height: 4)
                                                : SizedBox.shrink(),

                                            phoneText != null
                                                ? Text(
                                                    phoneText ?? '+0(000)000-00-00',
                                                    style: AppTextStyles.size14Weight400.copyWith(
                                                      color: Color(0xff8E8E93),
                                                    ),
                                                  )
                                                : SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Image.asset(
                                        Assets.icons.defaultArrowForwardIcon.path,
                                        scale: 1.9,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                const SizedBox(height: 8),
                BlocBuilder<BasketCubit, BasketState>(
                  builder: (context, state) {
                    if (state is LoadedState) {
                      return SizedBox(
                        height: (169 * state.basketShowModel.length).toDouble(),
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
                                        topRight: Radius.circular(12),
                                      ),
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
                                        bottomRight: Radius.circular(16),
                                      ),
                                    ),
                                    padding: EdgeInsets.only(left: 16),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 8),
                                        Text(
                                          '${state.basketShowModel[index].basketCount} товар(a)',
                                          style: AppTextStyles.size14Weight500.copyWith(
                                            color: Color(0xff8E8E93),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Container(
                                          height: 54,
                                          width: 54,
                                          decoration: BoxDecoration(
                                            color: AppColors.kWhite,
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                12,
                                              ), // Slightly smaller than container
                                              child: Image.network(
                                                state.basketShowModel[index].image != null
                                                    ? "https://lunamarket.ru/storage/${state.basketShowModel[index].image!.first}"
                                                    : "https://lunamarket.ru/storage/banners/2.png",
                                                fit: BoxFit.cover,
                                                loadingBuilder: (context, child, loadingProgress) {
                                                  if (loadingProgress == null) return child;
                                                  return Container(
                                                    color: Colors.grey[100],
                                                    child: Center(
                                                      child: CircularProgressIndicator(
                                                        value:
                                                            loadingProgress.expectedTotalBytes !=
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
                                                errorBuilder: (context, error, stackTrace) =>
                                                    Container(
                                                      color: Colors.grey[100],
                                                      child: const Icon(
                                                        Icons.broken_image,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          '${formatPrice(state.basketShowModel[index].price!)} ₽',
                                          style: AppTextStyles.size11Weight400.copyWith(
                                            color: Color(0xff8f8f94),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 14, bottom: 16),
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'Сумма заказа',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$count товаров',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            " ${formatPrice(price)} ₽",
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Скидка',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Color(0xFF7D2DFF), Color(0xFF41DDFF)],
                            ).createShader(bounds),
                            child: Text(
                              '- ${getTotalCompound(state)} ₽',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -1,
                                color: Colors.white, // Неважно — будет заменён градиентом
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Доставка',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '${courierPrice == 0 ? 'Без доплат' : formatPrice(courierPrice)} ${courierPrice != 0 ? '₽' : ''} ',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      SizedBox(
                        height: 1,
                        child: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
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
                                    decoration: BoxDecoration(color: AppColors.kGray300),
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
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
                                  activeTrackColor: AppColors.mainBackgroundPurpleColor,
                                  inactiveThumbColor: Colors.white,
                                  inactiveTrackColor: AppColors.kBackgroundColor,
                                  trackOutlineColor: const WidgetStatePropertyAll<Color>(
                                    Colors.white,
                                  ),
                                  thumbColor: const WidgetStatePropertyAll<Color>(Colors.white),
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
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 1,
                        child: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
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
                                    decoration: BoxDecoration(color: AppColors.kGray300),
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Итого', style: AppTextStyles.size18Weight600),
                          Text(
                            ' ${isSwitched == true ? formatPrice((bonus < (price * 0.1) ? ((price - bonus) + courierPrice) : ((price - price * 0.1) + courierPrice)).toInt()) : formatPrice(courierPrice + price)} ₽',
                            style: AppTextStyles.size18Weight700,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
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
                SizedBox(height: 140),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
          }
        },
      ),
      bottomSheet: BlocConsumer<orderCubit.OrderCubit, orderCubit.OrderState>(
        listener: (context, state) {
          if (state is orderCubit.LoadedState) {
            context.router.push(PaymentWebviewRoute(url: state.url));
          }
        },
        builder: (context, state) {
          return SafeArea(
            bottom: false,
            child: Container(
              height: 175,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              padding: const EdgeInsets.only(left: 23, right: 23, bottom: 8, top: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$count товаров', style: AppTextStyles.size16Weight500),
                      Text(
                        '${isSwitched == true ? formatPrice((bonus < (price * 0.1) ? ((price - bonus) + courierPrice) : ((price - price * 0.1) + courierPrice)).toInt()) : formatPrice(courierPrice + price)} ₽',
                        style: AppTextStyles.size16Weight500,
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle),
                      SizedBox(width: 8),
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
                                Get.to(() => MetasPage(title: metas[3], body: metasBody[3]));
                              },
                              child: RichText(
                                textAlign: TextAlign.left,
                                text: TextSpan(
                                  style: AppTextStyles.size14Weight400,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "Нажимая «Оплатить», вы принимаете\nусловия ",
                                      style: AppTextStyles.size14Weight400.copyWith(
                                        color: Color(0xff8E8E93),
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Типового договора купли-продажи\n",
                                      style: AppTextStyles.size14Weight400.copyWith(
                                        color: AppColors.mainPurpleColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return RichText(
                              textAlign: TextAlign.left,
                              text: const TextSpan(
                                style: TextStyle(fontSize: 16, color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Нажимая «Оплатить», вы принимаете\nусловия ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.kGray300,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Типового договора купли-продажи\n",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.mainPurpleColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      if (point == false && courier == false && shop == false) {
                        await showBasketAlert(
                          context,
                          title: null,
                          message: 'Выберите способ доставки',
                          // mode: BrandedAlertMode.acknowledge,
                          primaryText: 'Понятно',
                          // если нужен свой градиент:
                          // primaryGradient: const LinearGradient(colors: [Color(0xFF7B61FF), Color(0xFF8C52FF)]),
                        );
                        return;
                      }

                      if (point == true) {
                        if (office == null) {
                          await showBasketAlert(
                            context,
                            title: null,
                            message: 'Выберите адрес самовывоза',
                            // mode: BrandedAlertMode.acknowledge,
                            primaryText: 'Понятно',
                            // если нужен свой градиент:
                            // primaryGradient: const LinearGradient(colors: [Color(0xFF7B61FF), Color(0xFF8C52FF)]),
                          );
                          return;
                        }
                      }

                      if (courier == true) {
                        if (address == null) {
                          await showBasketAlert(
                            context,
                            title: null,
                            message: 'Напишите адрес для курьера',
                            // mode: BrandedAlertMode.acknowledge,
                            primaryText: 'Понятно',
                            // если нужен свой градиент:
                            // primaryGradient: const LinearGradient(colors: [Color(0xFF7B61FF), Color(0xFF8C52FF)]),
                          );
                          return;
                        }
                      }

                      if (shop == true) {
                        if (address == null) {
                          await showBasketAlert(
                            context,
                            title: null,
                            message: 'Напишите адрес для курьера',
                            // mode: BrandedAlertMode.acknowledge,
                            primaryText: 'Понятно',
                            // если нужен свой градиент:
                            // primaryGradient: const LinearGradient(colors: [Color(0xFF7B61FF), Color(0xFF8C52FF)]),
                          );
                          return;
                        }
                      }

                      BlocProvider.of<orderCubit.OrderCubit>(context).payment(
                        context: context,
                        basketIds: basketIds,
                        address: addressLine,
                        bonus: isSwitched == true
                            ? (bonus < (price * 0.1) ? bonus : (price * 0.1)).toString()
                            : '0',
                        fulfillment: 'fbs',
                      );
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
                          ? Center(child: CircularProgressIndicator.adaptive())
                          : Text(
                              'Оплатить',
                              style: AppTextStyles.size18Weight600.copyWith(
                                color: AppColors.kWhite,
                              ),
                              textAlign: TextAlign.center,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
