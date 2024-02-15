import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/router/app_router.dart';
import 'package:haji_market/features/app/widgets/custom_switch_button.dart';
import 'package:haji_market/features/basket/data/models/basket_show_model.dart';
import 'package:haji_market/features/drawer/data/bloc/product_ad_cubit.dart' as productAdCubit;
import 'package:haji_market/features/drawer/data/bloc/product_ad_state.dart' as productAdState;
import 'package:haji_market/features/drawer/presentation/widgets/count_zero_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import '../../../drawer/data/bloc/basket_cubit.dart';
import '../../../drawer/data/bloc/basket_state.dart';
import '../../../drawer/presentation/widgets/product_ad_card.dart';
import '../../data/DTO/basketOrderDto.dart';

@RoutePage()
class BasketPage extends StatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  int count = 0;
  int price = 0;
  String fulfillment = '';
  String deleveryDay = '';

  String fulfillmentApi = 'FBS';

  String? productNames;

  bool bootSheet = false;
  RefreshController refreshController = RefreshController();

  List<BasketShowModel>? basket = [];

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
      return totalPrice.toString();
    } else {
      return '....';
    }
  }

  Future<void> basketData({
    required List<BasketShowModel>? basket,
  }) async {
    // basket = await BlocProvider.of<BasketCubit>(context).basketData();
    for (var element in basket!) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              // Navigator.pop(context);
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
                      await Share.share('${productNames}');
                    },
                    child: SvgPicture.asset('assets/icons/share.svg')))
          ],
          title: const Text(
            'Корзина',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Column(
              children: [
                Container(
                  height: 12,
                  color: AppColors.kBackgroundColor,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 16,
                    bottom: 8,
                    right: 16,
                    // right: screenSize.height * 0.016,
                  ),
                  child: CustomSwitchButton<int>(
                    groupValue: segmentValue,
                    children: {
                      0: Container(
                        alignment: Alignment.center,
                        height: 39,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'FBS',
                          style: TextStyle(
                            fontSize: 15,
                            color: segmentValue == 0 ? Colors.black : const Color(0xff9B9B9B),
                          ),
                        ),
                      ),
                      1: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        height: 39,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'realFBS',
                          style: TextStyle(
                            fontSize: 14,
                            color: segmentValue == 1 ? Colors.black : const Color(0xff9B9B9B),
                          ),
                        ),
                      ),
                    },
                    onValueChanged: (int? value) async {
                      if (value != null) {
                        segmentValue = value;
                        print('fbs value $value');
                        if (value == 0) {
                          fulfillmentApi = 'FBS';
                        } else {
                          fulfillmentApi = 'realFBS';
                        }
                        BlocProvider.of<BasketCubit>(context).basketShow(fulfillmentApi);

                        // BlocProvider.of<BasketAdminCubit>(context).basketSwitchState(value);
                      }
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: BlocConsumer<BasketCubit, BasketState>(listener: (context, state) {
          if (state is NoDataState) {
            bootSheet = false;
            setState(() {});
          }
          if (state is LoadedState) {
            basketData(basket: state.basketShowModel);
            bootSheet = true;
            setState(() {});
          }
        }, builder: (context, state) {
          if (state is ErrorState) {
            return SmartRefresher(
              controller: refreshController,
              onRefresh: () {
                BlocProvider.of<BasketCubit>(context).basketShow(fulfillmentApi);
                refreshController.refreshCompleted();
              },
              child: Column(
                children: [
                  Center(
                    child: Text(
                      state.message,
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
                BlocProvider.of<BasketCubit>(context).basketShow(fulfillmentApi);
                refreshController.refreshCompleted();
              },
              child: const Column(
                children: [
                  Center(child: CircularProgressIndicator(color: Colors.indigoAccent)),
                ],
              ),
            );
          }
          if (state is NoDataState) {
            return SmartRefresher(
              controller: refreshController,
              onRefresh: () {
                BlocProvider.of<BasketCubit>(context).basketShow(fulfillmentApi);
                refreshController.refreshCompleted();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(margin: const EdgeInsets.only(top: 146), child: Image.asset('assets/icons/no_data.png')),
                  const Text(
                    'В корзине нет товаров',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'Для выбора вещей перейдите в маркет',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff717171)),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            );
          }
          if (state is LoadedState) {
            return SmartRefresher(
              controller: refreshController,
              onRefresh: () {
                BlocProvider.of<BasketCubit>(context).basketShow(fulfillmentApi);
                refreshController.refreshCompleted();
              },
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.basketShowModel.length,
                      // separatorBuilder: (BuildContext context, int index) =>
                      //     const Divider(),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          // onTap: () => Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => DetailCardProductPage(
                          //           product: state.productModel[index])),
                          // ),
                          child: BasketProductCardWidget(
                            basketProducts: state.basketShowModel[index],
                            count: index,
                            fulfillment: fulfillmentApi,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Вас могут заинтересовать',
                          style: TextStyle(color: AppColors.kGray900, fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        BlocConsumer<productAdCubit.ProductAdCubit, productAdState.ProductAdState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state is productAdState.ErrorState) {
                                return Center(
                                  child: Text(
                                    state.message,
                                    style: const TextStyle(fontSize: 20.0, color: Colors.grey),
                                  ),
                                );
                              }
                              if (state is productAdState.LoadingState) {
                                return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
                              }

                              if (state is productAdState.LoadedState) {
                                return SizedBox(
                                    height: 286,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.productModel.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () => context.router
                                              .push(DetailCardProductRoute(product: state.productModel[index])),
                                          child: ProductAdCard(
                                            product: state.productModel[index],
                                          ),
                                        );
                                      },
                                    ));
                              } else {
                                return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
                              }
                            }),
                        const SizedBox(
                          height: 80,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          } else {
            return SmartRefresher(
              controller: refreshController,
              onRefresh: () {
                BlocProvider.of<BasketCubit>(context).basketShow(fulfillmentApi);
                refreshController.refreshCompleted();
              },
              child: const Column(
                children: [
                  Center(child: CircularProgressIndicator(color: Colors.indigoAccent)),
                ],
              ),
            );
          }
        }),
        bottomSheet: bootSheet == true
            ? BlocBuilder<BasketCubit, BasketState>(builder: (context, state) {
                return Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 100),
                  child: InkWell(
                      onTap: () {
                        if (count != 0) {
                          context.router
                              .push(BasketOrderAddressRoute(fulfillment: fulfillment, deleveryDay: deleveryDay));
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "В корзине: ${getTotalCount(state)} товара",
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "Всего: ${getTotalPrice(state)}",
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Container(
                                  height: 46,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: count != 0 ? AppColors.kPrimaryColor : AppColors.kGray300,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  // padding: const EdgeInsets.only(left: 16, right: 16),
                                  child: const Text(
                                    'Продолжить',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
                                    textAlign: TextAlign.center,
                                  )),
                            ],
                          ))),
                );
              })
            : null);
  }
}

