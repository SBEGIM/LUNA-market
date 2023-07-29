import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/router/app_router.dart';
import 'package:haji_market/features/drawer/data/bloc/product_ad_state.dart' as productAdState;
import 'package:haji_market/features/drawer/data/bloc/product_cubit.dart' as productCubit;
import 'package:haji_market/features/drawer/data/bloc/product_state.dart' as productState;
import 'package:haji_market/features/drawer/data/bloc/shops_drawer_cubit.dart' as shopsDrawerCubit;
import 'package:haji_market/features/drawer/data/bloc/shops_drawer_state.dart' as shopsDrawerState;
import 'package:haji_market/features/drawer/data/bloc/sub_cats_cubit.dart' as subCatCubit;
import 'package:haji_market/features/drawer/data/bloc/sub_cats_state.dart' as subCatState;
import 'package:haji_market/features/drawer/presentation/widgets/detail_card_product_page.dart';
import 'package:haji_market/features/drawer/presentation/widgets/filter_page.dart';
import 'package:haji_market/features/drawer/presentation/widgets/products_card_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/home/data/bloc/cats_cubit.dart';
import 'package:haji_market/features/home/data/bloc/cats_state.dart' as catsState;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../home/data/model/Cats.dart';
import '../../../home/presentation/widgets/product_watching_card.dart';
import '../../data/bloc/brand_cubit.dart' as brandCubit;
import 'package:haji_market/features/drawer/data/bloc/brand_state.dart' as brandState;

import '../../data/bloc/product_ad_cubit.dart';
import '../../data/bloc/product_ad_state.dart';
import '../widgets/product_ad_card.dart';

@RoutePage()
class ProductsPage extends StatefulWidget {
  final Cats cats;
  String? shopId;

