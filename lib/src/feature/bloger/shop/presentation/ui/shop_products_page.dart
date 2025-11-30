import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/app_snack_bar.dart';
import 'package:haji_market/src/feature/bloger/shop/bloc/blogger_shop_products_state.dart';
import 'package:haji_market/src/feature/bloger/shop/presentation/ui/upload_product_video.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../../core/common/constants.dart';
import '../../bloc/blogger_shop_products_cubit.dart';
import 'blogger_products_card_widget.dart';

@RoutePage()
class ShopProductsBloggerPage extends StatefulWidget {
  String title;
  int id;
  ShopProductsBloggerPage({required this.title, required this.id, Key? key}) : super(key: key);

  @override
  State<ShopProductsBloggerPage> createState() => _ShopProductsBloggerPageState();
}

class _ShopProductsBloggerPageState extends State<ShopProductsBloggerPage> {
  bool _visibleIconClear = false;
  bool isSelected = false;
  int selectedIndex = 0;

  @override
  void initState() {
    BlocProvider.of<BloggerShopProductsCubit>(context).products('', widget.id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? title;
    final TextEditingController searchController = TextEditingController();
    bool visible = true;

    RefreshController refreshController = RefreshController();

    Future<void> onLoading() async {
      await BlocProvider.of<BloggerShopProductsCubit>(
        context,
      ).productsPagination(searchController.text, widget.id);
      await Future.delayed(const Duration(milliseconds: 2000));
      refreshController.loadComplete();
    }

    final TextEditingController nameController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(Assets.icons.defaultBackIcon.path, scale: 1.9),
        ),
        title: Text(widget.title, style: AppTextStyles.defaultAppBarTextStyle),
      ),
      body: Column(
        children: [
          Container(
            height: 44,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 10, bottom: 12, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Color(0xFFEAECED),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Image.asset(Assets.icons.defaultSearchIcon.path, height: 19, width: 19),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      // print(value);
                      BlocProvider.of<BloggerShopProductsCubit>(
                        context,
                      ).products(searchController.text, widget.id);
                    },
                    keyboardType: TextInputType.text,
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Поиск товаров',
                      hintStyle: AppTextStyles.size16Weight400.copyWith(color: AppColors.kGray300),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isCollapsed: true, // Убирает внутренние отступы
                    ),
                    style: TextStyle(height: 1.2), // Центрирует текст по вертикали
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _visibleIconClear = false;
                    searchController.clear();
                    setState(() {
                      _visibleIconClear;
                    });
                  },
                  child: _visibleIconClear == true
                      ? SvgPicture.asset('assets/icons/delete_circle.svg')
                      : const SizedBox(width: 5),
                ),
              ],
            ),
          ),
          BlocConsumer<BloggerShopProductsCubit, BloggerShopProductsState>(
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

              if (state is NoDataState) {
                return Expanded(
                  child: SmartRefresher(
                    controller: refreshController,
                    enablePullUp: true,
                    onLoading: () {
                      onLoading();
                    },
                    onRefresh: () {
                      BlocProvider.of<BloggerShopProductsCubit>(
                        context,
                      ).products(searchController.text, widget.id);
                      refreshController.refreshCompleted();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 220),
                          height: 72,
                          width: 72,
                          child: Image.asset(Assets.icons.defaultNoDataIcon.path),
                        ),
                        SizedBox(height: 12),
                        const Text(
                          'Нет товаров',
                          style: AppTextStyles.size16Weight500,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (state is LoadedState) {
                return Expanded(
                  child: SmartRefresher(
                    controller: refreshController,
                    enablePullUp: true,
                    onLoading: () {
                      onLoading();
                    },
                    onRefresh: () {
                      BlocProvider.of<BloggerShopProductsCubit>(
                        context,
                      ).products(searchController.text, widget.id);
                      refreshController.refreshCompleted();
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      // physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.productModel.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BloggerProductCardWidget(
                          product: state.productModel[index],
                          isSelected: isSelected,
                          index: selectedIndex,
                          onSelectionChanged: (selected, setIndex) {
                            if (selectedIndex == setIndex) {
                              isSelected = false;
                              selectedIndex = -1;
                              setState(() {});
                              return;
                            }

                            setState(() {
                              isSelected = selected;
                              selectedIndex = setIndex;
                            });
                          },
                        );
                        //  product: state.productModel[index]);
                      },
                    ),
                  ),
                );
                //   Expanded(
                //     child: Container(
                //       color: Colors.white,
                //       padding: const EdgeInsets.only(
                //         left: 16,
                //         right: 16,
                //       ),
                //       child: GridView.builder(
                //           padding: const EdgeInsets.only(
                //               top: 16, left: 0, right: 0, bottom: 0),
                //           gridDelegate:
                //               const SliverGridDelegateWithMaxCrossAxisExtent(
                //                   maxCrossAxisExtent: 190,
                //                   childAspectRatio: 2 / 3.2,
                //                   crossAxisSpacing: 8,
                //                   mainAxisSpacing: 16),
                //           itemCount: state.productModel.length,
                //           itemBuilder: (BuildContext ctx, index) {
                //             return Stack(
                //               children: [
                //                 GestureDetector(
                //                   onTap: (() => Get.to(() =>
                //                       UploadProductVideoPage(
                //                           id: state.productModel[index].id ??
                //                               0))),
                //                   child: title == 'Мои видео обзоры'
                //                       ? ProductDetail(
                //                           product: state.productModel[index])
                //                       : ProductVideo(
                //                           product: state.productModel[index],
                //                         ),
                //                 ),
                //                 // Container(
                //                 //   decoration: BoxDecoration(
                //                 //       borderRadius: BorderRadius.circular(10)),
                //                 // ),
                //                 // InkWell(
                //                 //   onTap: () {
                //                 //     showAlertStaticticsWidget(
                //                 //         context, state.productModel[index]);
                //                 //   },
                //                 //   child: Container(
                //                 //     height: 28,
                //                 //     width: 28,
                //                 //     margin: const EdgeInsets.only(
                //                 //         top: 8.0, right: 8.0, left: 135),
                //                 //     alignment: Alignment.center,
                //                 //     decoration: BoxDecoration(
                //                 //         color: Colors.white,
                //                 //         borderRadius: BorderRadius.circular(8)),
                //                 //     child: const Icon(
                //                 //       Icons.more_vert_rounded,
                //                 //       color: AppColors.kPrimaryColor,
                //                 //     ),
                //                 //   ),
                //                 // ),
                //               ],
                //             );
                //           }),
                //     ),
                //   );
              } else {
                return Expanded(
                  child: SmartRefresher(
                    controller: refreshController,
                    enablePullUp: true,
                    onLoading: () {
                      onLoading();
                    },
                    onRefresh: () {
                      BlocProvider.of<BloggerShopProductsCubit>(
                        context,
                      ).products(searchController.text, widget.id);
                      refreshController.refreshCompleted();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 220),
                          child: CircularProgressIndicator(color: AppColors.mainPurpleColor),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
          SizedBox(height: 120),
        ],
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(bottom: 42, left: 16, right: 16),
        color: AppColors.kWhite,
        child: InkWell(
          onTap: () async {
            if (selectedIndex != 0) {
              context.pushRoute(UploadProductVideoRoute(id: selectedIndex));
              // Get.to(() => UploadProductVideoPage(id: selectedIndex));

              print('select id $selectedIndex');
              // selectedIndex = 0;
              setState(() {});
            } else {
              AppSnackBar.show(
                context,
                'Сначала выберите товар для обзора',
                type: AppSnackType.error,
              );
            }
          },
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: selectedIndex != 0
                  ? AppColors.mainPurpleColor
                  : AppColors.mainPurpleColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Text(
              'Сделать обзор',
              // textAlign: TextAlign.center,
              style: AppTextStyles.defaultButtonTextStyle.copyWith(color: AppColors.kWhite),
            ),
          ),
        ),
      ),
    );
  }
}
