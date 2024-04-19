import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/core/util/url_util.dart';
import 'package:haji_market/features/app/router/app_router.dart';
import 'package:haji_market/features/app/widgets/shimmer_box.dart';
import 'package:haji_market/features/drawer/data/bloc/product_ad_cubit.dart' as productAdCubit;
import 'package:haji_market/features/drawer/data/bloc/product_ad_state.dart' as productAdState;
import 'package:haji_market/features/drawer/presentation/widgets/advert_bottom_sheet.dart';
import 'package:haji_market/features/drawer/presentation/widgets/metas_webview.dart';
import 'package:haji_market/features/home/data/bloc/banners_cubit.dart' as bannerCubit;
import 'package:haji_market/features/home/data/bloc/banners_state.dart' as bannerState;
import 'package:haji_market/features/home/data/bloc/partner_cubit.dart' as partnerCubit;
import 'package:haji_market/features/home/data/bloc/partner_state.dart' as partnerState;
import 'package:haji_market/features/home/data/bloc/meta_cubit.dart' as metaCubit;
import 'package:haji_market/features/home/data/bloc/meta_state.dart' as metaState;
import 'package:haji_market/features/home/data/model/Cats.dart';
import 'package:haji_market/features/home/presentation/widgets/gridLayout_popular.dart';
import 'package:haji_market/features/home/presentation/widgets/gridlayout_categor.dart';
import 'package:haji_market/features/home/presentation/widgets/product_mb_interesting_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../drawer/data/bloc/product_cubit.dart' as productCubit;
import '../../../drawer/data/bloc/product_state.dart' as productState;
import '../../../drawer/data/bloc/sub_cats_cubit.dart' as subCatCubit;
import '../../../drawer/data/bloc/sub_cats_state.dart' as subCatState;
import '../../../drawer/presentation/widgets/credit_webview.dart';
import '../../../drawer/presentation/widgets/product_ad_card.dart';
import '../../data/bloc/cats_cubit.dart' as catCubit;
import '../../data/bloc/cats_state.dart' as catState;
import '../../data/bloc/popular_shops_cubit.dart' as popShopsCubit;
import '../../data/bloc/popular_shops_state.dart' as popShopsState;

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
    if (BlocProvider.of<bannerCubit.BannersCubit>(context).state is! bannerState.LoadedState) {
      BlocProvider.of<bannerCubit.BannersCubit>(context).banners();
    }
    if (BlocProvider.of<catCubit.CatsCubit>(context).state is! catState.LoadedState) {
      BlocProvider.of<catCubit.CatsCubit>(context).cats();
    }
    // if (BlocProvider.of<productAdCubit.ProductAdCubit>(context).state
    //     is! productAdState.LoadedState) {
    BlocProvider.of<productAdCubit.ProductAdCubit>(context).adProducts(null);
    // }

    // if (BlocProvider.of<subCatCubit.SubCatsCubit>(context).state
    //     is! subCatState.LoadedState) {
    BlocProvider.of<subCatCubit.SubCatsCubit>(context).subCats(0);
    //}

    if (BlocProvider.of<popShopsCubit.PopularShopsCubit>(context).state is! popShopsState.LoadedState) {
      BlocProvider.of<popShopsCubit.PopularShopsCubit>(context).popShops();
    }

    if (BlocProvider.of<partnerCubit.PartnerCubit>(context).state is! partnerState.LoadedState) {
      BlocProvider.of<partnerCubit.PartnerCubit>(context).partners();
    }

    if (BlocProvider.of<metaCubit.MetaCubit>(context).state is! metaState.LoadedState) {
      BlocProvider.of<metaCubit.MetaCubit>(context).partners();
    }

    if (BlocProvider.of<productCubit.ProductCubit>(context).state is! productState.LoadedState) {
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
            BlocProvider.of<popShopsCubit.PopularShopsCubit>(context).popShops(),
            BlocProvider.of<catCubit.CatsCubit>(context).cats(),
            BlocProvider.of<bannerCubit.BannersCubit>(context).banners(),
          ]);
          refreshController.refreshCompleted();
        },
        child: ListView(
          cacheExtent: 3000,
          shrinkWrap: true,
          children: [
            const Banners(),
            const SizedBox(
              height: 16,
            ),
            const CatsHomePage(),
            const SizedBox(
              height: 16,
            ),
            const PopularCatsHompage(),
            const SizedBox(
              height: 16,
            ),
            const PopularShops(),
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
                      style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocConsumer<productCubit.ProductCubit, productState.ProductState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is productState.ErrorState) {
                            return Center(
                              child: Text(
                                state.message,
                                style: const TextStyle(fontSize: 20.0, color: Colors.grey),
                              ),
                            );
                          }
                          if (state is productState.LoadingState) {
                            return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
                          }

                          if (state is productState.LoadedState) {
                            return SizedBox(
                                height: 286,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.productModel.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () => context.router
                                          .push(DetailCardProductRoute(product: state.productModel[index])),
                                      child: ProductMbInterestingCard(
                                        product: state.productModel[index],
                                      ),
                                    );
                                  },
                                ));
                          } else {
                            return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
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
                      style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 16,
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
                          if (state is productAdState.NoDataState) {
                            return const SizedBox(
                              height: 20,
                              width: 20,
                            );
                          }
                          if (state is productAdState.LoadedState) {
                            return SizedBox(
                                // width: 400,
                                height:
                                    state.productModel.length >= 2 ? MediaQuery.of(context).size.height * 0.64 : 304,
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.55,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 0),
                                  itemCount: state.productModel.length >= 8 ? 8 : state.productModel.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return GestureDetector(
                                      onTap: () => context.router.push(DetailCardProductRoute(
                                        product: state.productModel[index],
                                      )),
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
            BlocBuilder<metaCubit.MetaCubit, metaState.MetaState>(builder: (context, state) {
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
                          style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w700),
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
                                      '${metas[index]}',
                                      style: AppTextStyles.kcolorPartnerTextStyle,
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
                  interval: const Duration(microseconds: 1), //Default value: Duration(seconds: 0)
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
                ;
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

class PopularCatsHompage extends StatefulWidget {
  const PopularCatsHompage({Key? key}) : super(key: key);

  @override
  _PopularCatsHompageState createState() => _PopularCatsHompageState();
}

class _PopularCatsHompageState extends State<PopularCatsHompage> {
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
          // if (state is subCatState.LoadingState) {
          //   return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
          // }

          if (state is subCatState.LoadedState) {
            return Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Популярное',
                      style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 0.64, crossAxisSpacing: 10, mainAxisSpacing: 10),
                        itemCount: state.cats.length >= 6 ? 6 : state.cats.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => UnderCatalogPage(
                              //           cats: state.cats[index])),
                              // );
                              GetStorage().remove('CatId');
                              GetStorage().remove('subCatFilterId');
                              GetStorage().remove('shopFilterId');
                              GetStorage().remove('search');
                              GetStorage().write('CatId', state.cats[index].id);

                              context.router.push(ProductsRoute(
                                cats: state.cats[index],
                              ));
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => ProductsPage(cats: state.cats[index])),
                              // );
                            },
                            child: GridOptionsPopular(
                              layout: GridLayoutPopular(
                                title: state.cats[index].name,
                                image: state.cats[index].image,
                                icon: state.cats[index].icon,
                                bonus: state.cats[index].bonus ?? 0,
                                credit: state.cats[index].credit ?? 0,
                              ),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 24,
                    ),
                    InkWell(
                      onTap: () {
                        context.router.push(SubCatalogRoute());
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const CatalogPage()),
                        // );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Все предложения',
                            style: AppTextStyles.kcolorPrimaryTextStyle,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.kPrimaryColor,
                            size: 14,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ShimmerBox(
                      height: 22,
                      radius: 10,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 0.65, crossAxisSpacing: 10, mainAxisSpacing: 10),
                        itemCount: 6,
                        itemBuilder: (BuildContext ctx, index) {
                          return const ShimmerBox(
                            height: 90,
                            width: 90,
                            radius: 12,
                          );
                        }),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}

class CatsHomePage extends StatefulWidget {
  const CatsHomePage({Key? key}) : super(key: key);

  @override
  _CatsHomePageState createState() => _CatsHomePageState();
}

class _CatsHomePageState extends State<CatsHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<catCubit.CatsCubit, catState.CatsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is catState.ErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(fontSize: 20.0, color: Colors.grey),
              ),
            );
          }
          // if (state is catState.LoadingState) {
          //   return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
          // }

          if (state is catState.LoadedState) {
            return Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16, bottom: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Категории',
                        style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 266,
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 60 / 50, crossAxisSpacing: 12, mainAxisSpacing: 12),
                          itemCount: state.cats.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return GridOptionsCategory(
                              layout: GridLayoutCategory(
                                title: state.cats[index].name,
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => UnderCatalogPage(
                                  //           cats: state.cats[index])),
                                  // );
                                  context.router.push(SubCatalogRoute(cats: state.cats[index]));
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => SubCatalogPage(cats: state.cats[index])),
                                  // );
                                },
                                icon: state.cats[index].icon.toString(),
                                image: state.cats[index].image.toString(),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16, bottom: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ShimmerBox(
                      height: 22,
                      radius: 10,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 196,
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 90 / 80, crossAxisSpacing: 10, mainAxisSpacing: 8),
                          itemCount: 10,
                          itemBuilder: (BuildContext ctx, index) {
                            return const ShimmerBox(height: 80, width: 90, radius: 16);
                          }),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}

