import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/core/presentation/widgets/shimmer/shimmer_box.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/basket/data/models/basket_show_model.dart';
import 'package:haji_market/src/feature/basket/presentation/widgets/basket_card_widget.dart';
import 'package:haji_market/src/feature/basket/presentation/widgets/show_alert_basket_widget.dart';
import 'package:haji_market/src/feature/tape/presentation/widgets/show_alert_report_widget.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import '../../bloc/basket_cubit.dart';
import '../../bloc/basket_state.dart';

@RoutePage()
class BasketPage extends StatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  int count = 0;
  int price = 0;
  String fulfillment = 'FBS';
  String deleveryDay = '';

  final Set<int> isChecked = {};

  String fulfillmentApi = 'FBS';

  String? productNames;

  bool bootSheet = false;
  RefreshController refreshController = RefreshController();

  List<BasketShowModel>? basketItems = [];

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

  String getTotalProductPrice(BasketState state) {
    int totalPrice = 0;
    if (state is LoadedState) {
      for (final BasketShowModel basketItem in state.basketShowModel) {
        totalPrice += (basketItem.product!.price ?? 0) * basketItem.basketCount!;
      }
      return formatPrice(totalPrice);
    } else {
      return '....';
    }
  }

  String getTotalCompound(BasketState state) {
    int compound = 0;
    if (state is LoadedState) {
      for (final BasketShowModel basketItem in state.basketShowModel) {
        compound +=
            basketItem.product!.price!.toInt() *
            (((100 - basketItem.product!.compound!.toInt())) / 100).toInt();
      }
      return formatPrice(compound);
    } else {
      return '....';
    }
  }

  Future<void> basketData({required List<BasketShowModel>? basket}) async {
    basketItems!.addAll(basket!);

    // basket = await BlocProvider.of<BasketCubit>(context).basketData();
    for (var element in basket) {
      count += element.basketCount!.toInt();
      price += element.price!.toInt();

      fulfillment = element.product!.fulfillment ?? 'fbs';

      deleveryDay = element.deliveryDay != null ? element.deliveryDay.toString() : '';

      productNames =
          "${productNames != null ? "${productNames} ," : ''}  $kDeepLinkUrl/?product_id\u003d${element.product!.id}";
    }

    GetStorage().write('bottomCount', count);
    GetStorage().write('bottomPrice', price);

    setState(() {});
  }

  Future<void> basketCount(int basketCount) async {
    count = basketCount;

    setState(() {});
  }

  Future<void> basketPrice(int basketPrice) async {
    price = basketPrice;

    setState(() {});
  }

  Function? bottomPrice;
  Function? bottomCount;
  int segmentValue = 0;

  @override
  void initState() {
    BlocProvider.of<BasketCubit>(context).basketShow();
    bottomPrice = GetStorage().listenKey('bottomPrice', (value) {
      basketPrice(value);
    });
    bottomCount = GetStorage().listenKey('bottomCount', (value) {
      basketCount(value);
    });

    super.initState();
  }

  @override
  void dispose() {
    bottomPrice!.call();
    bottomCount!.call();
    super.dispose();
  }

  String formatPrice(int price) {
    final format = NumberFormat('#,###', 'ru_RU');
    return format.format(price).replaceAll(',', ' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        elevation: 0,
        title: const Text(
          'Корзина',
          style: AppTextStyles.size18Weight600,
          textAlign: TextAlign.center,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(36),
          child: BlocConsumer<BasketCubit, BasketState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is LoadedState) {
                return Container(
                  height: 36,
                  margin: const EdgeInsets.only(bottom: 13),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            // Проверяем: все ли уже выбраны
                            final allSelected = state.basketShowModel.every(
                              (item) => isChecked.contains(item.basketId),
                            );

                            if (allSelected) {
                              // UNSELECT ALL
                              isChecked.clear();
                            } else {
                              // SELECT ALL
                              for (final item in state.basketShowModel) {
                                isChecked.add(item.basketId!);
                              }
                            }

                            setState(() {});
                          },
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.asset(
                              // Иконка зависит от того, все ли выбраны сейчас
                              state.basketShowModel.every(
                                    (item) => isChecked.contains(item.basketId),
                                  )
                                  ? Assets
                                        .icons
                                        .defaultCheckIcon
                                        .path // все выбраны
                                  : Assets.icons.defaultUncheckIcon.path, // не все выбраны

                              color:
                                  state.basketShowModel.every(
                                    (item) => isChecked.contains(item.basketId),
                                  )
                                  ? AppColors.mainPurpleColor
                                  : Color(0xffD1D1D6),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('Выбрать все', style: AppTextStyles.size16Weight400),
                        Spacer(),
                        GestureDetector(
                          onTap: () async {
                            await Share.share('${productNames}');
                          },
                          child: Image.asset(
                            Assets.icons.basketShare.path,
                            width: 21,
                            height: 21,
                            color: AppColors.kLightBlackColor,
                          ),
                        ),
                        SizedBox(width: 16),
                        GestureDetector(
                          onTap: () async {
                            final ok = await showBasketAlert(
                              context,
                              title: 'Удалить',
                              message: 'Вы действительно хотите удалить выбранные товары?',
                              mode: AccountAlertMode.confirm,
                              cancelText: 'Отмена',
                              primaryText: 'Да',
                              primaryColor: Colors.red,
                            );

                            if (ok == true) {
                              await BlocProvider.of<BasketCubit>(
                                context,
                              ).basketDeleteProducts(isChecked.toList());

                              isChecked.clear();
                            } else {}
                          },
                          child: Image.asset(
                            Assets.icons.trashIcon.path,
                            width: 21,
                            height: 21,
                            color: AppColors.kLightBlackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container(height: 36, color: AppColors.kBackgroundColor);
              }
            },
          ),
        ),
      ),
      body: BlocConsumer<BasketCubit, BasketState>(
        listener: (context, state) {
          if (state is NoDataState) {
            bootSheet = false;
            setState(() {});
          }
          if (state is LoadedState) {
            basketData(basket: state.basketShowModel);
            bootSheet = true;

            fulfillment = state.basketShowModel.first.fulfillment ?? '';
            setState(() {});
          }
        },
        builder: (context, state) {
          if (state is ErrorState) {
            return SmartRefresher(
              controller: refreshController,
              onRefresh: () {
                BlocProvider.of<BasketCubit>(context).basketShow();
                refreshController.refreshCompleted();
              },
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Обновите данные',
                      style: const TextStyle(fontSize: 20.0, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is LoadingState) {
            return SmartRefresher(
              controller: refreshController,
              onRefresh: () {
                BlocProvider.of<BasketCubit>(context).basketShow();
                refreshController.refreshCompleted();
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 0.4, thickness: 0.33, color: Color(0xffD1D1D6)),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 152,
                      padding: EdgeInsets.only(top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 94,
                            width: 114,
                            decoration: BoxDecoration(
                              color: AppColors.kWhite,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ShimmerBox(),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [ShimmerBox()],
                              ),
                              const SizedBox(height: 4),
                              ShimmerBox(),
                              const SizedBox(height: 4),
                              SizedBox(width: 234, child: ShimmerBox()),
                              SizedBox(height: 12),
                              ShimmerBox(height: 40),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          }
          if (state is NoDataState) {
            return SmartRefresher(
              controller: refreshController,
              onRefresh: () {
                BlocProvider.of<BasketCubit>(context).basketShow();
                refreshController.refreshCompleted();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 247),
                    child: Image.asset(Assets.icons.defaultNoDataIcon.path, height: 72, width: 72),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Пока здесь пусто',
                    style: AppTextStyles.size16Weight500.copyWith(color: Color(0xFF8E8E93)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          if (state is LoadedState) {
            return SmartRefresher(
              controller: refreshController,
              onRefresh: () {
                BlocProvider.of<BasketCubit>(context).basketShow();
                refreshController.refreshCompleted();
              },
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  SizedBox(height: 12),
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.basketShowModel.length,
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 0.4, thickness: 0.33, color: Color(0xffD1D1D6)),
                      itemBuilder: (BuildContext context, int index) {
                        return BasketProductCardWidget(
                          basketProducts: state.basketShowModel[index],
                          count: index,
                          fulfillment: fulfillmentApi,
                          isChecked: isChecked.contains(state.basketShowModel[index].basketId),
                          onCheckedChanged: () {
                            if (isChecked.contains(state.basketShowModel[index].basketId!)) {
                              isChecked.remove(state.basketShowModel[index].basketId!);
                            } else {
                              isChecked.add(state.basketShowModel[index].basketId!);
                            }

                            setState(() {});
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 174,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Сумма заказа', style: AppTextStyles.size18Weight700),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${getTotalCount(state)} товар',
                              style: AppTextStyles.size16Weight400,
                            ),
                            Text(
                              '${getTotalProductPrice(state)} ₽',
                              style: AppTextStyles.size16Weight600,
                            ),
                          ],
                        ),
                        SizedBox(height: 11),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Скидка', style: AppTextStyles.size16Weight400),
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Color(0xFF7D2DFF), Color(0xFF41DDFF)],
                              ).createShader(bounds),
                              child: Text(
                                '${getTotalCompound(state)} ₽',
                                style: AppTextStyles.size16Weight600.copyWith(
                                  color: AppColors.kWhite,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 1,
                          child: LayoutBuilder(
                            builder: (BuildContext context, BoxConstraints constraints) {
                              const dashWidth = 5.0;
                              final dashHeight = 0.99;
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
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Итого', style: AppTextStyles.size18Weight600),
                            Text('${getTotalPrice(state)}₽', style: AppTextStyles.size18Weight700),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 220),
                ],
              ),
            );
          } else {
            return SmartRefresher(
              controller: refreshController,
              onRefresh: () {
                BlocProvider.of<BasketCubit>(context).basketShow();
                refreshController.refreshCompleted();
              },
              child: const Column(
                children: [Center(child: CircularProgressIndicator(color: Colors.indigoAccent))],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: bootSheet == true
          ? BlocBuilder<BasketCubit, BasketState>(
              builder: (context, state) {
                return SafeArea(
                  top: false,
                  child: Container(
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 23, right: 23, bottom: 0, top: 8),
                    child: InkWell(
                      onTap: () async {
                        if (count != 0 && isChecked.toList().isNotEmpty) {
                          await BlocProvider.of<BasketCubit>(
                            context,
                          ).basketSelectProducts(isChecked.toList());

                          context.router.push(BasketOrderAddressRoute(deleveryDay: deleveryDay));

                          isChecked.clear();
                          // if (fulfillment != 'realFBS') {
                          //   context.router.push(BasketOrderAddressRoute(
                          //       deleveryDay: deleveryDay));
                          // } else {
                          //   context.router.push(BasketOrderRoute(
                          //       fbs: fulfillment == 'FBS' ? true : false,
                          //       address: '',
                          //       fulfillment: fulfillment));
                          // }
                          // Get.to(const BasketOrderAddressPage())
                        } else {
                          await showBasketAlert(
                            context,
                            title: null,
                            message: 'Выберите товары,чтобы продолжить',
                            // mode: BrandedAlertMode.acknowledge,
                            primaryText: 'Понятно',
                            // если нужен свой градиент:
                            // primaryGradient: const LinearGradient(colors: [Color(0xFF7B61FF), Color(0xFF8C52FF)]),
                          );
                        }

                        // int bottomPrice = GetStorage().read('bottomPrice');
                        // int bottomCount = GetStorage().read('bottomCount');
                        // Navigator.pop(context);
                      },
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${getTotalCount(state)} товара",
                                style: AppTextStyles.size16Weight500,
                              ),
                              Text(
                                "Всего: ${getTotalPrice(state)} ₽",
                                style: AppTextStyles.size16Weight500,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            height: 52,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: count != 0 ? AppColors.mainPurpleColor : AppColors.kGray300,
                            ),
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            // padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Text(
                              'Продолжить',
                              style: AppTextStyles.size18Weight600.copyWith(
                                color: AppColors.kWhite,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : null,
    );
  }
}
