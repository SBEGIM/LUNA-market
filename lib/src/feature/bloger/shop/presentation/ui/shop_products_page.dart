import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:haji_market/src/feature/bloger/shop/bloc/blogger_shop_products_state.dart';
import 'package:haji_market/src/feature/bloger/shop/presentation/ui/upload_product_video.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../../core/common/constants.dart';
import '../../bloc/blogger_shop_products_cubit.dart';
import 'blogger_products_card_widget.dart';

class ShopProductsBloggerPage extends StatefulWidget {
  String title;
  int id;
  ShopProductsBloggerPage({required this.title, required this.id, Key? key})
      : super(key: key);

  @override
  State<ShopProductsBloggerPage> createState() =>
      _ShopProductsBloggerPageState();
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
      await BlocProvider.of<BloggerShopProductsCubit>(context)
          .productsPagination(searchController.text, widget.id);
      await Future.delayed(const Duration(milliseconds: 2000));
      refreshController.loadComplete();
    }

    final TextEditingController nameController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        actions: [
          // AnimSearchBar(
          //   helpText: 'Поиск..',
          //   onChanged: (String? value) {
          //     BlocProvider.of<BloggerShopProductsCubit>(context)
          //         .products(searchController.text, widget.id);
          //   },
          //   style: const TextStyle(
          //       fontSize: 14,
          //       fontWeight: FontWeight.w400,
          //       color: Color.fromRGBO(153, 162, 173, 1)),
          //   textController: searchController,
          //   onSuffixTap: () {
          //     searchController.clear();
          //   },
          //   onArrowTap: () {
          //     visible = !visible;
          //     // print(visible.toString());
          //     setState(() {
          //       visible;
          //     });
          //     searchController.clear();
          //   },
          //   width: MediaQuery.of(context).size.width,
          // ),
          // const SizedBox(
          //   width: 10,
          // ),
          // GestureDetector(
          //     onTap: () async {
          //       await Share.share('$kDeepLinkUrl/?blogger/shop_${widget.id}');
          //     },
          //     child: SvgPicture.asset(
          //       'assets/icons/share.svg',
          //       height: 28,
          //       width: 28,
          //     )),
          // const SizedBox(
          //   width: 10,
          // ),
        ],
        backgroundColor: AppColors.kWhite,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        // titleSpacing: 16,
        // automaticallyImplyLeading: false,
        title: Text(
          widget.title,
          style: AppTextStyles.defaultAppBarTextStyle,
        ),
      ),
      body: Column(
        // shrinkWrap: true,
        children: [
          Container(
            height: 44,
            alignment: Alignment.center,
            margin:
                const EdgeInsets.only(top: 10, bottom: 12, left: 12, right: 12),
            decoration: BoxDecoration(
              color: AppColors.kGray1,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: AppColors.kGray200,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      // print(value);
                      BlocProvider.of<BloggerShopProductsCubit>(context)
                          .products(searchController.text, widget.id);
                    },
                    keyboardType: TextInputType.text,
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Поиск товаров',
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isCollapsed: true, // Убирает внутренние отступы
                    ),
                    style:
                        TextStyle(height: 1.2), // Центрирует текст по вертикали
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
                      ? SvgPicture.asset(
                          'assets/icons/delete_circle.svg',
                        )
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
                      style:
                          const TextStyle(fontSize: 20.0, color: Colors.grey),
                    ),
                  );
                }
                if (state is LoadingState) {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: Colors.indigoAccent));
                }
                if (state is NoDataState) {
                  return Expanded(
                    // width: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 220),
                            child: Image.asset('assets/icons/no_data.png')),
                        const Text(
                          'Нет данных',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        const Text(
                          'У этого магазина отсуствует товары',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff717171)),
                          textAlign: TextAlign.center,
                        )
                      ],
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
                      BlocProvider.of<BloggerShopProductsCubit>(context)
                          .products(searchController.text, widget.id);
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
                              print('set ${setIndex}');
                              setState(() {
                                isSelected = selected;
                                selectedIndex = setIndex;
                              });
                            },
                          );
                          //  product: state.productModel[index]);
                        }),
                  ));
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
                  return const Center(
                      child: CircularProgressIndicator(
                          color: Colors.indigoAccent));
                }
              })
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () async {
            if (selectedIndex != 0) {
              Get.to(() => UploadProductVideoPage(id: selectedIndex));
            } else {
              Get.snackbar('Ошибка', 'Сначала выберите товар для обзора',
                  backgroundColor: AppColors.kBlueColor);
            }
          },
          child: Container(
            // width: 99,
            height: 52,
            decoration: BoxDecoration(
              color: selectedIndex != 0
                  ? AppColors.mainPurpleColor
                  : AppColors.mainPurpleColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              'Сделать обзор',
              // textAlign: TextAlign.center,
              style: AppTextStyles.defaultButtonTextStyle
                  .copyWith(color: AppColors.kWhite),
            ),
          ),
        ),
      ),
    );
  }
}
