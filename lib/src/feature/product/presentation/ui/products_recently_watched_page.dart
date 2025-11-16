import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';

import 'package:haji_market/src/feature/drawer/bloc/shops_drawer_cubit.dart'
    as shopsDrawerCubit;
import 'package:haji_market/src/feature/drawer/bloc/shops_drawer_state.dart'
    as shopsDrawerState;
import 'package:haji_market/src/feature/drawer/bloc/sub_cats_cubit.dart'
    as subCatCubit;
import 'package:haji_market/src/feature/drawer/bloc/sub_cats_state.dart'
    as subCatState;
import 'package:haji_market/src/feature/drawer/presentation/widgets/filter_page.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/product/cubit/recently_watched_product_cubit.dart';
import 'package:haji_market/src/feature/product/presentation/widgets/product_recently_wached_widget.dart';
import 'package:haji_market/src/feature/product/presentation/widgets/show_filtr_price_widget.dart';
import 'package:haji_market/src/feature/product/presentation/widgets/show_list_brands_widget.dart';
import 'package:haji_market/src/feature/product/provider/filter_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../home/data/model/cat_model.dart';
import '../../../drawer/bloc/brand_cubit.dart' as brandCubit;
import 'package:haji_market/src/feature/drawer/bloc/brand_state.dart'
    as brandState;

@RoutePage()
class ProductsRecentlyWatchedPage extends StatefulWidget {
  final CatsModel cats;
  final CatsModel? subCats;

  int? brandId;
  String? shopId;

  ProductsRecentlyWatchedPage(
      {required this.cats, this.brandId, this.shopId, this.subCats, Key? key})
      : super(key: key);

  @override
  State<ProductsRecentlyWatchedPage> createState() =>
      _ProductsRecentlyWatchedPageState();
}