  ProductsPage({required this.cats, this.shopId, Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final boxMain = GetStorage().write('rating', false);
  bool? catsVisible = false;
  TextEditingController searchController = TextEditingController();

  Function? scrollView;

  @override
  void initState() {
    scrollView = GetStorage().listenKey('scrollView', (value) async {
      catsVisible = value;
      setState(() {});
    });

    if (widget.cats.id == 0) {
      GetStorage().remove('CatId');
      GetStorage().remove('catId');
    }

    GetStorage().remove('priceFilter');
    GetStorage().remove('brandFilterId');
    GetStorage().remove('subCatId');
    GetStorage().remove('search');

    GetStorage().remove('sub_cat_id');
    GetStorage().remove('subCatFilterId');
    if (widget.shopId == null) {
      GetStorage().remove('shopFilterId');
    }
    GetStorage().remove('ratingFilter');
    GetStorage().remove('rating');
    BlocProvider.of<shopsDrawerCubit.ShopsDrawerCubit>(context).shopsDrawer(widget.cats.id);
    BlocProvider.of<brandCubit.BrandCubit>(context).brands(subCatId: widget.cats.id);
    BlocProvider.of<ProductAdCubit>(context).adProducts(widget.cats.id);
    subCatCubit.SubCatsCubit subCatsCubit = BlocProvider.of<subCatCubit.SubCatsCubit>(context);
    if (subCatsCubit.state is! subCatState.LoadedState) {
      subCatsCubit.subCats(widget.cats.id);
    }
    super.initState();
  }

  @override
  void dispose() {
    scrollView!.call();
    GetStorage().remove('scrollView');
    super.dispose();
  }

  int page = 1;
  RefreshController _refreshController = RefreshController();

  Future<void> onLoading() async {
    await BlocProvider.of<productCubit.ProductCubit>(context).productsPagination();
    await Future.delayed(const Duration(milliseconds: 2000));
    _refreshController.loadComplete();
  }

  Future<void> onRefresh() async {
    await BlocProvider.of<productCubit.ProductCubit>(context).productsPagination();
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {});
    }
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            // Navigator.pop(context);
            context.router.pop();
          },
          icon: SvgPicture.asset('assets/icons/back_header.svg'),
        ),
        title: Container(
          width: 311,
          height: 40,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(color: const Color(0xFFF8F8F8), borderRadius: BorderRadius.circular(10)),
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              GetStorage().write('search', value);

              BlocProvider.of<productCubit.ProductCubit>(context).products();
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.kGray300,
              ),
              hintText: 'Поиск',
              hintStyle: TextStyle(
                color: AppColors.kGray300,
                fontSize: 16,
              ),
              border: InputBorder.none,
            ),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        // actions: [
        //   Padding(
        //       padding: const EdgeInsets.only(right: 20.0),
        //       child: SvgPicture.asset('assets/icons/share.svg'))
        // ],
      ),
      body: Column(
        children: [
          widget.cats.name != ''
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.kBackgroundColor,
                  padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                  child: Text(
                    '${widget.cats.name}',
                    style: const TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                )
              : Container(),
          const SizedBox(
            height: 4,
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 16),
            child: const CatsProductPage(),
          ),
          Expanded(
            child: SmartRefresher(
              controller: _refreshController,
              enablePullDown: false,
              enablePullUp: true,
              onLoading: () {
                onLoading();
              },
              onRefresh: () {
                onRefresh();
              },
              child: CustomScrollView(
                // shrinkWrap: false,
                // physics: NeverScrollableScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    snap: true,
                    floating: true,
                    forceElevated: true,
                    elevation: 0,
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: false,
                    toolbarHeight: 70,
                    flexibleSpace: Container(
                      padding: const EdgeInsets.only(left: 16),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 10, right: 8, top: 10),
                                  child: Row(
                                    children: [
                                      const chipWithDropDown(label: 'Цена'),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      const chipWithDropDown(label: 'Бренд'),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      widget.shopId == null ? const chipWithDropDown(label: 'Продавцы') : Container(),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      const chipWithDropDown(label: 'Высокий рейтинг'),
                                    ],
                                  ),
                                )),
                          ),
                          Container(
                            height: 70,
                            color: Colors.white,
                            child: IconButton(
                              icon: SvgPicture.asset('assets/icons/filter.svg'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => FilterPage(shopId: widget.shopId)),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList.list(children: [
                    BlocConsumer<ProductAdCubit, ProductAdState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is ErrorState) {
                            return Center(
                              child: Text(
                                state.message,
                                style: const TextStyle(fontSize: 20.0, color: Colors.grey),
                              ),
                            );
                          }
                          if (state is LoadingState) {
                            return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
                          }

                          if (state is LoadedState) {
                            return state.productModel.length != 0
                                ? SizedBox(
                                    height: 260,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      // shrinkWrap: true,
                                      itemCount: state.productModel.length < 4 ? state.productModel.length : 4,
                                      itemBuilder: (BuildContext ctx, index) {
                                        return GestureDetector(
                                          onTap: () => context.router
                                              .push(DetailCardProductRoute(product: state.productModel[index])),
                                          child: ProductAdCard(
                                            product: state.productModel[index],
                                          ),
                                        );
                                      },
                                    ))
                                : Container();
                          } else {
                            return Container();
                          }
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<productCubit.ProductCubit, productState.ProductState>(
                      builder: (context, state) {
                        if (state is productState.LoadedState) {
                          return Container(
                            padding: const EdgeInsets.only(left: 16, top: 11, bottom: 8),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Найдено ${state.productModel.length} товаров',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500, color: Color.fromRGBO(144, 148, 153, 1)),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    )
                  ]),

                  const Products(),

                  // ProductCardWidget()
                ],
              ),
            ),
          ),
        ],
      ),
    );
    // chip('sdfasdf', Colors.red),
  }
}

Widget chip(
  String label,
  Color color,
) {
  return Chip(
    labelPadding: const EdgeInsets.all(4.0),
    label: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: color,
    elevation: 1.0,

    // shadowColor: Colors.grey[60],
    padding: const EdgeInsets.all(6.0),
  );
}

Widget chipDate(
  String label,
  int index,
  int select,
) {
  return Chip(
    labelPadding: const EdgeInsets.all(4.0),
    label: Text(
      label,
      style: const TextStyle(
        color: AppColors.kGray900,
      ),
    ),
    backgroundColor: select != index ? const Color(0xFFEBEDF0) : AppColors.kPrimaryColor,
    // elevation: 1.0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(4),
            bottomRight: Radius.circular(4),
            topLeft: Radius.circular(4),
            bottomLeft: Radius.circular(4))),
    // shadowColor: Colors.grey[60],
    padding: const EdgeInsets.all(6.0),
  );
}

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    BlocProvider.of<productCubit.ProductCubit>(context).products();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<productCubit.ProductCubit, productState.ProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is productState.ErrorState) {
            return SliverToBoxAdapter(
              child: Center(
                child: Text(
                  state.message,
                  style: const TextStyle(fontSize: 20.0, color: Colors.grey),
                ),
              ),
            );
          }
          if (state is productState.LoadingState) {
            return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator(color: Colors.indigoAccent)),
            );
          }

          if (state is productState.LoadedState) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels == notification.metrics.minScrollExtent) {
                  Future.delayed(const Duration(milliseconds: 100), () {}).then((s) {
                    GetStorage().write('scrollView', false);
                  });

                  // GetStorage().write('scrollView', false);
                } else if (notification.direction == ScrollDirection.reverse) {
                  Future.delayed(const Duration(milliseconds: 200), () {}).then((s) {
                    GetStorage().write('scrollView', true);
                  });
                }
                return true;
              },
              child: SliverList.builder(
                itemCount: state.productModel.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        context.router.push(DetailCardProductRoute(product: state.productModel[index]));
                      },
                      child: ProductCardWidget(product: state.productModel[index]));
                },
              ),
            );
          } else {
            return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator(color: Colors.indigoAccent)),
            );
          }
        });
  }
}

