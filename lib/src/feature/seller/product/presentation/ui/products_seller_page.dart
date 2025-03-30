import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/feature/seller/product/presentation/widgets/category_seller_page.dart';
import 'package:haji_market/src/core/common/constants.dart';
import '../../bloc/product_seller_cubit.dart';
import '../../bloc/product_seller_state.dart';
import 'products_card_seller_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

@RoutePage()
class MyProductsAdminPage extends StatefulWidget {
  const MyProductsAdminPage({Key? key}) : super(key: key);

  @override
  State<MyProductsAdminPage> createState() => _MyProductsAdminPageState();
}

class _MyProductsAdminPageState extends State<MyProductsAdminPage> {
  @override
  RefreshController refreshController = RefreshController();
  RefreshController refreshController1 = RefreshController();

  Future<void> onLoading() async {
    await BlocProvider.of<ProductSellerCubit>(context).productsPaginate('');
    await Future.delayed(const Duration(milliseconds: 2000));
    refreshController.loadComplete();
  }

  void initState() {
    BlocProvider.of<ProductSellerCubit>(context).products('');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        // shrinkWrap: true,
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
                              // const SizedBox(height: 4),
                              //  const Divider(),
                            ],
                          )),
                      // PopupMenuItem(
                      //   height: 20,
                      //   value: 1,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       const Text("Добавить видео"),
                      //       SvgPicture.asset('assets/icons/video.svg'),
                      //     ],
                      //   ),
                      // ),
                      // PopupMenuItem(
                      //     height: 5, value: 1, child: Container()),
                    ];
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  // height: 30,
                  // width: 200,
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
                        // borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10)
              ],
            ),
          ),
          BlocConsumer<ProductSellerCubit, ProductAdminState>(
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
                if (state is LoadedState) {
                  return Expanded(
                    child: SmartRefresher(
                        controller: refreshController,
                        enablePullUp: true,
                        onLoading: () {
                          onLoading();
                        },
                        onRefresh: () {
                          BlocProvider.of<ProductSellerCubit>(context)
                              .products('');
                          refreshController.refreshCompleted();
                        },
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            // physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.productModel.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ProductCardSellerWidget(
                                  product: state.productModel[index]);
                            })),
                  );

                  //   AdminProductCardWidget(
                  //    product: state.productModel[index]),
                  //       Expanded(
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
                  //               const SliverGridDelegateWithFixedCrossAxisCount(
                  //                   crossAxisCount: 2,
                  //                   //  maxCrossAxisExtent: 175,
                  //                   childAspectRatio: 2 / 3.2,
                  //                   crossAxisSpacing: 8,
                  //                   mainAxisSpacing: 16),
                  //           itemCount: state.productModel.length,
                  //           itemBuilder: (BuildContext ctx, index) {
                  //             return Stack(
                  //               children: [
                  //                 BannerWatcehRecentlyAdminPage(
                  //                     product: state.productModel[index]),
                  //                 Container(
                  //                   decoration: BoxDecoration(
                  //                       borderRadius: BorderRadius.circular(10)),
                  //                 ),
                  //                 InkWell(
                  //                   onTap: () async {
                  //                     await showAlertStaticticsWidget(
                  //                         context, state.productModel[index]);
                  //                   },
                  //                   child: Container(
                  //                     height: 28,
                  //                     width: 28,
                  //                     margin: const EdgeInsets.only(
                  //                         top: 8.0, right: 8.0, left: 135),
                  //                     alignment: Alignment.center,
                  //                     decoration: BoxDecoration(
                  //                         color: Colors.white,
                  //                         borderRadius: BorderRadius.circular(8)),
                  //                     child: const Icon(
                  //                       Icons.more_vert_rounded,
                  //                       color: AppColors.kPrimaryColor,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             );
                  //           }),
                  //     ),
                  //   );
                  // } else {
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