class Banners extends StatefulWidget {
  const Banners({Key? key}) : super(key: key);

  @override
  _BannersState createState() => _BannersState();
}

class _BannersState extends State<Banners> {
  final CarouselController carouselController = CarouselController();
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<bannerCubit.BannersCubit, bannerState.BannersState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is bannerState.ErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(fontSize: 20.0, color: Colors.grey),
              ),
            );
          }
          if (state is bannerState.LoadedState) {
            //  return Container(
            //    height: 100,
            // width: 100,
            // child: Row(children:  <Widget>[
            return Container(
              color: Colors.white,
              height: 273,
              child: CarouselSlider.builder(
                carouselController: carouselController,
                options: CarouselOptions(
                  autoPlay: true,
                  height: 273, // (context.screenSize.width - 32) * 9 / 16,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                itemCount: state.banners.length,
                itemBuilder: (context, index, realIndex) => Builder(
                  builder: (BuildContext context) {
                    return BannerImage(
                      index: index,
                      title: state.banners[index].title.toString(),
                      bonus: state.banners[index].bonus as int,
                      date: state.banners[index].date.toString(),
                      image: state.banners[index].path.toString(),
                      url: state.banners[index].url.toString(),
                      description: state.banners[index].description.toString(),
                    );
                  },
                ),
              ),
            );
          } else {
            return Container(
              color: Colors.white,
              height: 273,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ShimmerBox(
                  height: 218,
                  width: MediaQuery.of(context).size.width - 32,
                  radius: 8,
                ),
              ),
            );

            // Shimmer(
            //   duration: const Duration(seconds: 3), //Default value
            //   interval: const Duration(microseconds: 1), //Default Рекvalue: Duration(seconds: 0)
            //   color: Colors.white, //Default value
            //   colorOpacity: 0, //Default value
            //   enabled: true, //Default value
            //   direction: const ShimmerDirection.fromLTRB(), //Default Value
            //   child: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(12),
            //       color: Colors.grey.withOpacity(0.6),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(
            //         vertical: 16,
            //       ),
            //       child: SizedBox(
            //         height: 273,
            //         width: MediaQuery.of(context).size.width - 32,
            //       ),
            //     ),
            //   ),
            // );
          }
        });
  }
}