class _ProductsRecentlyWatchedPageState
    extends State<ProductsRecentlyWatchedPage> {
  final boxMain = GetStorage().write('rating', false);
  final _box = GetStorage();

  // late final dynamic
  //     _scrollViewListener; // может быть StreamSubscription или VoidCallback

  late final dynamic _charFilterListener;
  // bool _hideProducts = false;

  List<CatsModel> subCats = [];
  List<CatsModel> brands = [];

  CatsModel? subCat;
  CatsModel? brand;
  bool sortIcon = false;
  bool filterIcon = false;

  int selectedSortIndex = -1;
  int selectedDelliveryIndex = -1;
  String? selectedDelliveryText;

  Function? scrollView;

  String? filterPriceLabel;

  @override
  void initState() {
    subCat = widget.subCats;
    if (widget.brandId != null) {
      brand = CatsModel(id: widget.brandId, name: '');
    }

    // final initial = _box.read('scrollView');
    // _hideProducts = initial is bool ? initial : (initial == 'true');

    // слушаем изменения ключа 'scrollView'
    // _scrollViewListener = _box.listenKey('scrollView', (value) {
    // if (!mounted) return;
    // final v = value is bool ? value : (value == 'true');
    // if (v != _hideProducts) {
    //   setState(() => _hideProducts = v);
    // }
    // });

    _charFilterListener = _box.listenKey('charFilterId', (value) {
      if (!mounted) return;
      filterCharIcon(value);
    });
    BlocProvider.of<shopsDrawerCubit.ShopsDrawerCubit>(context)
        .shopsDrawer(widget.cats.id);
    BlocProvider.of<brandCubit.BrandCubit>(context)
        .brands(subCatId: widget.cats.id);

    final filters = context.read<FilterProvider>();
    BlocProvider.of<RecentlyWatchedProductCubit>(context).products(filters);
    subCatCubit.SubCatsCubit subCatsCubit =
        BlocProvider.of<subCatCubit.SubCatsCubit>(context);
    if (subCatsCubit.state is! subCatState.LoadedState) {
      subCatsCubit.subCats(widget.cats.id);
    }

    subCatList();
    brandList();

    super.initState();
  }

  subCatList() async {
    subCatCubit.SubCatsCubit subCatsCubit =
        BlocProvider.of<subCatCubit.SubCatsCubit>(context);
    final List<CatsModel> data = await subCatsCubit.subCatList(widget.cats.id);
    subCats.addAll(data);
    setState(() {});
  }

  brandList() async {
    final List<CatsModel> data =
        await BlocProvider.of<brandCubit.BrandCubit>(context).brandsList();
    brands.addAll(data);
    setState(() {});
  }

  void filterCharIcon(value) {
    if (value != null) {
      setState(() => filterIcon = true);
    } else {
      setState(() => filterIcon = false);
    }
  }

  @override
  void dispose() {
    GetStorage().remove('scrollView');

    // if (_scrollViewListener is Function) {
    //   (_scrollViewListener as void Function()).call();
    // } else {
    //   try {
    //     _scrollViewListener.cancel();
    //   } catch (_) {}
    // }
    // _focus.dispose();
    super.dispose();
  }

  int page = 1;
  final RefreshController _refreshController = RefreshController();

  final TextEditingController searchController = TextEditingController();
  Future<void> onLoading() async {
    final filters = context.read<FilterProvider>();

    await BlocProvider.of<RecentlyWatchedProductCubit>(context)
        .products(filters);
    await Future.delayed(const Duration(milliseconds: 2000));
    _refreshController.loadComplete();
  }

  Future<void> onRefresh() async {
    final filters = context.read<FilterProvider>();

    await BlocProvider.of<RecentlyWatchedProductCubit>(context)
        .products(filters);
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
        surfaceTintColor: AppColors.kWhite,
        title: Text(
          'Недавно смотрели',
          style: AppTextStyles.size18Weight600,
        ),
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              final filters = context.read<FilterProvider>();

              filters.resetAll();

              context.router.pop();

              BlocProvider.of<RecentlyWatchedProductCubit>(context)
                  .products(filters);
            },
            child: Image.asset(
              Assets.icons.defaultBackIcon.path,
              scale: 2.1,
            )),
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onLoading: () {
            onLoading();
          },
          onRefresh: () {
            onRefresh();
          },
          child: CustomScrollView(slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              pinned: false,
              elevation: 0,
              backgroundColor: AppColors.kWhite,
              surfaceTintColor: Colors.transparent,
              toolbarHeight: 110,
              automaticallyImplyLeading: false,
              expandedHeight: 110,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.none,
                background: SafeArea(
                  bottom: false,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12)),
                      color: AppColors.kWhite,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // <-- важно
                      children: [
                        Container(
                          height: 40,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(right: 16, left: 16),
                          decoration: BoxDecoration(
                              color: const Color(0xFFF8F8F8),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              final filters = context.read<FilterProvider>();

                              filters.setSearch(value);

                              BlocProvider.of<RecentlyWatchedProductCubit>(
                                      context)
                                  .products(filters);
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(4),
                              suffixIconConstraints:
                                  BoxConstraints(maxHeight: 20, maxWidth: 20),
                              prefixIcon: SizedBox(
                                height: 20,
                                width: 20,
                                child: Image.asset(
                                  Assets.icons.defaultSearchIcon.path,
                                  scale: 3.1,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              hintText: 'Искать',
                              hintMaxLines: 1,
                              hintStyle: AppTextStyles.size16Weight700
                                  .copyWith(color: Color(0xff8E8E93)),
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          height: 40,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            children: [
                              InkWell(
                                onTap: () {
                                  final filters =
                                      context.read<FilterProvider>();

                                  final List<CatsModel> sorts = [
                                    CatsModel(id: 1, name: 'Популярные'),
                                    CatsModel(id: 2, name: 'Новинки'),
                                    CatsModel(id: 3, name: 'Сначала дешевые'),
                                    CatsModel(id: 4, name: 'Сначала дорогие'),
                                    CatsModel(id: 5, name: 'Высокий рейтинг'),
                                  ];

                                  showListBrandsOptions(
                                      context,
                                      'Сортировка',
                                      'params',
                                      sorts,
                                      selectedSortIndex, (CatsModel value) {
                                    if (value.id != 0) {
                                      selectedSortIndex = value.id!;
                                      String sortKey = '';
                                      switch (value.name) {
                                        case 'Популярные':
                                          sortKey = 'orderByPopular';

                                          break;
                                        case 'Новинки':
                                          sortKey = 'orderByNew';
                                          break;
                                        case 'Сначала дешевые':
                                          sortKey = 'priceAsc';
                                          break;
                                        case 'Сначала дорогие':
                                          sortKey = 'priceDesc';
                                          break;
                                        case 'Высокий рейтинг':
                                          sortKey = 'rating';
                                          break;
                                        default:
                                          print("число не равно 1, 2, 3");
                                      }

                                      filters.setSort(sortKey);
                                      sortIcon = true;
                                    } else {
                                      sortIcon = false;
                                      selectedSortIndex = -1;
                                    }

                                    setState(() {});

                                    BlocProvider.of<
                                                RecentlyWatchedProductCubit>(
                                            context)
                                        .products(filters);
                                  });
                                },
                                child: Stack(children: [
                                  Container(
                                      height: 36,
                                      width: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: AppColors.kGray1,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: SizedBox(
                                        height: 10,
                                        width: 15,
                                        child: Image.asset(
                                          Assets.icons.upDownIcon.path,
                                          height: 10,
                                          width: 15,
                                        ),
                                      )),
                                  sortIcon == true
                                      ? Positioned(
                                          top: 10,
                                          right: 10,
                                          child: Icon(
                                            Icons.circle,
                                            size: 7,
                                            color: Colors.red,
                                          ),
                                        )
                                      : SizedBox.shrink()
                                ]),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FilterPage(shopId: widget.shopId)),
                                  );
                                  filterIcon = true;
                                  setState(() {});
                                },
                                child: Stack(children: [
                                  Container(
                                      height: 36,
                                      width: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: AppColors.kGray1,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: SizedBox(
                                        height: 11.5,
                                        width: 15,
                                        child: Image.asset(
                                          Assets.icons.filterBlackIcon.path,
                                          color: Colors.black,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                  filterIcon == true
                                      ? Positioned(
                                          top: 10,
                                          right: 10,
                                          child: Icon(
                                            Icons.circle,
                                            size: 7,
                                            color: Colors.red,
                                          ),
                                        )
                                      : SizedBox.shrink()
                                ]),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                onTap: () {
                                  final filters =
                                      context.read<FilterProvider>();

                                  final List<CatsModel> sorts = [
                                    CatsModel(id: 1, name: 'Сегодня,завтра'),
                                    CatsModel(id: 2, name: 'До 2 дней'),
                                    CatsModel(id: 3, name: 'До 5 дней'),
                                    CatsModel(id: 4, name: 'До 7 дней'),
                                  ];

                                  showListBrandsOptions(context, 'Доставка',
                                      'params', sorts, selectedDelliveryIndex,
                                      (CatsModel value) {
                                    selectedDelliveryIndex = value.id ?? -1;

                                    String delliveryKey = '';

                                    switch (value.name) {
                                      case 'Сегодня,завтра':
                                        delliveryKey = 'one_day';
                                        selectedDelliveryText =
                                            'Сегодня,завтра';

                                        break;
                                      case 'До 2 дней':
                                        delliveryKey = 'two_day';
                                        selectedDelliveryText = 'До 2 дней';

                                        break;
                                      case 'До 5 дней':
                                        delliveryKey = 'three_day';
                                        selectedDelliveryText = 'До 5 дней';
                                        break;
                                      case 'До 7 дней':
                                        delliveryKey = 'seven_day';
                                        selectedDelliveryText = 'До 7 дней';
                                        break;

                                      default:
                                        delliveryKey = '';
                                        selectedDelliveryText = null;
                                    }

                                    setState(() {});
                                    filters.setDelivery(delliveryKey);
                                    BlocProvider.of<
                                                RecentlyWatchedProductCubit>(
                                            context)
                                        .products(filters);
                                  });
                                },
                                child: Container(
                                    height: 36,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: AppColors.kGray1,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            selectedDelliveryText ?? 'Доставка',
                                            style: AppTextStyles.size14Weight400
                                                .copyWith(
                                              color: selectedDelliveryText !=
                                                      null
                                                  ? AppColors.mainPurpleColor
                                                  : null,
                                              fontWeight:
                                                  selectedDelliveryText != null
                                                      ? FontWeight.w500
                                                      : null,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          SizedBox(
                                            height: 6,
                                            width: 12,
                                            child: Image.asset(
                                              Assets.icons.dropDownIcon.path,
                                              color: selectedDelliveryText !=
                                                      null
                                                  ? AppColors.mainPurpleColor
                                                  : null,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              InkWell(
                                onTap: () {
                                  final filters =
                                      context.read<FilterProvider>();
                                  showFiltrPriceOptions(context, 'Цена,₸',
                                      (value) {
                                    setState(() {
                                      filterPriceLabel = value;
                                    });
                                    Navigator.pop(context);

                                    BlocProvider.of<
                                                RecentlyWatchedProductCubit>(
                                            context)
                                        .products(filters);
                                  });
                                },
                                child: Container(
                                    height: 36,
                                    // width: 80,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: AppColors.kGray1,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            filterPriceLabel ?? 'Цена',
                                            style: AppTextStyles.size14Weight500
                                                .copyWith(
                                                    color: (filterPriceLabel !=
                                                            null)
                                                        ? AppColors
                                                            .mainPurpleColor
                                                        : AppColors
                                                            .kLightBlackColor,
                                                    fontWeight:
                                                        (filterPriceLabel !=
                                                                null)
                                                            ? FontWeight.w500
                                                            : null),
                                          ),
                                          SizedBox(width: 8),
                                          SizedBox(
                                            height: 6,
                                            width: 12,
                                            child: Image.asset(
                                                Assets.icons.dropDownIcon.path,
                                                color: (filterPriceLabel !=
                                                        null)
                                                    ? AppColors.mainPurpleColor
                                                    : null),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const ProductRecentlyWachedWidget(),
          ])),
    );
  }
}
