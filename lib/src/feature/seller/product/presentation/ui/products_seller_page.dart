import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/seller/product/data/repository/product_seller_repository.dart';
import 'package:haji_market/src/feature/seller/product/presentation/widgets/category_seller_page.dart';
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
    return BlocProvider<ProductSellerCubit>(
      create: (context) =>
          ProductSellerCubit(productAdminRepository: ProductSellerRepository())
            ..products(''),
      child: this,
    );
  }
}

class _MyProductsAdminPageState extends State<MyProductsAdminPage> {
  @override
  RefreshController refreshController = RefreshController();

  Future<void> onLoading() async {
    await BlocProvider.of<ProductSellerCubit>(context).productsPaginate('');
    await Future.delayed(const Duration(milliseconds: 2000));
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: // Выполняем загрузку продуктов только при открытии страницы
          Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.white,
            height: 50,
          ),
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    'LUNA market',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.kGray900),
                  ),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    if (value == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CategorySellerPage()),
                      );
                    }
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  icon: SvgPicture.asset('assets/icons/plus.svg'),
                  itemBuilder: (BuildContext bc) {
                    return [
                      PopupMenuItem(
                          value: 0,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Добавить товар",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SvgPicture.asset('assets/icons/lenta1.svg'),
                                ],
                              ),
                            ],
                          )),
                    ];
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: nameController,
                    onChanged: (value) {
                      BlocProvider.of<ProductSellerCubit>(context)
                          .products(value);
                    },
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Поиск продуктов',
                      hintStyle: TextStyle(
                          color: Color.fromRGBO(194, 197, 200, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10)
              ],
            ),
          ),
          BlocConsumer<ProductSellerCubit, ProductAdminState>(
              listener: (context, state) {
            if (state is ChangeState) {
              log('ChangeState123');
              BlocProvider.of<ProductSellerCubit>(context).products('');
            }
            if (state is LoadedState) {
              log('setSatetUpdate');
              setState(() {});
              refreshController.refreshCompleted();
            }
          }, builder: (context, state) {
            if (state is ErrorState) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(fontSize: 20.0, color: Colors.grey),
                ),
              );
            }
            if (state is LoadedState) {
              return Expanded(
                child: SmartRefresher(
                    controller: refreshController,
                    enablePullUp: true,
                    onLoading: onLoading,
                    onRefresh: () {
                      BlocProvider.of<ProductSellerCubit>(context).products('');
                      refreshController.refreshCompleted();
                    },
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: state.productModel.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductCardSellerPage(
                            context: context,
                            product: state.productModel[index],
                            cubit: ProductSellerCubit(
                                productAdminRepository:
                                    ProductSellerRepository()),
                          );
                        })),
              );
            } else {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.indigoAccent));
            }
          })
        ],
      ),
    );
  }
}