class BannerImage extends StatelessWidget {
  final int index;
  final String title;
  final int bonus;
  final String date;
  final String image;
  final String url;
  final String description;
  const BannerImage({
    Key? key,
    required this.index,
    required this.title,
    required this.bonus,
    required this.date,
    required this.image,
    required this.url,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        UrlUtil.launch(context, url: url);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => BonusPage(
        //             name: title,
        //             bonus: bonus,
        //             date: date,
        //             image: image,
        //             url: url,
        //             description: description,
        //           )),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 218,
                  width: MediaQuery.of(context).size.width - 32,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("http://185.116.193.73/storage/$image"),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                // Container(
                //   padding: const EdgeInsets.only(top: 40, left: 12),
                //   child: Text(
                //     title,
                //     style: AppTextStyles.bannerTextStyle,
                //   ),
                // ),
                // Container(
                //   width: 46,
                //   height: 22,
                //   decoration: BoxDecoration(
                //     color: Colors.black,
                //     borderRadius: BorderRadius.circular(6),
                //   ),
                //   margin: const EdgeInsets.only(top: 12, left: 12),
                //   alignment: Alignment.center,
                //   child: Text(
                //     "${bonus.toString()}% Б",
                //     style: AppTextStyles.bannerTextStyle,
                //     textAlign: TextAlign.center,
                //   ),
                // ),

                Positioned(
                  right: 20,
                  bottom: 20,
                  child: GestureDetector(
                    onTap: () async {
                      await showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        isDismissible: true,
                        builder: (context) {
                          return AdvertBottomSheet(url: url, description: description);
                        },
                      );
                    },
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(6)),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 4.0, right: 4, top: 4, bottom: 4),
                        child: Text(
                          'РЕКЛАМА',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                )
                //   Positioned(
                //     right: 20,
                //     bottom: 20,
                //     child: GestureDetector(
                //       onTap: () async {
                //         await showModalBottomSheet(
                //           context: context,
                //           backgroundColor: Colors.transparent,
                //           isScrollControlled: true,
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(10.0),
                //           ),
                //           // isDismissible: true,
                //           builder: (context) {
                //             return DraggableScrollableSheet(
                //               initialChildSize: 0.30, //set this as you want
                //               maxChildSize: 0.30, //set this as you want
                //               minChildSize: 0.30, //set this as you want
                //               builder: (context, scrollController) {
                //                 return Container(
                //                   padding: const EdgeInsets.all(16),
                //                   color: Colors.white,
                //                   child: ListView(
                //                     controller: scrollController,
                //                     children: [
                //                       const SizedBox(height: 16),
                //                       const Text(
                //                         'Рекламный баннер',
                //                         style: TextStyle(
                //                             fontSize: 16,
                //                             fontWeight: FontWeight.w500),
                //                         textAlign: TextAlign.center,
                //                       ),
                //                       const SizedBox(height: 16),
                //                       // GestureDetector(
                //                       //   onTap: () {
                //                       //     // Get.to(const ContractOfSale());
                //                       //   },
                //                       //   child: Container(
                //                       //     padding: const EdgeInsets.only(
                //                       //         top: 8, left: 16),
                //                       //     alignment: Alignment.centerLeft,
                //                       //     child: Text(
                //                       //       '${widget.description}',
                //                       //       style: const TextStyle(
                //                       //           fontSize: 14,
                //                       //           color:
                //                       //               AppColors.kPrimaryColor),
                //                       //     ),
                //                       //   ),
                //                       // ),
                //                       // const Text(
                //                       //   'Мы помогаем нашим продавцам рассказать об их товарах на LUNA market.Для этого у нас есть разные способы продвижения. Узнать больше о рекламе на LUNA market',
                //                       //   style: TextStyle(
                //                       //       fontSize: 12,
                //                       //       fontWeight: FontWeight.w400),
                //                       //   textAlign: TextAlign.center,
                //                       // ),
                //                       // const SizedBox(height: 16),

                //                       Container(
                //                         alignment: Alignment.bottomLeft,
                //                         child: Row(
                //                           children: [
                //                             const Text(
                //                               'Описание:',
                //                               style: TextStyle(
                //                                 fontSize: 14,
                //                               ),
                //                             ),
                //                             const SizedBox(width: 4),
                //                             Text(
                //                               description,
                //                               style: const TextStyle(
                //                                   fontSize: 14,
                //                                   color: AppColors.kPrimaryColor),
                //                             ),
                //                           ],
                //                         ),
                //                       ),

                //                       const SizedBox(height: 50),

                //                       Container(
                //                         alignment: Alignment.bottomLeft,
                //                         child: Row(
                //                           children: [
                //                             const Icon(Icons.link),
                //                             const SizedBox(width: 10),
                //                             const Text(
                //                               'Ссылка:',
                //                               style: TextStyle(
                //                                 fontSize: 14,
                //                               ),
                //                             ),
                //                             const SizedBox(width: 4),
                //                             InkWell(
                //                               onTap: () {
                //                                 UrlUtil.launch(context, url: url);
                //                               },
                //                               child: Text(
                //                                 url,
                //                                 style: const TextStyle(
                //                                     fontSize: 14,
                //                                     color:
                //                                         AppColors.kPrimaryColor),
                //                               ),
                //                             ),
                //                           ],
                //                         ),
                //                       )
                //                     ],
                //                   ),
                //                 );
                //               },
                //             );
                //           },
                //         );
                //       },
                //       child: Container(
                //         decoration: BoxDecoration(
                //             color: Colors.grey.withOpacity(0.2),
                //             borderRadius: BorderRadius.circular(6)),
                //         child: const Padding(
                //           padding: EdgeInsets.only(
                //               left: 4.0, right: 4, top: 4, bottom: 4),
                //           child: Text(
                //             'РЕКЛАМА',
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //                 color: Colors.grey,
                //                 fontSize: 12,
                //                 fontWeight: FontWeight.w400),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
              ],
            ),
            // const SizedBox(
            //   height: 7,
            // ),
            // //8
            // Text(date,
            //     style: const TextStyle(
            //       fontSize: 12,
            //       fontWeight: FontWeight.w400,
            //       color: Color.fromRGBO(173, 176, 181, 1),
            //     )),
          ],
        ),
      ),
    );
  }
}