class chipWithDropDown extends StatefulWidget {
  final label;

  const chipWithDropDown({Key? key, required this.label}) : super(key: key);

  @override
  _chipWithDropDownState createState() => _chipWithDropDownState();
}

class _chipWithDropDownState extends State<chipWithDropDown> {
  bool rating = false;
  String shopName = '';
  String brandName = '';
  RangeValues price = const RangeValues(0, 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        switch (widget.label) {
          case "Цена":
            {
              GetStorage().listen(() {
                if (GetStorage().read('brandFilter') != null) {
                  setState(() {
                    price = GetStorage().read('priceFilter');
                  });
                }
              });
              await showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                isDismissible: true,
                builder: (context) {
                  return DraggableScrollableSheet(
                    initialChildSize: 0.30, //set this as you want
                    maxChildSize: 0.30, //set this as you want
                    minChildSize: 0.30, //set this as you want
                    builder: (context, scrollController) {
                      return const PriceBottomSheet(
                        productId: 1,
                      );
                    },
                  );
                },
              );
            }
            break;

          case "Бренд":
            {
              GetStorage().listenKey('brandFilter', (value) {
                brandName = value ?? 'Бренд';
                setState(() {});
              });
              await showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                isDismissible: true,
                builder: (context) {
                  return DraggableScrollableSheet(
                    initialChildSize: 0.60, //set this as you want
                    maxChildSize: 0.60, //set this as you want
                    minChildSize: 0.60, //set this as you want
                    builder: (context, scrollController) {
                      return const BrandBottomSheet(
                        productId: 1,
                      );
                    },
                  );
                },
              );
            }
            break;

          case "Продавцы":
            {
              GetStorage().listenKey('shopFilter', (value) {
                brandName = value ?? 'Продавцы';
                setState(() {});
              });

              await showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                isDismissible: true,
                builder: (context) {
                  return DraggableScrollableSheet(
                    initialChildSize: 0.60, //set this as you want
                    maxChildSize: 0.60, //set this as you want
                    minChildSize: 0.60, //set this as you want
                    builder: (context, scrollController) {
                      return const ShopBottomSheet(
                        productId: 1,
                      );
                    },
                  );
                },
              );
            }
            break;

          case "Высокий рейтинг":
            {
              setState(() {
                rating = !rating;
              });
            }
            break;

          default:
            {
              print("Invalid choice");
            }
            break;
        }
      },
      child: Chip(
        //labelPadding: const EdgeInsets.only(left: 6.0, right: 0.0),
        label: Row(
          children: [
            if (widget.label == 'Высокий рейтинг' && rating == true)
              Text(
                widget.label,
                style: const TextStyle(
                  color: AppColors.kPrimaryColor,
                ),
              )
            else if (shopName != '')
              Text(
                shopName,
                style: const TextStyle(
                  color: Colors.black,
                ),
              )
            else if (price.start != 0 && price.end != 0)
              Text(
                "${price.start.toInt()} - ${price.end.toInt()} ₸",
                style: const TextStyle(
                  color: Colors.black,
                ),
              )
            else if (brandName != '')
              Text(
                brandName,
                style: const TextStyle(
                  color: Colors.black,
                ),
              )
            else
              Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            if (widget.label == 'Высокий рейтинг' && rating == true)
              const Icon(
                Icons.close,
                color: AppColors.kGray400,
                size: 16,
              )
            else
              const Icon(
                Icons.keyboard_arrow_down_sharp,
                color: AppColors.kGray400,
                size: 16,
              )
          ],
        ),
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: AppColors.kGray2), //the outline color
            borderRadius: BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.all(0),
      ),
    );
  }
}

