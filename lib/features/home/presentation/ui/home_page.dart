import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/drawer/presentation/ui/catalog_page.dart';
import 'package:haji_market/features/home/data/bloc/banners_cubit.dart';
import 'package:haji_market/features/home/data/bloc/banners_state.dart';
import 'package:haji_market/features/home/presentation/widgets/banner_watceh_recently_widget.dart';
import 'package:haji_market/features/home/presentation/widgets/bonus_page.dart';
import 'package:haji_market/features/home/presentation/widgets/gridLayout_popular.dart';
import 'package:haji_market/features/home/presentation/widgets/gridLayout_popular_shop.dart';
import 'package:haji_market/features/home/presentation/widgets/gridlayout_categor.dart';
import 'package:haji_market/features/home/presentation/widgets/stocks_page.dart';
import 'package:haji_market/features/home/presentation/widgets/user_agreement_page.dart';

import '../../../drawer/presentation/widgets/under_catalog_page.dart';
import '../../data/bloc/cats_cubit.dart' as catCubit;
import '../../data/bloc/cats_state.dart' as catState;
import '../../data/bloc/popular_shops_cubit.dart' as popShopsCubit;
import '../../data/bloc/popular_shops_state.dart' as popShopsState;

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
  List images = [
    'assets/images/reclama.png',
    'assets/images/reclama.png',
    'assets/images/reclama.png'
  ];

  final List<Map> myProducts =
  List.generate(6, (index) => {"id": index, "name": "Product "}).toList();

  late List<GridLayoutCategory> options = [
    GridLayoutCategory(
      title: 'Скидки',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StocksPage()),
        );
      },
      icon: 'assets/icons/cat2.svg',
    ),
    GridLayoutCategory(
      title: 'Cмартфоны',
      icon: 'assets/icons/cat1.svg',
    ),
    GridLayoutCategory(
      title: 'Аптека',
      icon: 'assets/icons/cat2.svg',
    ),
    GridLayoutCategory(
      title: 'Скидки',
      icon: 'assets/icons/cat4.svg',
    ),
    GridLayoutCategory(
      title: 'Игрушки',
      icon: 'assets/icons/cat3.svg',
    ),
    GridLayoutCategory(
      title: 'Cмартфоны',
      icon: 'assets/icons/cat1.svg',
      // ontap1: () {},
    ),
  ];



  @override
  void initState() {
    BlocProvider.of<BannersCubit>(context).banners();
    BlocProvider.of<catCubit.CatsCubit>(context).cats();
    BlocProvider.of<popShopsCubit.PopularShopsCubit>(context).popShops();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const DrawerHome(),
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          // onPressed: widget.drawerCallback,
          onPressed: () {
            widget.globalKey!.currentState!.openDrawer();
          },
          icon: const Icon(Icons.menu),
          color: AppColors.kPrimaryColor,
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 22.0),
              child: SvgPicture.asset('assets/icons/search.svg'))
        ],
        title: Transform(
          transform: Matrix4.translationValues(-50, 0, 0),
          child:
          Container(
            padding: const EdgeInsets.only(left: 40) ,
           child: const Text(
              'Luna market',
              style: AppTextStyles.appBarTextStylea,
            ),
          )
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
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: const <Widget>[
                        BannerWatcehRecently(),
                        BannerWatcehRecently(),
                        BannerWatcehRecently(),
                        BannerWatcehRecently(),
                      ])),
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
                    height: 9,
                  ),

                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(children: [
                        Row(
                          children:const [
                            BannerWatcehRecently(),
                            BannerWatcehRecently(),
                            BannerWatcehRecently(),
                            BannerWatcehRecently(),
                          ],
                        ),
                        Row(
                          children: const[
                            BannerWatcehRecently(),
                            BannerWatcehRecently(),
                            BannerWatcehRecently(),
                            BannerWatcehRecently(),
                          ],
                        )

                      ])),
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
                    height: 20,
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
                child: CircularProgressIndicator(color: Colors.indigoAccent)
            );
          }

          if (state is catState.LoadedState) {
            return  Container(
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
                        itemCount: state.cats.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UnderCatalogPage(cats:state.cats[index])),
                              );
                            },
                            child: GridOptionsPopular(
                              layout:   GridLayoutPopular(
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
                          MaterialPageRoute(builder: (context) => CatalogPage()),
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



              Container(
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
                    GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 2 / 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 16),
                        itemCount: state.cats.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return GridOptionsCategory(
                            layout:   GridLayoutCategory(
                              title: state.cats[index].name,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => StocksPage()),
                                );
                              },
                              icon: state.cats[index].icon.toString(),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            );

          }else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent)
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
    return   BlocConsumer<catCubit.CatsCubit, catState.CatsState>(
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
                child: CircularProgressIndicator(color: Colors.indigoAccent)
            );
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
                      height: 248,
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.9,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 10),
                          itemCount: state.cats.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return GridOptionsCategory(
                              layout:   GridLayoutCategory(
                                title: state.cats[index].name,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UnderCatalogPage(cats: state.cats[index])),
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
          }else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent)
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
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<BannersCubit, BannersState>(
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
                child: CircularProgressIndicator(color: Colors.indigoAccent)
            );
          }

          if (state is LoadedState) {
          //  return Container(
          //    height: 100,
          // width: 100,
          // child: Row(children:  <Widget>[
          return Container(
            color: Colors.white,
            height: 162,
            child: ListView.builder(
                itemCount: state.banners.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return BannerImage(
                    title: state.banners[index].title.toString() ,
                    bonus: state.banners[index].bonus as int ,
                    date: state.banners[index].date.toString(),
                    image: state.banners[index].path.toString(),

                  );
                }
              //)
              // ])
            ),
          );


      }else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent)
          );
          }
    });

  }
}

