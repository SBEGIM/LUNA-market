import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:haji_market/src/feature/seller/product/data/repository/product_seller_repository.dart';
import 'package:haji_market/src/core/common/constants.dart';
import '../../bloc/product_seller_cubit.dart';
import '../../bloc/product_seller_state.dart';
import 'products_card_seller_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

@RoutePage()
class MyProductsAdminPage extends StatefulWidget implements AutoRouteWrapper {
  const MyProductsAdminPage({super.key});

  @override
  State<MyProductsAdminPage> createState() => _MyProductsAdminPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProductSellerCubit(productAdminRepository: ProductSellerRepository()),
      child: this,
    );
  }
}

class _MyProductsAdminPageState extends State<MyProductsAdminPage> {
  @override
  RefreshController refreshController = RefreshController();
  TextEditingController nameController = TextEditingController();

  Future<void> onLoading() async {
    await BlocProvider.of<ProductSellerCubit>(context).productsPaginate('');
    await Future.delayed(const Duration(milliseconds: 2000));
    refreshController.loadComplete();
  }

  @override
  void initState() {
    if (BlocProvider.of<ProductSellerCubit>(context).state is! LoadedState) {
      BlocProvider.of<ProductSellerCubit>(context).products('');
    }

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      extendBody: true,
      appBar: AppBar(
        surfaceTintColor: AppColors.kWhite,
        backgroundColor: AppColors.kWhite,
        title: Text('Мои товары', style: AppTextStyles.defaultAppBarTextStyle),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Поиск
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xffEAECED),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 18),
                    Image.asset(Assets.icons.defaultSearchIcon.path, scale: 4),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        onChanged: (value) =>
                            context.read<ProductSellerCubit>().products(value),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Поиск товаров',
                          hintStyle: AppTextStyles.size16Weight400
                              .copyWith(color: Color(0xff8E8E93)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Список
              Expanded(
                child: BlocConsumer<ProductSellerCubit, ProductAdminState>(
                  listener: (context, state) {
                    if (state is ChangeState) {
                      context.read<ProductSellerCubit>().products('');
                    }
                    if (state is LoadedState) {
                      refreshController.refreshCompleted();
                    }
                  },
                  builder: (context, state) {
                    if (state is ErrorState) {
                      return Center(
                        child: Text(state.message,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.grey)),
                      );
                    }
                    if (state is LoadedState) {
                      return SmartRefresher(
                        controller: refreshController,
                        enablePullUp: true,
                        onLoading: onLoading,
                        onRefresh: () {
                          context.read<ProductSellerCubit>().products('');
                          refreshController.refreshCompleted();
                        },
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: state.productModel.length,
                          itemBuilder: (context, index) =>
                              ProductCardSellerPage(
                            context: context,
                            product: state.productModel[index],
                            cubit: context.read<ProductSellerCubit>(),
                          ),
                        ),
                      );
                    }
                    return const Center(
                        child: CircularProgressIndicator(
                            color: Colors.indigoAccent));
                  },
                ),
              ),
            ],
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 94 + 12,
            child: Material(
              borderRadius: BorderRadius.circular(12),
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.pushRoute(CreateProductSellerRoute(
                    cat: CatsModel(id: 0, name: 'Выберите из списка'),
                    subCat: CatsModel(id: 0, name: 'Выберите из списка'),
                  ));
                },
                splashColor: AppColors.mainPurpleColor.withOpacity(0.2),
                highlightColor: AppColors.mainPurpleColor.withOpacity(0.1),
                child: Container(
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.mainPurpleColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Добавить товар',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