class CatsProductPage extends StatefulWidget {
  const CatsProductPage({Key? key}) : super(key: key);

  @override
  _CatsProductPageState createState() => _CatsProductPageState();
}

class _CatsProductPageState extends State<CatsProductPage> {
  String subCatName = '';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<subCatCubit.SubCatsCubit, subCatState.SubCatsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is subCatState.ErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(fontSize: 20.0, color: Colors.grey),
              ),
            );
          }
          if (state is subCatState.LoadedState) {
            return Container(
              height: 50,
              color: Colors.white,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.cats.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (subCatName == state.cats[index].name.toString()) {
                          setState(() {
                            subCatName = '';
                          });
                          GetStorage().remove('subCatId');
                        } else {
                          GetStorage().write('subCatId', state.cats[index].id);
                          GetStorage().write('subCatFilterId', [state.cats[index].id].toString());
                          setState(() {
                            subCatName = state.cats[index].name.toString();
                          });
                        }
                        BlocProvider.of<productCubit.ProductCubit>(context).products();
                        BlocProvider.of<brandCubit.BrandCubit>(context).brands(subCatId: state.cats[index].id);
                      },
                      child: Container(
                        height: 28,
                        padding: const EdgeInsets.only(right: 10),
                        child: Chip(
                          //labelPadding: const EdgeInsets.all(0.0),

                          label: Text(
                            state.cats[index].name.toString(),
                            style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
                          ),
                          backgroundColor: state.cats[index].name.toString() == subCatName
                              ? AppColors.kPrimaryColor
                              : AppColors.steelGray,
                          elevation: 1.0,

                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          // shadowColor: Colors.grey[60],
                          //padding: const EdgeInsets.all(4.0),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
          }
        });
  }
}

class PriceBottomSheet extends StatefulWidget {
  final int productId;

  const PriceBottomSheet({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  _PriceBottomSheetState createState() => _PriceBottomSheetState();
}

class _PriceBottomSheetState extends State<PriceBottomSheet> {
  RangeValues values = const RangeValues(1, 100000);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: const Text(
                    'Цена',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/icon-tab-close.svg',
                      color: AppColors.kPrimaryColor,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              child: Container(
                color: Colors.white,
                // height: 200,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.38,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.kGray200,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            'от ${values.start.toInt()}',
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.42,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.kGray200,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            'до ${values.end.toInt()}',
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.zero,
                      child: RangeSlider(
                          divisions: 60,
                          activeColor: AppColors.kPrimaryColor,
                          inactiveColor: AppColors.kGray300,
                          min: 1,
                          max: 100000,
                          values: values,
                          onChanged: (value) {
                            setState(() {
                              values = value;
                              GetStorage().write('priceFilter', value);
                            });
                          }),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(left: 0, right: 0, top: 16, bottom: 26),
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<productCubit.ProductCubit>(context).products();

                          Navigator.pop(context);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.kPrimaryColor,
                            ),
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(16),
                            child: const Text(
                              'Применить',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class BrandBottomSheet extends StatefulWidget {
  final int productId;

  const BrandBottomSheet({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  _BrandBottomSheetState createState() => _BrandBottomSheetState();
}

class _BrandBottomSheetState extends State<BrandBottomSheet> {
  final List<int> _selectedListSort = [];

  @override
  void initState() {
    // if (GetStorage().read('selectedIndexSort') != null) {
    //   _selectedIndexSort = GetStorage().read('selectedIndexSort');
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<brandCubit.BrandCubit, brandState.BrandState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is brandState.ErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(fontSize: 20.0, color: Colors.grey),
              ),
            );
          }
          if (state is brandState.LoadedState) {
            return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      height: 360,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                        // shrinkWrap: true,
                        itemCount: state.cats.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 40,
                            child: InkWell(
                                onTap: () {
                                  // if (_selectedIndexSort == index) {
                                  //   GetStorage().remove('brandFilter');
                                  //   GetStorage().remove('brandFilterId');
                                  //   GetStorage().remove('selectedIndexSort');

                                  //   _selectedIndexSort = -1;
                                  // } else {
                                  //   GetStorage().write('brandFilter',
                                  //       state.cats[index].name.toString());
                                  //   GetStorage().write(
                                  //       'brandFilterId', state.cats[index].id);
                                  //   GetStorage()
                                  //       .write('selectedIndexSort', index);

                                  if (_selectedListSort.contains(state.cats[index].id as int)) {
                                    _selectedListSort.remove(state.cats[index].id as int);
                                  } else {
                                    _selectedListSort.add(state.cats[index].id as int);
                                  }

                                  GetStorage().write('brandFilterId', _selectedListSort.toString());

                                  setState(() {
                                    // устанавливаем индекс выделенного элемента
                                    // _selectedIndexSort = index;
                                  });

                                  //  Get.back();
                                  // BlocProvider.of<productCubit.ProductCubit>(
                                  //         context)
                                  //     .products();
                                },
                                child: ListTile(
                                  selected: _selectedListSort.contains(state.cats[index].id),
                                  leading: Text(
                                    state.cats[index].name.toString(),
                                    style: AppTextStyles.appBarTextStyle,
                                  ),
                                  trailing: _selectedListSort.contains(state.cats[index].id)
                                      ? SvgPicture.asset(
                                          'assets/icons/check_circle.svg',
                                        )
                                      : SvgPicture.asset(
                                          'assets/icons/check_circle_no_selected.svg',
                                        ),
                                )),
                          );
                        },
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(left: 0, right: 0, top: 16, bottom: 26),
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<productCubit.ProductCubit>(context).products();
                          Navigator.pop(context);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.kPrimaryColor,
                            ),
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(16),
                            child: const Text(
                              'Готово',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ),
                  ],
                ));
          } else {
            return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
          }
        });
  }
}