class BasketProductCardWidget extends StatefulWidget {
  final BasketShowModel basketProducts;
  final int count;
  final String fulfillment;
  const BasketProductCardWidget({
    required this.count,
    required this.basketProducts,
    required this.fulfillment,
    Key? key,
  }) : super(key: key);

  @override
  State<BasketProductCardWidget> createState() => _BasketProductCardWidgetState();
}

class _BasketProductCardWidgetState extends State<BasketProductCardWidget> {
  int basketCount = 0;
  int basketPrice = 0;
  bool isVisible = true;
  String fulfillmentApi = 'fbs';

  List<basketOrderDTO> basketOrder = [];

  @override
  void initState() {
    basketCount = widget.basketProducts.basketCount!.toInt();
    basketPrice = widget.basketProducts.price!.toInt();
    fulfillmentApi = widget.fulfillment;

    // basketOrder[widget.count] = basketOrderDTO(product: ProductDTO(
    //   id: widget.basketProducts.product!.id!.toInt(),
    //   courier_price: widget.basketProducts.product!.courierPrice!.toInt(),
    //   compound: widget.basketProducts.product!.compound!.toInt(),
    //   shop_id: widget.basketProducts.product!.shopId!.toInt(),
    //   price: widget.basketProducts.product!.price!.toInt(),
    //   name: widget.basketProducts.product!.name.toString(),
    // ), basket: BasketDTO(
    //   basket_id: widget.basketProducts.basketId!.toInt(),
    //   price_courier: widget.basketProducts.priceCourier!.toInt(),
    //   price: widget.basketProducts.price!.toInt(),
    //   basket_count: widget.basketProducts.basketCount!.toInt(),
    //   basket_color: widget.basketProducts.basketColor.toString(),
    //   basket_size: widget.basketProducts.basketSize.toString(),
    //   shop_name: widget.basketProducts.shopName.toString(),
    //   address: [],
    // ));

    // basketOrder[widget.count] = basketOrderDTO(product: null, basket:  null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isVisible,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              padding: const EdgeInsets.only(left: 4, right: 16, top: 8, bottom: 8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 2),
                  // blurRadius: 4,
                  color: Colors.white,
                ),
              ]),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 2),
                        // blurRadius: 4,
                        color: Colors.white,
                      ),
                    ]),
                    // height: MediaQuery.of(context).size.height * 0.86,
                    // color: Colors.red,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            if (widget.basketProducts.image != null && widget.basketProducts.image!.isNotEmpty)
                              Container(
                                height: 104,
                                width: 104,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: NetworkImage(
                                      "http://185.116.193.73/storage/${widget.basketProducts.image!.first}"),
                                  fit: BoxFit.contain,
                                )),
                              ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (widget.basketProducts.product!.compound != 0 &&
                                      widget.basketProducts.product!.compound != null)
                                  ? Row(
                                      children: [
                                        Text(
                                          '${(widget.basketProducts.product!.price!.toInt() * (((100 - widget.basketProducts.product!.compound!.toInt())) / 100)).toInt()} ₽ ',
                                          style: const TextStyle(
                                              color: Colors.red, fontWeight: FontWeight.w500, fontSize: 16),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '${widget.basketProducts.product!.price!.toInt()} ₽ ',
                                          style: const TextStyle(
                                            color: AppColors.kGray900,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      '${widget.basketProducts.product!.price} ₽ ',
                                      style: const TextStyle(
                                        color: AppColors.kGray900,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                '${(widget.basketProducts.product!.price!.toInt() - (widget.basketProducts.product!.price!.toInt() * (widget.basketProducts.product!.compound!.toInt() / 100))).toInt() * basketCount} ₽/$basketCount шт',
                                style: const TextStyle(
                                  color: AppColors.kGray300,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  '${widget.basketProducts.product!.name}',
                                  style: const TextStyle(
                                      fontSize: 14, color: AppColors.kGray900, fontWeight: FontWeight.w400),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Продавец: ${widget.basketProducts.shopName}',
                                style: const TextStyle(
                                    fontSize: 12, color: AppColors.kGray900, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                widget.basketProducts.deliveryDay != null && widget.basketProducts.deliveryDay != 0
                                    ? 'Доставка: ${widget.basketProducts.deliveryDay} дня'
                                    : 'Доставка: Нет срока доставки СДЕК',
                                style: const TextStyle(
                                    fontSize: 12, color: AppColors.kGray900, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  //20
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.basketProducts.optom == 1)
                        Container(
                          height: 32,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Оптом ${widget.basketProducts.basketCount} шт.',
                              style: const TextStyle(
                                  color: AppColors.kPrimaryColor, fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      else
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await BlocProvider.of<BasketCubit>(context)
                                    .basketMinus(widget.basketProducts.product!.id.toString(), '1', 0, fulfillmentApi);

                                basketCount--;
                                int bottomPrice = GetStorage().read('bottomPrice');
                                int bottomCount = GetStorage().read('bottomCount');
                                bottomCount--;

                                GetStorage().write('bottomCount', bottomCount);

                                basketPrice = (basketPrice -
                                    ((widget.basketProducts.product!.price!.toInt() -
                                        (widget.basketProducts.product!.price!.toInt() *
                                                (widget.basketProducts.product!.compound!.toInt() / 100))
                                            .toInt())));

                                bottomPrice -= ((widget.basketProducts.product!.price!.toInt() -
                                    (widget.basketProducts.product!.price!.toInt() *
                                            (widget.basketProducts.product!.compound!.toInt() / 100))
                                        .toInt()));

                                if (basketCount == 0) {
                                  await BlocProvider.of<BasketCubit>(context).basketShow(fulfillmentApi);
                                  isVisible = false;
                                }

                                setState(() {});
                              },
                              child: Container(
                                height: 32,
                                width: 32,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: basketCount == 1
                                    ? SvgPicture.asset('assets/icons/basket_1.svg')
                                    : const Icon(
                                        Icons.remove,
                                        color: AppColors.kPrimaryColor,
                                      ),
                              ),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Text(basketCount.toString()),
                            const SizedBox(
                              width: 14,
                            ),
                            GestureDetector(
                              onTap: () {
                                if ((widget.basketProducts.product?.count ?? 0) <= basketCount) {
                                  showCupertinoModalPopup<void>(
                                      context: context, builder: (context) => CountZeroDialog(onYesTap: () {}));
                                  return;
                                } else {
                                  BlocProvider.of<BasketCubit>(context)
                                      .basketAdd(widget.basketProducts.product!.id.toString(), '1', 0, '', '');
                                  setState(() {
                                    basketCount++;
                                    basketPrice = (basketPrice +
                                        ((widget.basketProducts.product!.price!.toInt() -
                                            (widget.basketProducts.product!.price!.toInt() *
                                                    (widget.basketProducts.product!.compound!.toInt() / 100))
                                                .toInt())));
                                  });

                                  int bottomPrice = GetStorage().read('bottomPrice');
                                  int bottomCount = GetStorage().read('bottomCount');
                                  bottomCount++;

                                  GetStorage().write('bottomCount', bottomCount);
                                  bottomPrice += ((widget.basketProducts.product!.price!.toInt() -
                                      (widget.basketProducts.product!.price!.toInt() *
                                              (widget.basketProducts.product!.compound!.toInt() / 100))
                                          .toInt()));
                                  GetStorage().write('bottomPrice', bottomPrice);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: AppColors.kPrimaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<BasketCubit>(context).basketMinus(
                              widget.basketProducts.product!.id.toString(), basketCount.toString(), 0, fulfillmentApi);
                          // isVisible = false;

                          // setState(() {});
                        },
                        child: const Text(
                          'Удалить',
                          style: TextStyle(color: AppColors.kPrimaryColor, fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Выберите карту, чтобы поделиться'),
                Checkbox(
                  checkColor: Colors.white,
                  // fillColor: MaterialStateProperty.resolveWith(Colors.),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ));
  }

  bool isChecked = false;
}