class BannerImage extends StatelessWidget {
  final String title;
  final int bonus;
  final String date;
  final String image;
  const BannerImage({
    Key? key,required this.title , required this.bonus, required this.date, required this.image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BonusPage(name: title, bonus: bonus, date: date, image: image)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 8, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 100,
                  width: 170,
                  decoration: BoxDecoration(
                      image:  DecorationImage(
                        image: NetworkImage("http://80.87.202.73:8001/storage/${image}"),
                        fit: BoxFit.cover,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 40 , left: 13),
                  child:   Text(
                    title,
                    style: AppTextStyles.bannerTextStyle,
                  ),
                ),
                Container(
                  width: 46,
                  height: 22,
                  decoration: BoxDecoration(
                      color:Colors.black,
                    borderRadius: BorderRadius.circular(6),
                      ),
                  margin: const EdgeInsets.only(top: 12 , left: 12),
                  alignment: Alignment.center,
                  child: Text(
                   "${bonus.toString()}% Б" ,
                    style: AppTextStyles.bannerTextStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              date,
              style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color:  Colors.black,
                  )
            ),
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
   return   BlocConsumer<popShopsCubit.PopularShopsCubit, popShopsState.PopularShopsState>(
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
                child: CircularProgressIndicator(color: Colors.indigoAccent)
            );
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
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Stack(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 115,
                                    decoration: BoxDecoration(
                                        borderRadius:  BorderRadius.circular(8),
                                        image:  DecorationImage(
                                          image: NetworkImage("http://80.87.202.73:8001/storage/${state.popularShops[index].image!}"),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  if(state.popularShops[index].credit == true)
                                    Container(
                                      width: 46,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(31,196,207,1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      margin: const EdgeInsets.only(top: 8 , left: 4),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "0·0·12" ,
                                        style: AppTextStyles.bannerTextStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),

                                  Container(
                                    width: 46,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      color:Colors.black,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    margin: const EdgeInsets.only(top: 34 , left: 4),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${state.popularShops[index].bonus.toString()}% Б" ,
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
                              Text(state.popularShops[index].name!, style: AppTextStyles.categoryTextStyle),
                              // Flexible(
                              //     child:

                            ],
                          );;

                          //   GridOptionsPopularShop(
                          //   layout: optionsPopularshop[index],
                          // );
                        }),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
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
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ),
            );
          }else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.indigoAccent)
            );
          }
        });
    ;
  }
}
