import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
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
  TextEditingController nameController = TextEditingController();

  Future<void> onLoading() async {
    await BlocProvider.of<ProductSellerCubit>(context).productsPaginate('');
    await Future.delayed(const Duration(milliseconds: 2000));
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        title: Text(
          'Мои товары',
          style: AppTextStyles.defaultAppBarTextStyle,
        ),
        // bottom: PopupMenuButton(
        //   onSelected: (value) {
        //     if (value == 0) {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => const CategorySellerPage()),
        //       );
        //     }
        //   },
        //   shape: const RoundedRectangleBorder(
        //       borderRadius: BorderRadius.all(Radius.circular(15.0))),
        //   icon: SvgPicture.asset('assets/icons/plus.svg'),
        //   itemBuilder: (BuildContext bc) {
        //     return [
        //       PopupMenuItem(
        //           value: 0,
        //           child: Column(
        //             children: [

        //             ],
        //           )),
        //     ];
        //   },
        // ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16), // отступы
        child: Material(
          borderRadius: BorderRadius.circular(12),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
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
                borderRadius: BorderRadius.circular(12),
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
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),

      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     const Text(
      //       "Добавить товар",
      //       style: TextStyle(color: Colors.black),
      //     ),
      //     SvgPicture.asset('assets/icons/lenta1.svg'),
      //   ],
      // ),
      body: // Выполняем загрузку продуктов только при открытии страницы
          Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: AppColors.kGray2,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const Padding(
                //   padding: EdgeInsets.only(left: 16.0),
                //   child: Text(
                //     'LUNA market',
                //     style: TextStyle(
                //         fontSize: 20,
                //         fontWeight: FontWeight.w700,
                //         color: AppColors.kGray900),
                //   ),
                // ),
                const SizedBox(
                  width: 18,
                ),
                Image.asset(
                  Assets.icons.defaultSearchIcon.path,
                  scale: 1.9,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: nameController,
                    onChanged: (value) {
                      BlocProvider.of<ProductSellerCubit>(context)
                          .products(nameController.text);
                    },
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Поиск',
                      hintStyle: TextStyle(
                          color: AppColors.kGray300,
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
          const SizedBox(
            height: 12,
          ),
          BlocConsumer<ProductSellerCubit, ProductAdminState>(
              listener: (context, state) {
            if (state is ChangeState) {
              BlocProvider.of<ProductSellerCubit>(context).products('');
            }
            if (state is LoadedState) {
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
