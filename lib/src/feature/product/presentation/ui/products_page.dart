import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/product/cubit/product_cubit.dart'
    as productCubit;
import 'package:haji_market/src/feature/product/cubit/product_state.dart'
    as productState;
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
import 'package:haji_market/src/feature/product/presentation/widgets/cats_widget.dart';
import 'package:haji_market/src/feature/product/presentation/widgets/product_widget.dart';
import 'package:haji_market/src/feature/product/presentation/widgets/show_filtr_price_widget.dart';
import 'package:haji_market/src/feature/product/presentation/widgets/show_list_brands_widget.dart';
import 'package:haji_market/src/feature/seller/product/presentation/widgets/show_list_characteristics_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../home/data/model/cat_model.dart';
import '../../../drawer/bloc/brand_cubit.dart' as brandCubit;
import 'package:haji_market/src/feature/drawer/bloc/brand_state.dart'
    as brandState;
import '../../cubit/product_ad_cubit.dart';
import '../../cubit/product_ad_state.dart';
import '../widgets/product_ad_card.dart';

@RoutePage()
class ProductsPage extends StatefulWidget {
  final CatsModel cats;
  final CatsModel? subCats;

  int? brandId;
  String? shopId;

  ProductsPage(
      {required this.cats, this.brandId, this.shopId, this.subCats, Key? key})
      : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final boxMain = GetStorage().write('rating', false);
  bool? catsVisible = false;
  TextEditingController searchController = TextEditingController();

  List<CatsModel> subCats = [];
  List<CatsModel> brands = [];

  CatsModel? subCat;
  CatsModel? brand;
  bool sortIcon = false;
  bool filterIcon = false;

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
    if (widget.brandId == null) {
      GetStorage().remove('brandFilterId');
    }
    if (widget.cats.id == 0 && widget.cats.name == null) {
      GetStorage().remove('search');
    }
    GetStorage().remove('sub_cat_id');
    GetStorage().remove('subCatId');

    if (widget.subCats == null) {
      GetStorage().remove('subCatFilterId');
    }

    if (widget.shopId == null) {
      GetStorage().remove('shopFilterId');
    }
    GetStorage().remove('ratingFilter');
    GetStorage().remove('rating');

    BlocProvider.of<shopsDrawerCubit.ShopsDrawerCubit>(context)
        .shopsDrawer(widget.cats.id);
    BlocProvider.of<brandCubit.BrandCubit>(context)
        .brands(subCatId: widget.cats.id);
    BlocProvider.of<ProductAdCubit>(context)
        .adProducts(GetStorage().read('CatId'));
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

  @override
  void dispose() {
    scrollView!.call();
    GetStorage().remove('scrollView');
    super.dispose();
  }

  int page = 1;
  final RefreshController _refreshController = RefreshController();

  Future<void> onLoading() async {
    await BlocProvider.of<productCubit.ProductCubit>(context)
        .productsPagination();
    await Future.delayed(const Duration(milliseconds: 2000));
    _refreshController.loadComplete();
  }

