import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/favorite/bloc/favorite_cubit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../bloc/favorite_state.dart';
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
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        elevation: 0,
        surfaceTintColor: AppColors.kWhite,
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
        title: const Text('Избранное', style: AppTextStyles.size22Weight600),
      ),
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
            return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
          }
          if (state is NoDataState) {
            return Expanded(
              child: SmartRefresher(
                controller: refreshController,
                enablePullDown: true,
                enablePullUp: false, // при пустых данных тянуть вверх обычно не надо
                onRefresh: () {
                  onRefresh();
                }, // onLoading можно убрать для пустого состояния
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(), // тянется даже без контента
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: true, // позволяет занять весь экран и центрировать
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(Assets.icons.defaultNoDataIcon.path, height: 72, width: 72),
                            const SizedBox(height: 12),
                            const Text(
                              'Нет товаров',
                              style: AppTextStyles.size16Weight500,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Здесь появятся товары, которые вы добавили \nв избранное',
                              style: AppTextStyles.size14Weight400.copyWith(
                                color: AppColors.kGray300,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
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
                padding: EdgeInsets.only(bottom: 100),
                itemCount: state.productModel.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => context.router.push(
                      DetailCardProductRoute(product: state.productModel[index]),
                    ),
                    child: FavoriteProductsCardWidget(product: state.productModel[index]),
                  );
                },
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
          }
        },
      ),
    );
  }
}
