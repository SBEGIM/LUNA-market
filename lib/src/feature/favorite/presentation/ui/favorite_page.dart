import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/drawer/data/bloc/favorite_cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../drawer/data/bloc/favorite_state.dart';
import 'favorite_products.dart';

@RoutePage()
class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  RefreshController refreshController = RefreshController();

  Future<void> onLoading() async {
    await BlocProvider.of<FavoriteCubit>(context).myFavoritesPagination();
    await Future.delayed(const Duration(milliseconds: 2000));
    refreshController.loadComplete();
  }

  Future<void> onRefresh() async {
    await BlocProvider.of<FavoriteCubit>(context).myFavorites();
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {});
    }
    refreshController.refreshCompleted();
  }

  @override
  void initState() {
    BlocProvider.of<FavoriteCubit>(context).myFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        appBar: AppBar(
            iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
            backgroundColor: Colors.white,
            elevation: 0,
            // leading: IconButton(
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            //   icon: const Icon(
            //     Icons.arrow_back_ios,
            //     color: AppColors.kPrimaryColor,
            //   ),
            // ),
            centerTitle: true,
            title: const Text(
              'Избранное',
              style: TextStyle(color: Colors.black, fontSize: 16),
            )),
        body: BlocConsumer<FavoriteCubit, FavoriteState>(
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
              if (state is LoadingState) {
                return const Center(
                    child:
                        CircularProgressIndicator(color: Colors.indigoAccent));
              }
              if (state is NoDataState) {
                return SizedBox(
                  width: MediaQuery.of(context).size.height,
                  child: SmartRefresher(
                    controller: refreshController,
                    onLoading: () {
                      BlocProvider.of<FavoriteCubit>(context)
                          .myFavoritesPagination();
                      refreshController.refreshCompleted();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 146),
                            child: Image.asset('assets/icons/no_data.png')),
                        const Text(
                          'В избранном нет товаров',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        const Text(
                          'Для выбора вещей перейдите в маркет',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff717171)),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                );
              }

              if (state is LoadedState) {
                return SmartRefresher(
                  controller: refreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  onLoading: () {
                    onLoading();
                  },
                  onRefresh: () {
                    onRefresh();
                  },
                  child: ListView.builder(
                      shrinkWrap: false,
                      itemCount: state.productModel.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => context.router.push(
                              DetailCardProductRoute(
                                  product: state.productModel[index])),
                          child: FavoriteProductsCardWidget(
                              product: state.productModel[index]),
                        );
                      }),
                );
              } else {
                return const Center(
                    child:
                        CircularProgressIndicator(color: Colors.indigoAccent));
              }
            }));
  }
}