class ShopBottomSheet extends StatefulWidget {
  final int productId;

  const ShopBottomSheet({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  _ShopBottomSheetState createState() => _ShopBottomSheetState();
}

class _ShopBottomSheetState extends State<ShopBottomSheet> {
  //int _selectedIndexSort = -1;

  final List<int> _selectedListSort = [];

  @override
  void initState() {
    // if (GetStorage().read('shopSelectedIndexSort') != null) {
    //   _selectedIndexSort = GetStorage().read('shopSelectedIndexSort');
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopsDrawerCubit.ShopsDrawerCubit, shopsDrawerState.ShopsDrawerState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is shopsDrawerState.ErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(fontSize: 20.0, color: Colors.grey),
              ),
            );
          }
          if (state is shopsDrawerState.LoadingState) {
            return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
          }

          if (state is shopsDrawerState.LoadedState) {
            return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      height: 360,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                        // shrinkWrap: true,
                        itemCount: state.shopsDrawer.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 40,
                            child: InkWell(
                                onTap: () {
                                  // if (_selectedListSort == index) {
                                  //   GetStorage().remove('shopFilter');
                                  //   GetStorage().remove('shopFilterId');
                                  //   GetStorage()
                                  //       .remove('shopSelectedIndexSort');

                                  //   setState(() {
                                  //     _selectedIndexSort = -1;
                                  //   });
                                  // } else {
                                  //   GetStorage().write(
                                  //       'shopFilter',
                                  //       state.shopsDrawer[index].name
                                  //           .toString());
                                  //   GetStorage().write('shopFilterId',
                                  //       state.shopsDrawer[index].id);
                                  //   GetStorage()
                                  //       .write('shopSelectedIndexSort', index);

                                  //   setState(() {
                                  //     _selectedIndexSort = index;
                                  //   });
                                  // }

                                  // Get.back();

                                  if (_selectedListSort.contains(state.shopsDrawer[index].id)) {
                                    _selectedListSort.remove(state.shopsDrawer[index].id);
                                  } else {
                                    _selectedListSort.add(state.shopsDrawer[index].id as int);
                                  }

                                  GetStorage().write('shopFilterId', _selectedListSort.toString());

                                  setState(() {});

                                  // print(GetStorage().read('shopFilterId'));
                                },
                                child: ListTile(
                                  selected: _selectedListSort.contains(state.shopsDrawer[index].id),
                                  leading: Text(
                                    state.shopsDrawer[index].name.toString(),
                                    style: AppTextStyles.appBarTextStyle,
                                  ),
                                  trailing: _selectedListSort.contains(state.shopsDrawer[index].id)
                                      ? SvgPicture.asset(
                                          'assets/icons/check_circle.svg',
                                        )
                                      : SvgPicture.asset(
                                          'assets/icons/check_circle_no_selected.svg',
                                        ),
                                )),
                          );
                        },
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(left: 0, right: 0, top: 16, bottom: 26),
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<productCubit.ProductCubit>(context).products();
                          Navigator.pop(context);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.kPrimaryColor,
                            ),
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(16),
                            child: const Text(
                              'Готово',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ),
                  ],
                ));
          } else {
            return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
          }
        });
  }
}
