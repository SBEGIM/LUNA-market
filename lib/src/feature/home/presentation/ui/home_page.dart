import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/core/presentation/widgets/shimmer/shimmer_box.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/product/cubit/product_ad_cubit.dart'
    as productAdCubit;
import 'package:haji_market/src/feature/product/cubit/product_ad_state.dart'
    as productAdState;
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
import 'package:haji_market/src/feature/home/presentation/widgets/product_mb_interesting_card.dart';
import 'package:haji_market/src/feature/seller/main/cubit/stories_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/main/cubit/stories_seller_state.dart';
import 'package:haji_market/src/feature/seller/main/presentation/widget/stories_card_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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

    if (BlocProvider.of<StoriesSellerCubit>(context).state is! LoadedState) {
      BlocProvider.of<StoriesSellerCubit>(context).news();
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
      backgroundColor: AppColors.kGray1,
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
            BlocProvider.of<StoriesSellerCubit>(context).news(),
          ]);
          refreshController.refreshCompleted();
        },
        child: ListView(
          cacheExtent: 5000,
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    Assets.icons.location.path,
                    height: 23,
                    width: 22,
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  Text(
                    'Алматы',
                    style: AppTextStyles.titleTextStyle.copyWith(
                        color: AppColors.mainPurpleColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  Image.asset(
                    Assets.icons.defaultNotificationIcon.path,
                    height: 22,
                    width: 22,
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            BlocBuilder<StoriesSellerCubit, StoriesSellerState>(
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
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    height: 90,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.storiesSeelerModel.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => Get.to(StoryScreen(
                                stories:
                                    state.storiesSeelerModel[index].stories)),
                            child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              padding: const EdgeInsets.all(2),
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: index == 0
                                      ? AppColors.mainPurpleColor
                                      : AppColors.kGray200,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    12), // 14 - (4 padding + 2 border) = 8, but 10 looks better
                                child: Image.network(
                                  "https://lunamarket.ru/storage/${state.storiesSeelerModel[index].image}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    height: 80,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(left: 5),
                            padding: const EdgeInsets.all(1),
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: index == 0
                                    ? AppColors.mainPurpleColor
                                    : Colors.white,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    10), // 14 - (4 padding + 2 border) = 8, but 10 looks better
                                child: ShimmerBox()),
                          );
                        }),
                  ),
                );
              }
            }),
            SizedBox(
              height: 16,
            ),
            const BannerPage(),
            // const SizedBox(
            //   height: 16,
            // ),
            Container(
              height: 74,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                    color: AppColors.kGray2,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    InkWell(
                      onTap: () {
                        context.router.push(const SearchProductRoute());
                      },
                      child: Image.asset(
                        Assets.icons.defaultSearchIcon.path,
                        height: 20,
                        width: 20,
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Искать',
                      style: AppTextStyles.titleTextStyle
                          .copyWith(color: AppColors.kGray300),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const CatsPage(),

            // const PopularCatsHomepage(),
            // const SizedBox(
            //   height: 16,
            // ),
            // const PopularShopsPage(),
            // const SizedBox(
            //   height: 16,
            // ),
            SizedBox(
              // color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Недавно смотрели',
                          style: TextStyle(
                              color: AppColors.kGray900,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        const Text(
                          'Показать все',
                          style: TextStyle(
                              color: AppColors.mainPurpleColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
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
                                height: 315,
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
                  ],
                ),
              ),
            ),

            Container(
              // color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Недавно смотрели',
                          style: TextStyle(
                              color: AppColors.kGray900,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        const Text(
                          'Показать все',
                          style: TextStyle(
                              color: AppColors.mainPurpleColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
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
                                    ? MediaQuery.of(context).size.height * 0.72
                                    : MediaQuery.of(context).size.height * 0.32,
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 1.70,
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
              height: 100,
            ),
            // BlocBuilder<metaCubit.MetaCubit, metaState.MetaState>(
            //     builder: (context, state) {
            //   if (state is metaState.LoadedState) {
            //     metasBody.addAll([
            //       state.metas.terms_of_use!,
            //       state.metas.privacy_policy!,
            //       state.metas.contract_offer!,
            //       state.metas.shipping_payment!,
            //       state.metas.TTN!,
            //     ]);

            //     return Container(
            //       color: Colors.white,
            //       child: Padding(
            //         padding: const EdgeInsets.all(16.0),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             const Text(
            //               'Партнерам',
            //               style: TextStyle(
            //                   color: AppColors.kGray900,
            //                   fontSize: 16,
            //                   fontWeight: FontWeight.w700),
            //             ),
            //             // const SizedBox(
            //             //   height: 20,
            //             // ),
            //             // const Text(
            //             //   'Кабинет продавца',
            //             //   style: AppTextStyles.kcolorPartnerTextStyle,
            //             // ),
            //             const SizedBox(
            //               height: 20,
            //             ),
            //             SizedBox(
            //               height: 150,
            //               child: ListView.builder(
            //                   itemCount: 5,
            //                   itemBuilder: (context, index) {
            //                     return GestureDetector(
            //                       onTap: () {
            //                         //  print(state.partner[index].url.toString());
            //                         Get.to(() => MetasPage(
            //                               title: metas[index],
            //                               body: metasBody[index],
            //                             ));
            //                       },
            //                       child: SizedBox(
            //                         height: 24,
            //                         child: Text(
            //                           metas[index],
            //                           style:
            //                               AppTextStyles.kcolorPartnerTextStyle,
            //                         ),
            //                       ),
            //                     );
            //                   }),
            //             ),

            //             // const SizedBox(
            //             //   height: 12,
            //             // ),
            //             // InkWell(
            //             //   onTap: () {
            //             //     Navigator.push(
            //             //       context,
            //             //       MaterialPageRoute(
            //             //           builder: (context) =>
            //             //               const UserAgreementPage()),
            //             //     );
            //             //   },
            //             //   child: const Text(
            //             //     'Пользовательское соглашение',
            //             //     style: AppTextStyles.kcolorPartnerTextStyle,
            //             //   ),
            //             // ),
            //             const SizedBox(
            //               height: 8,
            //             ),
            //           ],
            //         ),
            //       ),
            //     );
            //   } else {
            //     return Shimmer(
            //       duration: const Duration(seconds: 3), //Default value
            //       interval: const Duration(
            //           microseconds: 1), //Default value: Duration(seconds: 0)
            //       color: Colors.white, //Default value
            //       colorOpacity: 0, //Default value
            //       enabled: true, //Default value
            //       direction: const ShimmerDirection.fromLTRB(), //Default Value
            //       child: Container(
            //         margin: const EdgeInsets.all(16),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(12),
            //           color: Colors.grey.withOpacity(0.6),
            //         ),
            //         child: const Padding(
            //           padding: EdgeInsets.symmetric(
            //             vertical: 16,
            //           ),
            //           child: SizedBox(
            //             height: 90,
            //             width: 90,
            //           ),
            //         ),
            //       ),
            //     );
            //   }
            // }),
            // const SizedBox(
            //   height: 60,
            // ),
          ],
        ),
      ),
    );
  }
}
