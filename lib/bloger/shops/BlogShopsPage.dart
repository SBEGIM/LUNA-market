import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../blogger_ad.dart';
import '../../core/common/constants.dart';
import '../../features/home/data/bloc/popular_shops_cubit.dart';
import '../../features/home/data/bloc/popular_shops_state.dart';
import '../my_products_admin/presentation/ui/shop_products_page.dart';

@RoutePage()
class BlogShopsPage extends StatefulWidget {
  const BlogShopsPage({super.key});

  @override
  State<BlogShopsPage> createState() => _BlogShopsPageState();
}

class _BlogShopsPageState extends State<BlogShopsPage> {
  bool _visibleIconClear = false;

  final searchController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<PopularShopsCubit>(context).popShops();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 16,
        title: const Text(
          'LUNA market',
          style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              horizontalTitleGap: 5,
              leading: SvgPicture.asset(
                'assets/icons/shop1.svg',
                height: 24,
                width: 24,
                color: AppColors.kPrimaryColor,
              ),
              trailing: GestureDetector(
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
                    : const SizedBox(
                        width: 5,
                      ),
              ),
              title: TextField(
                onChanged: (value) {
                  print(value);
                  BlocProvider.of<PopularShopsCubit>(context).searchShops(value);
                },
                keyboardType: TextInputType.text,
                // inputFormatters: [maskFormatter],
                controller: searchController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Название магазина',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    // borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.symmetric(horizontal: 16),
          //   child: const Text(
          //     'При продаже каждого рекламированного товара блогером % от каждой стоимости товара будет перечисляться на счет блогера. Размещая рекламные материалы, вы принимаете условия',
          //     style: TextStyle(
          //         fontSize: 12,
          //         fontWeight: FontWeight.w400,
          //         color: Colors.grey),
          //   ),
          // ),
          GestureDetector(
            onTap: () {
              Get.to(const BloggerAd());
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: RichText(
                textAlign: TextAlign.left,
                text: const TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          "При продаже каждого рекламированного товара блогером % от каждой стоимости товара будет перечисляться на счет блогера. Размещая рекламные материалы, вы принимаете условия ",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
                    ),
                    TextSpan(
                      text: "Типового договора на оказание рекламных услуг\n",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.kPrimaryColor),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          BlocConsumer<PopularShopsCubit, PopularShopsState>(
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

                if (state is LoadedState) {
                  return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 108 / 154,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: state.popularShops.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Get.to(() => ShopProductsBloggerPage(
                                    title: state.popularShops[index].name ?? '',
                                    id: state.popularShops[index].id!,
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              // margin: EdgeInsets.only(right: 5, left: 5),
                              padding: const EdgeInsets.only(right: 3, left: 16, top: 12, bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 12),
                                        height: 90,
                                        width: 90,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            image: DecorationImage(
                                                image: state.popularShops[index].image != null
                                                    ? NetworkImage(
                                                        "http://185.116.193.73/storage/${state.popularShops[index].image ?? ''}",
                                                      )
                                                    : const AssetImage('assets/icons/profile2.png') as ImageProvider,
                                                fit: BoxFit.fitWidth),
                                            color: const Color(0xFFF0F5F5)),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 84, left: 4),
                                        alignment: Alignment.center,
                                        height: 28,
                                        width: 28,
                                        //  padding: EdgeInsets.only(top: 40),
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage('assets/icons/bonus.png'),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: Text(
                                          '${state.popularShops[index].bonus}%',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black, fontSize: 8, fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(state.popularShops[index].name ?? '',
                                        textAlign: TextAlign.center, style: AppTextStyles.categoryTextStyle),
                                  ),
                                  // Flexible(
                                  //     child:
                                ],
                              ),
                            )); // );
                      });
                } else {
                  return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
                }
              }),
        ],
      ),
    );
  }
}
