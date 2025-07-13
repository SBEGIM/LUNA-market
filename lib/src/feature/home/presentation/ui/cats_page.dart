import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/shimmer_box.dart';
import 'package:haji_market/src/feature/home/bloc/cats_cubit.dart';
import 'package:haji_market/src/feature/home/bloc/cats_state.dart';
import 'package:haji_market/src/feature/home/presentation/widgets/gridlayout_categor.dart';

class CatsPage extends StatefulWidget {
  const CatsPage({Key? key}) : super(key: key);

  @override
  _CatsPageState createState() => _CatsPageState();
}

class _CatsPageState extends State<CatsPage> {
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
          // if (state is catState.LoadingState) {
          //   return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
          // }

          if (state is LoadedState) {
            return Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, top: 16, bottom: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Text('Категории',
                    //     style: TextStyle(
                    //         color: AppColors.kGray900,
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w700)),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    SizedBox(
                      height: 280,
                      child: GridView.builder(
                          cacheExtent: 10000,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 60 / 50,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12),
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
                                  context.router.push(
                                      SubCatalogRoute(cats: state.cats[index]));
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
                padding: const EdgeInsets.only(
                    left: 16.0, top: 16, bottom: 16, right: 16),
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
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 90 / 80,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 8),
                          itemCount: 10,
                          itemBuilder: (BuildContext ctx, index) {
                            return const ShimmerBox(
                                height: 80, width: 90, radius: 16);
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
