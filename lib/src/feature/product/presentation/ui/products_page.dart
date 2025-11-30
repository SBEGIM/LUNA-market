import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/product/cubit/product_cubit.dart' as productCubit;
import 'package:haji_market/src/feature/product/cubit/product_state.dart' as productState;
import 'package:haji_market/src/feature/drawer/bloc/shops_drawer_cubit.dart' as shopsDrawerCubit;
import 'package:haji_market/src/feature/drawer/bloc/shops_drawer_state.dart' as shopsDrawerState;
import 'package:haji_market/src/feature/drawer/bloc/sub_cats_cubit.dart' as subCatCubit;
import 'package:haji_market/src/feature/drawer/bloc/sub_cats_state.dart' as subCatState;
import 'package:haji_market/src/feature/drawer/presentation/widgets/filter_page.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/product/presentation/widgets/product_widget.dart';
import 'package:haji_market/src/feature/product/presentation/widgets/show_filtr_price_widget.dart';
import 'package:haji_market/src/feature/product/presentation/widgets/show_list_brands_widget.dart';
import 'package:haji_market/src/feature/product/provider/filter_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../home/data/model/cat_model.dart';
import '../../../drawer/bloc/brand_cubit.dart' as brandCubit;
import 'package:haji_market/src/feature/drawer/bloc/brand_state.dart' as brandState;
import '../../cubit/product_ad_cubit.dart';

@RoutePage()
class ProductsPage extends StatefulWidget {
  final CatsModel cats;
  final CatsModel? subCats;

  int? brandId;
  String? shopId;

  ProductsPage({required this.cats, this.brandId, this.shopId, this.subCats, Key? key})
    : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
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
    BlocProvider.of<shopsDrawerCubit.ShopsDrawerCubit>(context).shopsDrawer(widget.cats.id);
    BlocProvider.of<brandCubit.BrandCubit>(context).brands(subCatId: widget.cats.id);
    // BlocProvider.of<ProductAdCubit>(context)
    //     .adProducts(GetStorage().read('CatId'));
    subCatCubit.SubCatsCubit subCatsCubit = BlocProvider.of<subCatCubit.SubCatsCubit>(context);
    if (subCatsCubit.state is! subCatState.LoadedState) {
      subCatsCubit.subCats(widget.cats.id);
    }

    subCatList();
    brandList();

