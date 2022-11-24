import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/drawer/presentation/ui/catalog_page.dart';
import 'package:haji_market/features/drawer/presentation/widgets/products_card_widget.dart';
import 'package:haji_market/features/home/data/bloc/banners_cubit.dart';
import 'package:haji_market/features/home/data/bloc/banners_state.dart';
import 'package:haji_market/features/home/data/model/Cats.dart';
import 'package:haji_market/features/home/presentation/widgets/banner_watceh_recently_widget.dart';
import 'package:haji_market/features/home/presentation/widgets/bonus_page.dart';
import 'package:haji_market/features/home/presentation/widgets/gridLayout_popular.dart';
import 'package:haji_market/features/home/presentation/widgets/gridLayout_popular_shop.dart';
import 'package:haji_market/features/home/presentation/widgets/gridlayout_categor.dart';
import 'package:haji_market/features/home/presentation/widgets/product_mb_interesting_card.dart';
import 'package:haji_market/features/home/presentation/widgets/stocks_page.dart';
import 'package:haji_market/features/home/presentation/widgets/user_agreement_page.dart';

import '../../../drawer/data/bloc/product_cubit.dart' as productCubit;
import '../../../drawer/data/bloc/product_state.dart' as productState;
import '../../../drawer/presentation/ui/products_page.dart';
import '../../../drawer/presentation/ui/shops_page.dart';
import '../../../drawer/presentation/widgets/detail_card_product_page.dart';
import '../../../drawer/presentation/widgets/under_catalog_page.dart';
import '../../data/bloc/cats_cubit.dart' as catCubit;
import '../../data/bloc/cats_state.dart' as catState;
import '../../data/bloc/popular_shops_cubit.dart' as popShopsCubit;
import '../../data/bloc/popular_shops_state.dart' as popShopsState;
import '../widgets/product_watching_card.dart';
import '../widgets/search_product_page.dart';

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
  @override
  void initState() {
    BlocProvider.of<BannersCubit>(context).banners();
    BlocProvider.of<catCubit.CatsCubit>(context).cats();
    BlocProvider.of<popShopsCubit.PopularShopsCubit>(context).popShops();
    BlocProvider.of<productCubit.ProductCubit>(context).products();

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
        leading: IconButton(
          // onPressed: widget.drawerCallback,
          onPressed: () {
            widget.globalKey!.currentState!.openDrawer();
          },
          icon: SvgPicture.asset('assets/icons/menu.svg'),
          color: AppColors.kPrimaryColor,
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 22.0),
              child: GestureDetector(
                  onTap: () {
                    Get.to(SearchProductPage());
                  },
                  child: SvgPicture.asset('assets/icons/search.svg')))
        ],
        titleSpacing: 0,
        title: const Text(
          'Luna market',
          style: AppTextStyles.appBarTextStylea,
        ),
      ),
      body: ListView(
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
                              style:
                                  TextStyle(fontSize: 20.0, color: Colors.grey),
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
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailCardProductPage(
                                                  product: state
                                                      .productModel[index])),
                                    ),
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
                  BlocConsumer<productCubit.ProductCubit,
                          productState.ProductState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is productState.ErrorState) {
                          return Center(
                            child: Text(
                              state.message,
                              style:
                                  TextStyle(fontSize: 20.0, color: Colors.grey),
                            ),
                          );
                        }
                        if (state is productState.LoadingState) {
                          return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.indigoAccent));
                        }

                        if (state is productState.LoadedState) {
                          return Container(
                              height: 608,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.6,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 2),
                                itemCount: 4,
                                itemBuilder: (BuildContext ctx, index) {
                                  return GestureDetector(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailCardProductPage(
                                                  product: state
                                                      .productModel[index])),
                                    ),
                                    child: ProductWatchingCard(
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
          Container(
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Кабинет продавца',
                    style: AppTextStyles.kcolorPartnerTextStyle,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Начать продавать с «»',
                    style: AppTextStyles.kcolorPartnerTextStyle,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Договор присоединения',
                    style: AppTextStyles.kcolorPartnerTextStyle,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Договор по оказанию услуги доставки',
                    style: AppTextStyles.kcolorPartnerTextStyle,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserAgreementPage()),
                      );
                    },
                    child: const Text(
                      'Пользовательское соглашение',
                      style: AppTextStyles.kcolorPartnerTextStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
        ],
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
    return BlocConsumer<catCubit.CatsCubit, catState.CatsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is catState.ErrorState) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(fontSize: 20.0, color: Colors.grey),
              ),
            );
          }
          if (state is catState.LoadingState) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent));
          }

          if (state is catState.LoadedState) {
            return Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Популярное',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2 / 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemCount:
                            state.cats.length >= 6 ? 6 : state.cats.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UnderCatalogPage(
                                        cats: state.cats[index])),
                              );
                            },
                            child: GridOptionsPopular(
                              layout: GridLayoutPopular(
                                title: state.cats[index].name,
                                image: state.cats[index].image,
                                bonus: state.cats[index].bonus,
                                credit: state.cats[index].credit,
                              ),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 24,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CatalogPage()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
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
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent));
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
                style: TextStyle(fontSize: 20.0, color: Colors.grey),
              ),
            );
          }
          if (state is catState.LoadingState) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent));
          }

          if (state is catState.LoadedState) {
            return Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, top: 16, bottom: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Категории',
                        style: TextStyle(
                            color: AppColors.kGray900,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 192,
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.8,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8),
                          itemCount: state.cats.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return GridOptionsCategory(
                              layout: GridLayoutCategory(
                                title: state.cats[index].name,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UnderCatalogPage(
                                            cats: state.cats[index])),
                                  );
                                },
                                icon: state.cats[index].icon.toString(),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent));
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
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BannersCubit, BannersState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ErrorState) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(fontSize: 20.0, color: Colors.grey),
              ),
            );
          }
          if (state is LoadingState) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent));
          }

          if (state is LoadedState) {
            //  return Container(
            //    height: 100,
            // width: 100,
            // child: Row(children:  <Widget>[
            return Container(
              color: Colors.white,
              height: 155,
              child: ListView.builder(
                  itemCount: state.banners.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return BannerImage(
                      index: index,
                      title: state.banners[index].title.toString(),
                      bonus: state.banners[index].bonus as int,
                      date: state.banners[index].date.toString(),
                      image: state.banners[index].path.toString(),
                    );
                  }
                  //)
                  // ])
                  ),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent));
          }
        });
  }
}

