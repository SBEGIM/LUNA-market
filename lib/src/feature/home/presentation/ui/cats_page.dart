import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/shimmer_box.dart';
import 'package:haji_market/src/feature/home/bloc/cats_cubit.dart';
import 'package:haji_market/src/feature/home/bloc/cats_state.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:haji_market/src/feature/home/presentation/widgets/gridlayout_categor.dart';

class CatsPage extends StatefulWidget {
  const CatsPage({Key? key}) : super(key: key);

  @override
  _CatsPageState createState() => _CatsPageState();
}

class _CatsPageState extends State<CatsPage> {
  final CatsModel allCat = CatsModel(
      id: 0,
      name: 'Все категории',
      image: 'cat/36/image/8mWKc4Kk0ArxqBPnOCVtqhIqdmJicFzlPkMmLDvD.png');

  @override
  void initState() {
    if (BlocProvider.of<CatsCubit>(context).state is! LoadedState) {
      BlocProvider.of<CatsCubit>(context).cats();
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CatsCubit, CatsState>(
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

          if (state is LoadedState) {
            return Container(
              height: 280,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, top: 16, bottom: 8, right: 16),
                child: SizedBox(
                  height: 240,
                  child: GridView.builder(
                      cacheExtent: 10000,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 120 / 114),
                      itemCount: 6,
                      itemBuilder: (BuildContext ctx, index) {
                        return index != 5
                            ? GridOptionsCategory(
                                layout: GridLayoutCategory(
                                    title: state.cats[index].name,
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //       builder: (context) => UnderCatalogPage(
                                      //           cats: state.cats[index])),
                                      // );

                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) => SubCatalogPage(cats: state.cats[index])),
                                      // );

                                      List<CatsModel> options = [];
                                      if (index == 1) {
                                        options.add(
                                            CatsModel(id: 0, name: 'Женская'));
                                        options.add(
                                            CatsModel(id: 0, name: 'Мужская'));
                                        options.add(
                                            CatsModel(id: 0, name: 'Детская'));
                                      }

                                      context.router.push(SubCatalogRoute(
                                          cats: state.cats[index],
                                          catChapters:
                                              state.cats[index].catSections));
                                    },
                                    icon: state.cats[index].icon.toString(),
                                    image: state.cats[index].image.toString(),
                                    catOptions: []),
                              )
                            : GridOptionsCategory(
                                layout: GridLayoutCategory(
                                  title: allCat.name,
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => UnderCatalogPage(
                                    //           cats: state.cats[index])),
                                    // );
                                    context.router.push(CatalogRoute());
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => SubCatalogPage(cats: state.cats[index])),
                                    // );
                                  },
                                  icon: allCat.icon.toString(),
                                  image: allCat.image.toString(),
                                ),
                              );
                      }),
                ),
              ),
            );
          } else {
            return Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, top: 16, bottom: 8, right: 16),
                child: SizedBox(
                  height: 248,
                  child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.02,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8),
                      itemCount: 6,
                      itemBuilder: (BuildContext ctx, index) {
                        return const ShimmerBox(
                            height: 80, width: 90, radius: 16);
                      }),
                ),
              ),
            );
          }
        });
  }
}
