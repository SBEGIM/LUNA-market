import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/product/cubit/product_ad_cubit.dart'
    as productAdCubit;
import 'package:haji_market/src/feature/product/cubit/product_ad_state.dart'
    as productAdState;
import 'package:haji_market/src/feature/drawer/presentation/widgets/metas_webview.dart';
import 'package:haji_market/src/feature/home/bloc/banners_cubit.dart'
    as bannerCubit;
import 'package:haji_market/src/feature/home/bloc/banners_state.dart'
    as bannerState;
import 'package:haji_market/src/feature/home/bloc/partner_cubit.dart'
    as partnerCubit;
import 'package:haji_market/src/feature/home/bloc/partner_state.dart'
    as partnerState;
import 'package:haji_market/src/feature/home/bloc/meta_cubit.dart' as metaCubit;
import 'package:haji_market/src/feature/home/bloc/meta_state.dart' as metaState;
import 'package:haji_market/src/feature/home/presentation/ui/banner_page.dart';
import 'package:haji_market/src/feature/home/presentation/ui/cats_page.dart';
import 'package:haji_market/src/feature/home/presentation/ui/popular_cats_page.dart';
import 'package:haji_market/src/feature/home/presentation/ui/popular_shops_page.dart';
import 'package:haji_market/src/feature/home/presentation/widgets/product_mb_interesting_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../product/cubit/product_cubit.dart' as productCubit;
import '../../../product/cubit/product_state.dart' as productState;
import '../../../drawer/bloc/sub_cats_cubit.dart' as subCatCubit;
import '../../../product/presentation/widgets/product_ad_card.dart';
import '../../bloc/cats_cubit.dart' as catCubit;
import '../../bloc/popular_shops_cubit.dart' as popShopsCubit;
import '../../bloc/popular_shops_state.dart' as popShopsState;