class BannerImage extends StatelessWidget {
  final String title;
  final int index;
  final int bonus;
  final String date;
  final String image;
  const BannerImage(
      {Key? key,
      required this.index,
      required this.title,
      required this.bonus,
      required this.date,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BonusPage(
                  name: title, bonus: bonus, date: date, image: image)),
        );
      },
      child: Padding(
        padding:
            EdgeInsets.only(top: 16.0, left: index == 0 ? 16 : 8, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 100,
                  width: 158,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "http://80.87.202.73:8001/storage/${image}"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 40, left: 12),
                  child: Text(
                    title,
                    style: AppTextStyles.bannerTextStyle,
                  ),
                ),
                Container(
                  width: 46,
                  height: 22,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  margin: const EdgeInsets.only(top: 12, left: 12),
                  alignment: Alignment.center,
                  child: Text(
                    "${bonus.toString()}% Б",
                    style: AppTextStyles.bannerTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(date,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(173, 176, 181, 1),
                )),
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
    return BlocConsumer<popShopsCubit.PopularShopsCubit,
            popShopsState.PopularShopsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is popShopsState.ErrorState) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(fontSize: 20.0, color: Colors.grey),
              ),
            );
          }
          if (state is popShopsState.LoadingState) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent));
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
                      'Популярные магазины',
                      style: TextStyle(
                          color: AppColors.kGray900,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2 / 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        itemCount: state.popularShops.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Get.to(ProductsPage(
                                  cats: Cats(id: 0, name: ''),
                                ));

                                GetStorage().write('shopFilter',
                                    state.popularShops[index].name!);
                                GetStorage().write('shopFilterId',
                                    state.popularShops[index].id);
                                GetStorage()
                                    .write('shopSelectedIndexSort', index);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 115,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "http://80.87.202.73:8001/storage/${state.popularShops[index].image!}"),
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      if (state.popularShops[index].credit ==
                                          true)
                                        Container(
                                          width: 46,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                31, 196, 207, 1),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          margin: const EdgeInsets.only(
                                              top: 8, left: 4),
                                          alignment: Alignment.center,
                                          child: const Text(
                                            "0·0·12",
                                            style:
                                                AppTextStyles.bannerTextStyle,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      Container(
                                        width: 46,
                                        height: 22,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        margin: const EdgeInsets.only(
                                            top: 34, left: 4),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${state.popularShops[index].bonus.toString()}% Б",
                                          style: AppTextStyles.bannerTextStyle,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Center(
                                  //   child: Image.asset(
                                  //
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(state.popularShops[index].name!,
                                      style: AppTextStyles.categoryTextStyle),
                                  // Flexible(
                                  //     child:
                                ],
                              )); // );
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Все предложения',
                          style: AppTextStyles.kcolorPrimaryTextStyle,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(ShopsPage());
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.kPrimaryColor,
                            size: 16,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent));
          }
        });
    ;
  }
}
