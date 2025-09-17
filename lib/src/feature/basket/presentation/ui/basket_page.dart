import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/basket/data/models/basket_show_model.dart';
import 'package:haji_market/src/feature/basket/presentation/widgets/basket_card_widget.dart';
import 'package:haji_market/src/feature/product/cubit/product_ad_cubit.dart'
    as productAdCubit;
import 'package:haji_market/src/feature/product/cubit/product_ad_state.dart'
    as productAdState;
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
        totalPrice +=
            (basketItem.product!.price ?? 0) * basketItem.basketCount!;
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
        compound += basketItem.product!.price!.toInt() *
            (((100 - basketItem.product!.compound!.toInt())) / 100).toInt();
      }
      return formatPrice(compound);
    } else {
      return '....';
    }
  }

  Future<void> basketData({
    required List<BasketShowModel>? basket,
  }) async {
    basketItems!.addAll(basket!);

    // basket = await BlocProvider.of<BasketCubit>(context).basketData();
    for (var element in basket) {
      count += element.basketCount!.toInt();
      price += element.price!.toInt();

      fulfillment = element.product!.fulfillment ?? 'fbs';

      deleveryDay =
          element.deliveryDay != null ? element.deliveryDay.toString() : '';

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
    BlocProvider.of<BasketCubit>(context).basketShow(fulfillmentApi);
    BlocProvider.of<productAdCubit.ProductAdCubit>(context).adProducts(null);
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
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 0,
          // leading: IconButton(
          //   onPressed: () {
          //     // Navigator.pop(context);
          //   },
          //   icon: const Icon(
          //     Icons.arrow_back_ios,
          //     color: AppColors.kPrimaryColor,
          //   ),
          // ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 22.0),
                child: GestureDetector(
                    onTap: () async {
                      await Share.share('${productNames}');
                    },
                    child: SvgPicture.asset(
                      'assets/icons/share.svg',
                      color: AppColors.kLightBlackColor,
                    )))
          ],
          title: const Text(
            'Корзина',
            style: AppTextStyles.appBarTextStylea,
            textAlign: TextAlign.center,
          ),
          // bottom: PreferredSize(
          //   preferredSize: const Size.fromHeight(60),
          //   child: Column(
          //     children: [
          //       // Container(
          //       //   height: 12,
          //       //   color: AppColors.kBackgroundColor,
          //       // ),
          //       // Container(
          //       //   padding: const EdgeInsets.only(
          //       //     top: 8,
          //       //     left: 16,
          //       //     bottom: 8,
          //       //     right: 16,
          //       //     // right: screenSize.height * 0.016,
          //       //   ),
          //       //   child: CustomSwitchButton<int>(
          //       //     groupValue: segmentValue,
          //       //     children: {
          //       //       0: Container(
          //       //         alignment: Alignment.center,
          //       //         height: 39,
          //       //         width: MediaQuery.of(context).size.width,
          //       //         decoration: BoxDecoration(
          //       //           borderRadius: BorderRadius.circular(4),
          //       //         ),
          //       //         child: Text(
          //       //           'FBS',
          //       //           style: TextStyle(
          //       //             fontSize: 15,
          //       //             color: segmentValue == 0
          //       //                 ? Colors.black
          //       //                 : const Color(0xff9B9B9B),
          //       //           ),
          //       //         ),
          //       //       ),
          //       //       1: Container(
          //       //         width: MediaQuery.of(context).size.width,
          //       //         alignment: Alignment.center,
          //       //         height: 39,
          //       //         decoration: BoxDecoration(
          //       //           borderRadius: BorderRadius.circular(4),
          //       //         ),
          //       //         child: Text(
          //       //           'realFBS',
          //       //           style: TextStyle(
          //       //             fontSize: 14,
          //       //             color: segmentValue == 1
          //       //                 ? Colors.black
          //       //                 : const Color(0xff9B9B9B),
          //       //           ),
          //       //         ),
          //       //       ),
          //       //     },
          //       //     onValueChanged: (int? value) async {
          //       //       if (value != null) {
          //       //         segmentValue = value;
          //       //         if (segmentValue == 0) {
          //       //           fulfillmentApi = 'FBS';
          //       //           fulfillment = 'FBS';
          //       //         } else {
          //       //           fulfillmentApi = 'realFBS';
          //       //           fulfillment = 'realFBS';
          //       //         }

          //       //         BlocProvider.of<BasketCubit>(context)
          //       //             .basketShow(fulfillmentApi);

          //       //         // BlocProvider.of<BasketAdminCubit>(context).basketSwitchState(value);
          //       //       }
          //       //     },
          //       //   ),
          //       // ),
          //     ],
          //   ),
          // ),
        ),
        body:
            BlocConsumer<BasketCubit, BasketState>(listener: (context, state) {
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
        }, builder: (context, state) {
          if (state is ErrorState) {
            return SmartRefresher(
              controller: refreshController,
              onRefresh: () {
                BlocProvider.of<BasketCubit>(context)
                    .basketShow(fulfillmentApi);
                refreshController.refreshCompleted();
              },
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Обновите данные',
                      style:
                          const TextStyle(fontSize: 20.0, color: Colors.grey),
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
                BlocProvider.of<BasketCubit>(context)
                    .basketShow(fulfillmentApi);
                refreshController.refreshCompleted();
              },
              child: const Column(
                children: [
                  Center(
                      child: CircularProgressIndicator(
                          color: Colors.indigoAccent)),
                ],
              ),
            );
          }
          if (state is NoDataState) {
            return SmartRefresher(
              controller: refreshController,
              onRefresh: () {
                BlocProvider.of<BasketCubit>(context)
                    .basketShow(fulfillmentApi);
                refreshController.refreshCompleted();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 247),
                      child: Image.asset(
                        Assets.icons.defaultNoDataIcon.path,
                        height: 72,
                        width: 72,
                      )),
                  SizedBox(height: 12),
                  Text(
                    'Пока здесь пусто',
                    style: AppTextStyles.size16Weight500
                        .copyWith(color: Color(0xFF8E8E93)),
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
                BlocProvider.of<BasketCubit>(context)
                    .basketShow(fulfillmentApi);
                refreshController.refreshCompleted();
              },
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: AppColors.kWhite,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.basketShowModel.length,
                      padding: EdgeInsets.zero,
                      // separatorBuilder: (BuildContext context, int index) =>
                      //     const Divider(),
                      separatorBuilder: (context, index) => const Divider(
                        height: 0.05,
                        color: AppColors.kGray2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(top: 16),
                          child: BasketProductCardWidget(
                            basketProducts: state.basketShowModel[index],
                            count: index,
                            fulfillment: fulfillmentApi,
                          ),
                        );
                      },
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: AppColors.kWhite,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Сумма заказа',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0,
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${getTotalCount(state)} товар',
                              style: AppTextStyles.catalogTextStyle,
                            ),
                            Text(
                              '${getTotalProductPrice(state)} ₽',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Скидка',
                            ),
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Color(0xFF7D2DFF), Color(0xFF41DDFF)],
                              ).createShader(bounds),
                              child: Text(
                                '${getTotalCompound(state)} ₽',
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
                        SizedBox(height: 11),
                        SizedBox(
                          height: 1,
                          child: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              const dashWidth = 5.0;
                              final dashHeight = 0.5;
                              final dashCount = 30;
                              return Flex(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                direction: Axis.horizontal,
                                children: List.generate(dashCount, (_) {
                                  return SizedBox(
                                    width: dashWidth,
                                    height: dashHeight,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: AppColors.kGray300),
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 11),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Итого',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0,
                              ),
                            ),
                            Text(
                              '${getTotalPrice(state)}₽',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 200)

                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   color: Colors.white,
                  //   padding: const EdgeInsets.all(16),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       const Text(
                  //         'Вас могут заинтересовать',
                  //         style: TextStyle(
                  //             color: AppColors.kGray900,
                  //             fontWeight: FontWeight.w700,
                  //             fontSize: 16),
                  //       ),
                  //       const SizedBox(
                  //         height: 10,
                  //       ),
                  //       BlocConsumer<productAdCubit.ProductAdCubit,
                  //               productAdState.ProductAdState>(
                  //           listener: (context, state) {},
                  //           builder: (context, state) {
                  //             if (state is productAdState.ErrorState) {
                  //               return Center(
                  //                 child: Text(
                  //                   state.message,
                  //                   style: const TextStyle(
                  //                       fontSize: 20.0, color: Colors.grey),
                  //                 ),
                  //               );
                  //             }
                  //             if (state is productAdState.LoadingState) {
                  //               return const Center(
                  //                   child: CircularProgressIndicator(
                  //                       color: Colors.indigoAccent));
                  //             }

                  //             if (state is productAdState.LoadedState) {
                  //               return SizedBox(
                  //                   height: MediaQuery.of(context).size.height *
                  //                       0.29,
                  //                   // width: MediaQuery.of(context).size.height * 0.20,
                  //                   child: ListView.builder(
                  //                     scrollDirection: Axis.horizontal,
                  //                     itemCount: state.productModel.length,
                  //                     itemBuilder: (context, index) {
                  //                       return GestureDetector(
                  //                         onTap: () => context.router.push(
                  //                             DetailCardProductRoute(
                  //                                 product: state
                  //                                     .productModel[index])),
                  //                         child: ProductAdCard(
                  //                           product: state.productModel[index],
                  //                         ),
                  //                       );
                  //                     },
                  //                   ));
                  //             } else {
                  //               return const Center(
                  //                   child: CircularProgressIndicator(
                  //                       color: Colors.indigoAccent));
                  //             }
                  //           }),
                  //       const SizedBox(
                  //         height: 80,
                  //       )
                  //     ],
                  //   ),
                  // ),

                  // const SizedBox(
                  //   height: 30,
                  // ),
                ],
              ),
            );
          } else {
            return SmartRefresher(
              controller: refreshController,
              onRefresh: () {
                BlocProvider.of<BasketCubit>(context)
                    .basketShow(fulfillmentApi);
                refreshController.refreshCompleted();
              },
              child: const Column(
                children: [
                  Center(
                      child: CircularProgressIndicator(
                          color: Colors.indigoAccent)),
                ],
              ),
            );
          }
        }),
        bottomSheet: bootSheet == true
            ? BlocBuilder<BasketCubit, BasketState>(builder: (context, state) {
                return Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 100),
                  child: InkWell(
                      onTap: () {
                        if (count != 0) {
                          if (fulfillment != 'realFBS') {
                            context.router.push(BasketOrderAddressRoute(
                                deleveryDay: deleveryDay));
                          } else {
                            context.router.push(BasketOrderRoute(
                                fbs: fulfillment == 'FBS' ? true : false,
                                address: '',
                                fulfillment: fulfillment));
                          }
                          // Get.to(const BasketOrderAddressPage())
                        }

                        // int bottomPrice = GetStorage().read('bottomPrice');
                        // int bottomCount = GetStorage().read('bottomCount');
                        // Navigator.pop(context);
                      },
                      child: SizedBox(
                          height: 80,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${getTotalCount(state)} товара",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "Всего: ${getTotalPrice(state)} ₽",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: count != 0
                                        ? AppColors.mainPurpleColor
                                        : AppColors.kGray300,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  // padding: const EdgeInsets.only(left: 16, right: 16),
                                  child: const Text(
                                    'Продолжить',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                  )),
                            ],
                          ))),
                );
              })
            : null);
  }
}