@RoutePage()
class HomePage extends StatefulWidget {
  final void Function()? drawerCallback;
  final GlobalKey<ScaffoldState>? globalKey;
  const HomePage({
    this.globalKey,
    this.drawerCallback,
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RefreshController refreshController = RefreshController();

  List<String> metas = [
    'Пользовательское соглашение',
    'Оферта для продавцов',
    'Политика конфиденциальности',
    'Типовой договор купли-продажи',
    'Типовой договор на оказание рекламных услуг'
  ];

  List<String> metasBody = [];

  List<String> metasUrlLinks = [];

  @override
  void initState() {
    if (BlocProvider.of<bannerCubit.BannersCubit>(context).state
        is! bannerState.LoadedState) {
      BlocProvider.of<bannerCubit.BannersCubit>(context).banners();
    }

    // if (BlocProvider.of<productAdCubit.ProductAdCubit>(context).state
    //     is! productAdState.LoadedState) {
    BlocProvider.of<productAdCubit.ProductAdCubit>(context).adProducts(null);
    // }

    // if (BlocProvider.of<subCatCubit.SubCatsCubit>(context).state
    //     is! subCatState.LoadedState) {
    BlocProvider.of<subCatCubit.SubCatsCubit>(context)
        .subCats(0, isAddAllProducts: false);
    //}

    if (BlocProvider.of<popShopsCubit.PopularShopsCubit>(context).state
        is! popShopsState.LoadedState) {
      BlocProvider.of<popShopsCubit.PopularShopsCubit>(context).popShops();
    }

    if (BlocProvider.of<partnerCubit.PartnerCubit>(context).state
        is! partnerState.LoadedState) {
      BlocProvider.of<partnerCubit.PartnerCubit>(context).partners();
    }

    if (BlocProvider.of<metaCubit.MetaCubit>(context).state
        is! metaState.LoadedState) {
      BlocProvider.of<metaCubit.MetaCubit>(context).partners();
    }

    if (BlocProvider.of<productCubit.ProductCubit>(context).state
        is! productState.LoadedState) {
      BlocProvider.of<productCubit.ProductCubit>(context).products();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const DrawerHome(),
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   // onPressed: widget.drawerCallback,
        //   onPressed: () {
        //     widget.globalKey!.currentState!.openDrawer();
        //   },
        //   icon: SvgPicture.asset('assets/icons/menu.svg'),
        //   color: AppColors.kPrimaryColor,
        // ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 22.0),
              child: GestureDetector(
                  onTap: () {
                    context.router.push(const SearchProductRoute());
                  },
                  child: SvgPicture.asset('assets/icons/search.svg')))
        ],
        titleSpacing: 16,
        title: const Text(
          'LUNA market',
          style: AppTextStyles.appBarTextStylea,
        ),
      ),
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: () {
          Future.wait([
            BlocProvider.of<productCubit.ProductCubit>(context).products(),
            BlocProvider.of<partnerCubit.PartnerCubit>(context).partners(),
            BlocProvider.of<popShopsCubit.PopularShopsCubit>(context)
                .popShops(),
            BlocProvider.of<catCubit.CatsCubit>(context).cats(),
            BlocProvider.of<bannerCubit.BannersCubit>(context).banners(),
          ]);
          refreshController.refreshCompleted();
        },
        child: ListView(
          cacheExtent: 5000,
          shrinkWrap: true,
          children: [
            const BannerPage(),
            const SizedBox(
              height: 16,
            ),
            const CatsPage(),
            const SizedBox(
              height: 16,
            ),
            const PopularCatsHomepage(),
            const SizedBox(
              height: 16,
            ),
            const PopularShopsPage(),
            const SizedBox(
              height: 16,
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Вы недавно смотрели',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocConsumer<productCubit.ProductCubit,
                            productState.ProductState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is productState.ErrorState) {
                            return Center(
                              child: Text(
                                state.message,
                                style: const TextStyle(
                                    fontSize: 20.0, color: Colors.grey),
                              ),
                            );
                          }
                          if (state is productState.LoadingState) {
                            return const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.indigoAccent));
                          }

                          if (state is productState.LoadedState) {
                            return SizedBox(
                                height: 286,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.productModel.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () => context.router.push(
                                          DetailCardProductRoute(
                                              product:
                                                  state.productModel[index])),
                                      child: ProductMbInterestingCard(
                                        product: state.productModel[index],
                                      ),
                                    );
                                  },
                                ));
                          } else {
                            return const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.indigoAccent));
                          }
                        }),
                    // SingleChildScrollView(
                    //     scrollDirection: Axis.horizontal,
                    //     child: Row(children: const <Widget>[
                    //       BannerWatcehRecently(),
                    //       BannerWatcehRecently(),
                    //       BannerWatcehRecently(),
                    //       BannerWatcehRecently(),
                    //     ])),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Вас могут заинтересовать',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocConsumer<productAdCubit.ProductAdCubit,
                            productAdState.ProductAdState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is productAdState.ErrorState) {
                            return Center(
                              child: Text(
                                state.message,
                                style: const TextStyle(
                                    fontSize: 20.0, color: Colors.grey),
                              ),
                            );
                          }
                          if (state is productAdState.LoadingState) {
                            return const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.indigoAccent));
                          }
                          if (state is productAdState.NoDataState) {
                            return const SizedBox(
                              height: 20,
                              width: 20,
                            );
                          }
                          if (state is productAdState.LoadedState) {
                            return SizedBox(
                                // width: 400,
                                height: state.productModel.length >= 2
                                    ? MediaQuery.of(context).size.height * 0.64
                                    : MediaQuery.of(context).size.height * 0.32,
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio:
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.0009,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 0),
                                  itemCount: state.productModel.length >= 8
                                      ? 8
                                      : state.productModel.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return GestureDetector(
                                      onTap: () => context.router
                                          .push(DetailCardProductRoute(
                                        product: state.productModel[index],
                                      )),
                                      child: ProductAdCard(
                                        product: state.productModel[index],
                                      ),
                                    );
                                  },
                                ));
                          } else {
                            return const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.indigoAccent));
                          }
                        }),
                    // SingleChildScrollView(
                    //     scrollDirection: Axis.horizontal,
                    //     child: Column(children: [
                    //       Row(
                    //         children: const [
                    //           BannerWatcehRecently(),
                    //           BannerWatcehRecently(),
                    //         ],
                    //       ),
                    //       Row(
                    //         children: const [
                    //           BannerWatcehRecently(),
                    //           BannerWatcehRecently(),
                    //         ],
                    //       )
                    //     ])),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
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

                return Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Партнерам',
                          style: TextStyle(
                              color: AppColors.kGray900,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // const Text(
                        //   'Кабинет продавца',
                        //   style: AppTextStyles.kcolorPartnerTextStyle,
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    //  print(state.partner[index].url.toString());
                                    Get.to(() => MetasPage(
                                          title: metas[index],
                                          body: metasBody[index],
                                        ));
                                  },
                                  child: SizedBox(
                                    height: 24,
                                    child: Text(
                                      metas[index],
                                      style:
                                          AppTextStyles.kcolorPartnerTextStyle,
                                    ),
                                  ),
                                );
                              }),
                        ),

                        // const SizedBox(
                        //   height: 12,
                        // ),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) =>
                        //               const UserAgreementPage()),
                        //     );
                        //   },
                        //   child: const Text(
                        //     'Пользовательское соглашение',
                        //     style: AppTextStyles.kcolorPartnerTextStyle,
                        //   ),
                        // ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Shimmer(
                  duration: const Duration(seconds: 3), //Default value
                  interval: const Duration(
                      microseconds: 1), //Default value: Duration(seconds: 0)
                  color: Colors.white, //Default value
                  colorOpacity: 0, //Default value
                  enabled: true, //Default value
                  direction: const ShimmerDirection.fromLTRB(), //Default Value
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.withOpacity(0.6),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      child: SizedBox(
                        height: 90,
                        width: 90,
                      ),
                    ),
                  ),
                );
              }
            }),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
