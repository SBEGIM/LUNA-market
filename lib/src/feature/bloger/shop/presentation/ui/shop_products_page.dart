import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/feature/bloger/shop/bloc/blogger_shop_products_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../core/common/constants.dart';
import '../../../../tape/presentation/widgets/anim_search_widget.dart';
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
      appBar: AppBar(
        actions: [
          AnimSearchBar(
            helpText: 'Поиск..',
            onChanged: (String? value) {
              BlocProvider.of<BloggerShopProductsCubit>(context)
                  .products(searchController.text, widget.id);
            },
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(153, 162, 173, 1)),
            textController: searchController,
            onSuffixTap: () {
              searchController.clear();
            },
            onArrowTap: () {
              visible = !visible;
              // print(visible.toString());
              setState(() {
                visible;
              });
              searchController.clear();
            },
            width: MediaQuery.of(context).size.width,
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
              onTap: () async {
                await Share.share('$kDeepLinkUrl/?blogger/shop_${widget.id}');
              },
              child: SvgPicture.asset(
                'assets/icons/share.svg',
                height: 28,
                width: 28,
              )),
          const SizedBox(
            width: 10,
          ),
        ],
        iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        // titleSpacing: 16,
        // automaticallyImplyLeading: false,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        // shrinkWrap: true,
        children: [
          Container(
            height: 30,
            margin: const EdgeInsets.only(left: 16, bottom: 12),
            alignment: Alignment.bottomLeft,
            color: AppColors.kBackgroundColor,
            child: const Text('Выберите товар',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
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
    );
  }
}