  Future<void> onRefresh() async {
    await BlocProvider.of<productCubit.ProductCubit>(context).products();
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {});
    }
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kGray1,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            GetStorage().remove('CatId');
            GetStorage().remove('subCatFilterId');
            GetStorage().remove('shopFilterId');
            GetStorage().remove('search');
            // Navigator.pop(context);
            context.router.pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Container(
          width: 311,
          height: 40,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(10)),
          child: TextField(
            controller: searchController,
            onChanged: (value) {
              GetStorage().write('search', value);

              BlocProvider.of<productCubit.ProductCubit>(context).products();
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(4),
              prefixIcon: Image.asset(
                Assets.icons.defaultSearchIcon.path,
                scale: 1.8,
              ),
              hintText: 'Поиск',
              hintMaxLines: 1,
              hintStyle: TextStyle(
                  color: AppColors.kGray300,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
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
          SizedBox(height: 12),
          Container(
            width: 358,
            height: 80,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  transform: const GradientRotation(
                      128.49 * 3.1415926535 / 180), // 128.49° в радианы
                  colors: [
                    const Color(0xFF7D2DFF)
                        .withOpacity(0.2), // rgba(125, 45, 255, 0.2)
                    const Color(0xFF41DDFF)
                        .withOpacity(0.2), // rgba(65, 221, 255, 0.2)
                  ],
                  stops: const [0.2685, 1.0], // 26.85% и 100%
                ),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
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
                        textAlign: TextAlign.end,
                        style: AppTextStyles.size14Weight400,
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
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
                )
              ],
            ),
          ),

          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: brands.length,
              padding: const EdgeInsets.symmetric(
                  horizontal: 16), // Добавляем отступы по бокам
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (brand?.id == brands[index].id) {
                      brand = null;
                      GetStorage().remove('brandFilterId');
                      BlocProvider.of<productCubit.ProductCubit>(context)
                          .products();
                      setState(() {});

                      return;
                    }

                    List<int> ids = [];

                    ids.add(brands[index].id!);

                    GetStorage().write('brandFilterId', ids.toString());
                    BlocProvider.of<productCubit.ProductCubit>(context)
                        .products();
                    brand = brands[index];
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        right: 8), // Отступ между элементами
                    child: Stack(children: [
                      brand?.id == brands[index].id
                          ? Positioned(
                              top: 45,
                              left: 45,
                              child: Icon(
                                Icons.check_circle,
                                size: 18,
                              ),
                            )
                          : SizedBox.shrink(),
                      Container(
                        height: 64,
                        width: 64,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: brands[index].icon != null
                                ? NetworkImage(
                                    "https://lunamarket.ru/storage/${brands[index].icon}")
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
                    ]),
                  ),
                );
              },
            ),
          ),

          InkWell(
            onTap: () {
              showListBrandsOptions(context, 'Подкатегории', 'params', subCats,
                  (CatsModel value) {
                if (subCat?.name == value.name) {
                  subCat = null;
                  setState(() {});
                  GetStorage().remove('subCatId');
                } else {
                  GetStorage().write('subCatId', value.id);
                  GetStorage().write('subCatFilterId', value.id);
                  setState(() {
                    subCat = value;
                  });
                }
                BlocProvider.of<productCubit.ProductCubit>(context).products();
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              height: 40,
              decoration: BoxDecoration(
                  color: AppColors.kGray2,
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Image.asset(
                    Assets.icons.subListIcon.path,
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(subCat?.name ?? 'Подкатегории',
                      style: AppTextStyles.size16Weight500),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: AppColors.kGray300,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          // Container(
          //   color: Colors.white,
          //   padding: const EdgeInsets.only(left: 16),
          //   child: const CatsProductWidget(),
          // ),
          Expanded(
            child: SmartRefresher(
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
                // shrinkWrap: false,
                // physics: NeverScrollableScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    snap: true,
                    floating: true,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    forceElevated: false,
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
                                  padding: const EdgeInsets.only(
                                      bottom: 10, right: 8, top: 10),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          final List<CatsModel> sorts = [
                                            CatsModel(
                                                id: 1, name: 'Популярные'),
                                            CatsModel(id: 2, name: 'Новинки'),
                                            CatsModel(
                                                id: 3, name: 'Сначала дешевые'),
                                            CatsModel(
                                                id: 4, name: 'Сначала дорогие'),
                                            CatsModel(
                                                id: 5, name: 'Высокий рейтинг'),
                                          ];

                                          showListBrandsOptions(
                                              context,
                                              'Сортировка',
                                              'params',
                                              sorts, (CatsModel value) {
                                            switch (value.name) {
                                              case 'Популярные':
                                                GetStorage().write('sortFilter',
                                                    'orderByPopular');
                                                break;
                                              case 'Новинки':
                                                GetStorage().write(
                                                    'sortFilter', 'orderByNew');
                                                break;
                                              case 'Сначала дешевые':
                                                GetStorage().write(
                                                    'sortFilter', 'priceAsc');
                                                break;
                                              case 'Сначала дорогие':
                                                GetStorage().write(
                                                    'sortFilter', 'priceDesc');
                                                break;
                                              case 'Высокий рейтинг':
                                                GetStorage().write(
                                                    'sortFilter', 'rating');
                                                break;
                                              default:
                                                print("число не равно 1, 2, 3");
                                            }

                                            sortIcon = true;
                                            setState(() {});
                                            BlocProvider.of<
                                                    productCubit
                                                    .ProductCubit>(context)
                                                .products();
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
                                                      BorderRadius.circular(
                                                          12)),
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
                                                    FilterPage(
                                                        shopId: widget.shopId)),
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
                                                      BorderRadius.circular(
                                                          12)),
                                              child: SvgPicture.asset(
                                                Assets.icons.filter.path,
                                                color: Colors.black,
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
                                        width: 6,
                                      ),

                                      InkWell(
                                        onTap: () {
                                          final List<CatsModel> sorts = [
                                            CatsModel(
                                                id: 1, name: 'Сегодня,завтра'),
                                            CatsModel(id: 2, name: 'До 2 дней'),
                                            CatsModel(id: 3, name: 'До 5 дней'),
                                            CatsModel(id: 4, name: 'До 7 дней'),
                                          ];

                                          showListBrandsOptions(
                                              context,
                                              'Доставка',
                                              'params',
                                              sorts, (CatsModel value) {
                                            switch (value.name) {
                                              case 'Сегодня,завтра':
                                                GetStorage().write(
                                                    'dellivery', 'one_day');
                                                break;
                                              case 'До 2 дней':
                                                GetStorage().write(
                                                    'dellivery', 'two_day');
                                                break;
                                              case 'До 5 дней':
                                                GetStorage().write(
                                                    'dellivery', 'three_day');
                                                break;
                                              case 'До 7 дней':
                                                GetStorage().write(
                                                    'dellivery', 'seven_day');
                                                break;

                                              default:
                                                GetStorage().write(
                                                    'dellivery', 'one_day');
                                            }
                                            BlocProvider.of<
                                                    productCubit
                                                    .ProductCubit>(context)
                                                .products();
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Доставка',
                                                    style: AppTextStyles
                                                        .kcolorPrimaryTextStyle
                                                        .copyWith(
                                                            color: AppColors
                                                                .kLightBlackColor),
                                                  ),
                                                  Icon(Icons.arrow_drop_down)
                                                ],
                                              ),
                                            )),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),

                                      const SizedBox(
                                        width: 6,
                                      ),

                                      InkWell(
                                        onTap: () {
                                          showFiltrPriceOptions(
                                              context, 'Цена,₸',
                                              (CatsModel value) {
                                            BlocProvider.of<
                                                    productCubit
                                                    .ProductCubit>(context)
                                                .products();
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Цена',
                                                    style: AppTextStyles
                                                        .kcolorPrimaryTextStyle
                                                        .copyWith(
                                                            color: AppColors
                                                                .kLightBlackColor),
                                                  ),
                                                  Icon(Icons.arrow_drop_down)
                                                ],
                                              ),
                                            )),
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),

                                      // const chipWithDropDown(label: 'Цена'),
                                      // const SizedBox(
                                      //   width: 6,
                                      // ),
                                      // const chipWithDropDown(label: 'Бренд'),
                                      // const SizedBox(
                                      //   width: 6,
                                      // ),
                                      // widget.shopId == null
                                      //     ? const chipWithDropDown(
                                      //         label: 'Продавцы')
                                      //     : SizedBox.shrink(),
                                      // const SizedBox(
                                      //   width: 6,
                                      // ),
                                      // const chipWithDropDown(
                                      //     label: 'Высокий рейтинг'),
                                    ],
                                  ),
                                )),
                          ),
                          // Container(
                          //   height: 70,
                          //   color: Colors.white,
                          //   child: IconButton(
                          //     icon: SvgPicture.asset('assets/icons/filter.svg'),
                          //     onPressed: () {

                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  // SliverList.list(children: [
                  //   BlocConsumer<ProductAdCubit, ProductAdState>(
                  //       listener: (context, state) {},
                  //       builder: (context, state) {
                  //         if (state is ErrorState) {
                  //           return Center(
                  //             child: Text(
                  //               state.message,
                  //               style: const TextStyle(
                  //                   fontSize: 20.0, color: Colors.grey),
                  //             ),
                  //           );
                  //         }
                  //         if (state is LoadingState) {
                  //           return const Center(
                  //               child: CircularProgressIndicator(
                  //                   color: Colors.indigoAccent));
                  //         }

                  //         if (state is LoadedState) {
                  //           return state.productModel.isNotEmpty
                  //               ? LimitedBox(
                  //                   maxHeight: 250,
                  //                   child: ListView.builder(
                  //                     scrollDirection: Axis.horizontal,
                  //                     // shrinkWrap: true,
                  //                     itemCount: state.productModel.length < 6
                  //                         ? state.productModel.length
                  //                         : 6,
                  //                     itemBuilder: (BuildContext ctx, index) {
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
                  //                   ),
                  //                 )
                  //               : Container();
                  //         } else {
                  //           return Container();
                  //         }
                  //       }),

                  // const SizedBox(
                  //   height: 10,
                  // ),
                  //   BlocBuilder<productCubit.ProductCubit,
                  //       productState.ProductState>(
                  //     builder: (context, state) {
                  //       if (state is productState.LoadedState) {
                  //         return Container(
                  //           padding: const EdgeInsets.only(
                  //               left: 16, top: 11, bottom: 8),
                  //           alignment: Alignment.centerLeft,
                  //           child: Text(
                  //             'Найдено ${state.productModel.length} товаров',
                  //             style: const TextStyle(
                  //                 fontSize: 16,
                  //                 fontWeight: FontWeight.w500,
                  //                 color: Color.fromRGBO(144, 148, 153, 1)),
                  //           ),
                  //         );
                  //       }
                  //       return const SizedBox();
                  //     },
                  //   )
                  // ]),

                  const ProductWidget(),

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
                if (GetStorage().read('priceFilter') != null) {
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
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 16, bottom: 26),
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<productCubit.ProductCubit>(context)
                              .products();

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
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
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
          if (state is brandState.NoDataState) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              width: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 130),
                      child: Image.asset('assets/icons/no_data.png')),
                  const Text(
                    'Нет данных',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'Под эту категорию нет брендов',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff717171)),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                        left: 0, right: 0, top: 22, bottom: 26),
                    child: InkWell(
                      onTap: () {
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
                            'Закрыть',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is brandState.LoadedState) {
            return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      height: 360,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
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

                                  if (_selectedListSort
                                      .contains(state.cats[index].id as int)) {
                                    _selectedListSort
                                        .remove(state.cats[index].id as int);
                                  } else {
                                    _selectedListSort
                                        .add(state.cats[index].id as int);
                                  }

                                  GetStorage().write('brandFilterId',
                                      _selectedListSort.toString());

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
                                  selected: _selectedListSort
                                      .contains(state.cats[index].id),
                                  leading: Text(
                                    state.cats[index].name.toString(),
                                    style: AppTextStyles.appBarTextStyle,
                                  ),
                                  trailing: _selectedListSort
                                          .contains(state.cats[index].id)
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
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 16, bottom: 26),
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<productCubit.ProductCubit>(context)
                              .products();
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
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ),
                  ],
                ));
          } else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent));
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
    return BlocConsumer<shopsDrawerCubit.ShopsDrawerCubit,
            shopsDrawerState.ShopsDrawerState>(
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
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent));
          }

          if (state is shopsDrawerState.LoadedState) {
            return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      height: 360,
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
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

                                  if (_selectedListSort
                                      .contains(state.shopsDrawer[index].id)) {
                                    _selectedListSort
                                        .remove(state.shopsDrawer[index].id);
                                  } else {
                                    _selectedListSort.add(
                                        state.shopsDrawer[index].id as int);
                                  }

                                  GetStorage().write('shopFilterId',
                                      _selectedListSort.toString());

                                  setState(() {});

                                  // print(GetStorage().read('shopFilterId'));
                                },
                                child: ListTile(
                                  selected: _selectedListSort
                                      .contains(state.shopsDrawer[index].id),
                                  leading: Text(
                                    state.shopsDrawer[index].name.toString(),
                                    style: AppTextStyles.appBarTextStyle,
                                  ),
                                  trailing: _selectedListSort
                                          .contains(state.shopsDrawer[index].id)
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
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 16, bottom: 26),
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<productCubit.ProductCubit>(context)
                              .products();
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
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                              textAlign: TextAlign.center,
                            )),
                      ),
                    ),
                  ],
                ));
          } else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent));
          }
        });
  }
}