class PopularShops extends StatefulWidget {
  const PopularShops({Key? key}) : super(key: key);

  @override
  _PopularShopsState createState() => _PopularShopsState();
}

class _PopularShopsState extends State<PopularShops> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<popShopsCubit.PopularShopsCubit, popShopsState.PopularShopsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is popShopsState.ErrorState) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(fontSize: 20.0, color: Colors.grey),
              ),
            );
          }
          if (state is popShopsState.LoadingState) {
            return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
          }

          if (state is popShopsState.LoadedState) {
            return Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Бренды и Магазины',
                      style: TextStyle(color: AppColors.kGray900, fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 0.65, crossAxisSpacing: 10, mainAxisSpacing: 10),
                        itemCount: state.popularShops.length >= 6 ? 6 : state.popularShops.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                GetStorage().remove('CatId');
                                GetStorage().remove('subCatFilterId');
                                GetStorage().remove('shopFilterId');
                                GetStorage().remove('search');
                                GetStorage().write('shopFilter', state.popularShops[index].name ?? '');
                                // GetStorage().write('shopFilterId', state.popularShops[index].id);

                                List<int> _selectedListSort = [];

                                _selectedListSort.add(state.popularShops[index].id as int);

                                GetStorage().write('shopFilterId', _selectedListSort.toString());

                                // GetStorage().write('shopSelectedIndexSort', index);
                                context.router.push(ProductsRoute(
                                  cats: Cats(id: 0, name: ''),
                                  shopId: state.popularShops[index].id.toString(),
                                ));
                                // Get.to(ProductsPage(
                                //   cats: Cats(id: 0, name: ''),
                                // ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color.fromARGB(15, 227, 9, 9),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 0, left: 12, right: 12),
                                          alignment: Alignment.center,
                                          height: MediaQuery.of(context).size.height * 0.10,
                                          width: MediaQuery.of(context).size.height * 0.10,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              image: DecorationImage(
                                                  image: state.popularShops[index].image != null
                                                      ? NetworkImage(
                                                          "http://185.116.193.73/storage/${state.popularShops[index].image!}",
                                                        )
                                                      : const AssetImage('assets/icons/shops&brands.png')
                                                          as ImageProvider,
                                                  fit: BoxFit.fitWidth),
                                              color: const Color(0xFFF0F5F5)),
                                          // child: Image.network(
                                          //   "http://80.87.202.73:8001/storage/${state.popularShops[index].image!}",
                                          //   width: 70,
                                          // ),
                                        ),
                                        // Container(
                                        //   height: 90,
                                        //   width: 90,
                                        //   decoration: BoxDecoration(
                                        //       borderRadius:
                                        //           BorderRadius.circular(8),
                                        //       image: DecorationImage(
                                        //         image: NetworkImage(
                                        //             "http://80.87.202.73:8001/storage/${state.popularShops[index].image!}"),
                                        //         fit: BoxFit.cover,
                                        //       )),
                                        // ),
                                        if (state.popularShops[index].credit == true)
                                          Container(
                                            width: 46,
                                            height: 22,
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(31, 196, 207, 1),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            margin: const EdgeInsets.only(bottom: 140, left: 0, right: 75),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              "0·0·12",
                                              style: AppTextStyles.bannerTextStyle,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        Container(
                                          width: 46,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          margin: const EdgeInsets.only(bottom: 90, left: 0, right: 75),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${state.popularShops[index].bonus.toString()}% Б",
                                            style: AppTextStyles.bannerTextStyle,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.17, left: 4),
                                          alignment: Alignment.center,
                                          child: Text(state.popularShops[index].name ?? '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles.categoryTextStyle),
                                        ),
                                      ],
                                    ),

                                    // Center(
                                    //   child: Image.asset(
                                    //
                                    //   ),
                                    // ),
                                    // const SizedBox(
                                    //   height: 8,
                                    // ),
                                    // Text(state.popularShops[index].name!,
                                    //     style: AppTextStyles.categoryTextStyle),
                                    // Flexible(
                                    //     child:
                                  ],
                                ),
                              )); // );
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        context.router.push(const ShopsRoute());
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Все предложения',
                            style: AppTextStyles.kcolorPrimaryTextStyle,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.kPrimaryColor,
                            size: 16,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Shimmer(
              duration: const Duration(seconds: 3), //Default value
              interval: const Duration(microseconds: 1), //Default value: Duration(seconds: 0)
              color: Colors.white, //Default value
              colorOpacity: 0, //Default value
              enabled: true, //Default value
              direction: const ShimmerDirection.fromLTRB(), //Default Value
              child: Container(
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
        });
  }
}
