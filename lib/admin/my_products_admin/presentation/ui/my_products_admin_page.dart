import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/admin/my_products_admin/data/models/menu_items_data.dart';
import 'package:haji_market/admin/my_products_admin/presentation/ui/banner_watch_recently_admin_page.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/category_admin_page.dart';
import 'package:haji_market/admin/my_products_admin/presentation/widgets/show_alert_statictics_widget.dart';
import 'package:haji_market/core/common/constants.dart';

import '../../data/bloc/product_admin_cubit.dart';
import '../../data/bloc/product_admin_state.dart';

class MyProductsAdminPage extends StatefulWidget {
  const MyProductsAdminPage({Key? key}) : super(key: key);

  @override
  State<MyProductsAdminPage> createState() => _MyProductsAdminPageState();
}

class _MyProductsAdminPageState extends State<MyProductsAdminPage> {
  @override
  void initState() {
    BlocProvider.of<ProductAdminCubit>(context).products();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: Column(
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
                Row(
                  children: [
                    PopupMenuButton(
                      onSelected: (value) {
                        if (value == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryAdminPage()),
                          );
                        }
                      },
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
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
                                      SvgPicture.asset(
                                          'assets/icons/lenta1.svg'),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  const Divider(),
                                ],
                              )),
                          PopupMenuItem(
                            height: 20,
                            value: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Добавить видео"),
                                SvgPicture.asset('assets/icons/video.svg'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                              height: 5, value: 1, child: Container()),
                        ];
                      },
                    ),
                    SvgPicture.asset('assets/icons/search.svg'),
                    const SizedBox(width: 10)
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 14,
            color: AppColors.kBackgroundColor,
          ),
          BlocConsumer<ProductAdminCubit, ProductAdminState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ErrorState) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(fontSize: 20.0, color: Colors.grey),
                    ),
                  );
                }
                if (state is LoadingState) {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: Colors.indigoAccent));
                }

                if (state is LoadedState) {
                  return Expanded(
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: GridView.builder(
                          padding: const EdgeInsets.only(
                              top: 16, left: 0, right: 0, bottom: 0),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 175,
                                  childAspectRatio: 2 / 3,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 16),
                          itemCount: state.productModel.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return Stack(
                              children: [
                                BannerWatcehRecentlyAdminPage(
                                    product: state.productModel[index]),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                InkWell(
                                  onTap: () {
                                    showAlertStaticticsWidget(
                                        context, state.productModel[index]);
                                  },
                                  child: Container(
                                    height: 28,
                                    width: 28,
                                    margin: const EdgeInsets.only(
                                        top: 8.0, right: 8.0, left: 135),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Icon(
                                      Icons.more_vert_rounded,
                                      color: AppColors.kPrimaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  );
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