    super.initState();
  }

  subCatList() async {
    subCatCubit.SubCatsCubit subCatsCubit = BlocProvider.of<subCatCubit.SubCatsCubit>(context);
    final List<CatsModel> data = await subCatsCubit.subCatList(widget.cats.id);
    subCats.addAll(data);
    setState(() {});
  }

  brandList() async {
    final List<CatsModel> data = await BlocProvider.of<brandCubit.BrandCubit>(context).brandsList();
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

  Future<void> onLoading() async {
    final filters = context.read<FilterProvider>();

    await BlocProvider.of<productCubit.ProductCubit>(context).productsPagination(filters);
    await Future.delayed(const Duration(milliseconds: 2000));
    _refreshController.loadComplete();
  }

  Future<void> onRefresh() async {
    final filters = context.read<FilterProvider>();

    await BlocProvider.of<productCubit.ProductCubit>(context).products(filters);
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

        title: Text('${widget.cats.name}', style: AppTextStyles.size18Weight600),

        actionsPadding: EdgeInsets.only(right: 8),
        actions: [
          IconButton(
            icon: Image.asset(
              Assets.icons.defaultSearchIcon.path,
              scale: 2.1,
              height: 24,
              width: 24,
              color: Colors.black,
            ),
            onPressed: () {
              context.router.push(SearchProductRoute());
            },
            tooltip: 'Поиск',
          ),
        ],

        backgroundColor: Colors.white,
        elevation: 0,
        // Container(
        //   width: 311,
        //   height: 40,
        //   alignment: Alignment.center,
        //   margin: const EdgeInsets.only(right: 16),
        //   decoration: BoxDecoration(
        //       color: const Color(0xFFF8F8F8),
        //       borderRadius: BorderRadius.circular(10)),
        //   child: TextField(
        //     controller: searchController,
        //     onChanged: (value) {
        //       GetStorage().write('search', value);

        //       BlocProvider.of<productCubit.ProductCubit>(context).products();
        //     },
        //     decoration: InputDecoration(
        //       contentPadding: EdgeInsets.all(4),
        //       suffixIconConstraints:
        //           BoxConstraints(maxHeight: 20, maxWidth: 20),
        //       prefixIcon: SizedBox(
        //         height: 20,
        //         width: 20,
        //         child: Image.asset(
        //           Assets.icons.defaultSearchIcon.path,
        //           scale: 3.1,
        //           height: 20,
        //           width: 20,
        //         ),
        //       ),
        //       hintText: 'Поиск',
        //       hintMaxLines: 1,
        //       hintStyle: TextStyle(
        //           color: AppColors.kGray300,
        //           fontSize: 16,
        //           fontWeight: FontWeight.w500),
        //       border: InputBorder.none,
        //     ),
        //     style: const TextStyle(
        //       color: Colors.black,
        //     ),
        //   ),
        // ),
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
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              pinned: false,
              elevation: 0,
              backgroundColor: AppColors.kWhite,
              surfaceTintColor: Colors.transparent,
              toolbarHeight: 100,
              automaticallyImplyLeading: false,
              expandedHeight: 300,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.none,
                background: SafeArea(
                  bottom: false,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      color: AppColors.kWhite,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // <-- важно
                      children: [
                        SizedBox(height: 12),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                              transform: const GradientRotation(
                                128.49 * 3.1415926535 / 180,
                              ), // 128.49° в радианы
                              colors: [
                                const Color(0xFF7D2DFF).withOpacity(0.2), // rgba(125, 45, 255, 0.2)
                                const Color(0xFF41DDFF).withOpacity(0.2), // rgba(65, 221, 255, 0.2)
                              ],
                              stops: const [0.2685, 1.0], // 26.85% и 100%
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.cats.name}',
                                      style: AppTextStyles.size16Weight600,
                                    ),
                                    Text(
                                      '${widget.cats.text}',
                                      style: AppTextStyles.size14Weight400,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                child: Image.network(
                                  "https://lunamarket.ru/storage/${widget.cats.image}",
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                                    loadingProgress.expectedTotalBytes!
                                              : null,
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    color: Colors.grey[200],
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.broken_image,
                                      color: Colors.grey,
                                      size: 48,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: brands.length,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  final filters = context.read<FilterProvider>();

                                  if (brand?.id == brands[index].id) {
                                    brand = null;
                                    GetStorage().remove('brandFilterId');
                                    BlocProvider.of<productCubit.ProductCubit>(
                                      context,
                                    ).products(filters);
                                    setState(() {});

                                    return;
                                  }

                                  List<int> ids = [];

                                  ids.add(brands[index].id!);

                                  GetStorage().write('brandFilterId', ids.toString());
                                  BlocProvider.of<productCubit.ProductCubit>(
                                    context,
                                  ).products(filters);
                                  brand = brands[index];
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    right: 8,
                                  ), // Отступ между элементами
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 64,
                                        width: 64,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: brands[index].icon != null
                                                ? NetworkImage(
                                                    "https://lunamarket.ru/storage/${brands[index].icon}",
                                                  )
                                                : const AssetImage('assets/icons/profile2.png')
                                                      as ImageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                          color: AppColors.mainBackgroundPurpleColor,
                                          border: Border.all(
                                            // Добавляем границу
                                            color: brand?.id == brands[index].id
                                                ? AppColors.mainPurpleColor
                                                : AppColors.purpleBorder, // Цвет границы
                                            width: 1.0, // Толщина границы
                                          ),
                                          shape: BoxShape
                                              .circle, // Используем shape вместо borderRadius для идеального круга
                                        ),
                                      ),
                                      brand?.id == brands[index].id
                                          ? Positioned(
                                              bottom: 16,
                                              right: 2,
                                              child: Image.asset(
                                                Assets.icons.brandSelectIcon.path,
                                                height: 18,
                                                width: 18,
                                              ),
                                            )
                                          : SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 6),
                        InkWell(
                          onTap: () {
                            final filters = context.read<FilterProvider>();
                            showListBrandsOptions(
                              context,
                              'Подкатегории',
                              'params',
                              subCats,
                              subCat?.id ?? -1,
                              (CatsModel value) {
                                if (subCat?.name == value.name || value.id == 0) {
                                  subCat = null;
                                  filters.resetSubCats();
                                } else {
                                  filters.setSubCats([value.id!]);
                                  subCat = value;
                                }
                                setState(() {});

                                BlocProvider.of<productCubit.ProductCubit>(
                                  context,
                                ).products(filters);
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xffF7F7F7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 8),
                                Image.asset(Assets.icons.subListIcon.path, height: 20, width: 20),
                                SizedBox(width: 8),
                                Text(
                                  subCat?.name ?? 'Подкатегории',
                                  style: AppTextStyles.size16Weight500,
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: AppColors.kGray300,
                                  ),
                                ),
                              ],
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
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            children: [
                              InkWell(
                                onTap: () {
                                  final filters = context.read<FilterProvider>();

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
                                    selectedSortIndex,
                                    (CatsModel value) {
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

                                      BlocProvider.of<productCubit.ProductCubit>(
                                        context,
                                      ).products(filters);
                                    },
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 36,
                                      width: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppColors.kGray1,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: SizedBox(
                                        height: 10,
                                        width: 15,
                                        child: Image.asset(
                                          Assets.icons.upDownIcon.path,
                                          height: 10,
                                          width: 15,
                                        ),
                                      ),
                                    ),
                                    sortIcon == true
                                        ? Positioned(
                                            top: 10,
                                            right: 10,
                                            child: Icon(Icons.circle, size: 7, color: Colors.red),
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 6),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FilterPage(shopId: widget.shopId),
                                    ),
                                  );
                                  filterIcon = true;
                                  setState(() {});
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 36,
                                      width: 40,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: AppColors.kGray1,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: SizedBox(
                                        height: 11.5,
                                        width: 15,
                                        child: Image.asset(
                                          Assets.icons.filterBlackIcon.path,
                                          color: Colors.black,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    filterIcon == true
                                        ? Positioned(
                                            top: 10,
                                            right: 10,
                                            child: Icon(Icons.circle, size: 7, color: Colors.red),
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  final filters = context.read<FilterProvider>();

                                  final List<CatsModel> sorts = [
                                    CatsModel(id: 1, name: 'Сегодня,завтра'),
                                    CatsModel(id: 2, name: 'До 2 дней'),
                                    CatsModel(id: 3, name: 'До 5 дней'),
                                    CatsModel(id: 4, name: 'До 7 дней'),
                                  ];

                                  showListBrandsOptions(
                                    context,
                                    'Доставка',
                                    'params',
                                    sorts,
                                    selectedDelliveryIndex,
                                    (CatsModel value) {
                                      selectedDelliveryIndex = value.id ?? -1;

                                      String delliveryKey = '';

                                      switch (value.name) {
                                        case 'Сегодня,завтра':
                                          delliveryKey = 'one_day';
                                          selectedDelliveryText = 'Сегодня,завтра';

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
                                      BlocProvider.of<productCubit.ProductCubit>(
                                        context,
                                      ).products(filters);
                                    },
                                  );
                                },
                                child: Container(
                                  height: 36,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.kGray1,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          selectedDelliveryText ?? 'Доставка',
                                          style: AppTextStyles.size14Weight400.copyWith(
                                            color: selectedDelliveryText != null
                                                ? AppColors.mainPurpleColor
                                                : null,
                                            fontWeight: selectedDelliveryText != null
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
                                            color: selectedDelliveryText != null
                                                ? AppColors.mainPurpleColor
                                                : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  final filters = context.read<FilterProvider>();
                                  showFiltrPriceOptions(context, 'Цена,₸', (value) {
                                    setState(() {
                                      filterPriceLabel = value;
                                    });
                                    Navigator.pop(context);

                                    BlocProvider.of<productCubit.ProductCubit>(
                                      context,
                                    ).products(filters);
                                  });
                                },
                                child: Container(
                                  height: 36,
                                  // width: 80,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.kGray1,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          filterPriceLabel ?? 'Цена',
                                          style: AppTextStyles.size14Weight500.copyWith(
                                            color: (filterPriceLabel != null)
                                                ? AppColors.mainPurpleColor
                                                : AppColors.kLightBlackColor,
                                            fontWeight: (filterPriceLabel != null)
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
                                            color: (filterPriceLabel != null)
                                                ? AppColors.mainPurpleColor
                                                : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const ProductWidget(),
          ],
        ),
      ),
    );
  }
}
