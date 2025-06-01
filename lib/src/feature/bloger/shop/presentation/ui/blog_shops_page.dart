import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/widgets/shimmer_box.dart';
import 'package:haji_market/src/feature/bloger/shop/presentation/ui/notification_blogger_page.dart';
import 'package:haji_market/src/feature/bloger/shop/presentation/widgets/show_blogget_cats_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/metas_webview.dart';
import 'package:haji_market/src/feature/home/bloc/cats_cubit.dart' as catsCubit;
import 'package:haji_market/src/feature/home/bloc/cats_state.dart' as catsState;
import 'package:haji_market/src/feature/home/bloc/meta_cubit.dart' as metaCubit;
import 'package:haji_market/src/feature/home/bloc/meta_state.dart' as metaState;
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:haji_market/src/feature/seller/main/presentation/widget/stories_card_widget.dart';
import '../../../../home/bloc/popular_shops_cubit.dart';
import '../../../../home/bloc/popular_shops_state.dart';
import 'shop_products_page.dart';
import 'package:haji_market/src/feature/seller/main/cubit/stories_seller_cubit.dart'
    as sellerStoriesCubit;
import 'package:haji_market/src/feature/seller/main/cubit/stories_seller_state.dart'
    as sellerStoriesState;
import 'package:haji_market/src/core/common/constants.dart';

@RoutePage()
class BlogShopsPage extends StatefulWidget {
  const BlogShopsPage({super.key});

  @override
  State<BlogShopsPage> createState() => _BlogShopsPageState();
}

class _BlogShopsPageState extends State<BlogShopsPage> {
  int unreadCount = 3;

  bool _visibleIconClear = false;

  final searchController = TextEditingController();

  // List<String> metas = [
  //   'Пользовательское соглашение',
  //   'Оферта для продавцов',
  //   'Политика конфиденциальности',
  //   'Типовой договор купли-продажи',
  //   'Типовой договор на оказание рекламных услуг'
  // ];

  List<CatsModel> _cats = [];

  // List<String> images = [
  //   Assets.images.storyFirst.path,
  //   Assets.images.storySecond.path,
  //   Assets.images.storyThirty.path,
  //   Assets.images.storyForty.path
  // ];

  List<String> metasBody = [];
  @override
  void initState() {
    BlocProvider.of<PopularShopsCubit>(context).popShops();

    BlocProvider.of<sellerStoriesCubit.StoriesSellerCubit>(context).news();
    if (BlocProvider.of<catsCubit.CatsCubit>(context).state
        is! catsState.LoadedState) {
      BlocProvider.of<catsCubit.CatsCubit>(context).cats();
    }

    if (BlocProvider.of<metaCubit.MetaCubit>(context).state
        is! metaState.LoadedState) {
      BlocProvider.of<metaCubit.MetaCubit>(context).partners();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kGray2,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 16,
        title: const Text(
          'Магазины',
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () {
                Get.to(NotificationBloggerPage());
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(Icons.notifications, color: AppColors.mainPurpleColor),
                  if (unreadCount > 0)
                    Positioned(
                      right: -8,
                      top: -16,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Text(
                          '$unreadCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 0),
            decoration: BoxDecoration(
              color: AppColors.kWhite,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                BlocBuilder<sellerStoriesCubit.StoriesSellerCubit,
                        sellerStoriesState.StoriesSellerState>(
                    builder: (context, state) {
                  if (state is sellerStoriesState.ErrorState) {
                    return Center(
                      child: Text(
                        state.message,
                        style:
                            const TextStyle(fontSize: 20.0, color: Colors.grey),
                      ),
                    );
                  }
                  if (state is sellerStoriesState.LoadedState) {
                    return SizedBox(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.storiesSeelerModel.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => Get.to(StoryScreen(
                                  stories:
                                      state.storiesSeelerModel[index].stories)),
                              child: Container(
                                margin: const EdgeInsets.only(left: 5),
                                padding: const EdgeInsets.all(1),
                                height: 79,
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: index == 0
                                        ? AppColors.mainPurpleColor
                                        : Colors.white,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      10), // 14 - (4 padding + 2 border) = 8, but 10 looks better
                                  child: Image.network(
                                    "https://lunamarket.ru/storage/${state.storiesSeelerModel[index].image}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        height: 100,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(left: 5),
                                padding: const EdgeInsets.all(1),
                                height: 79,
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.mainPurpleColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        10), // 14 - (4 padding + 2 border) = 8, but 10 looks better
                                    child: ShimmerBox()),
                              );
                            }),
                      ),
                    );
                  }
                }),
                SizedBox(height: 10),
                Container(
                  height: 44,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 12, left: 12, right: 12),
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
                            print(value);
                            BlocProvider.of<PopularShopsCubit>(context)
                                .searchShops(value);
                          },
                          keyboardType: TextInputType.text,
                          controller: searchController,
                          decoration: const InputDecoration(
                            hintText: 'Поиск',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            isCollapsed: true, // Убирает внутренние отступы
                          ),
                          style: TextStyle(
                              height: 1.2), // Центрирует текст по вертикали
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
              ],
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

          // BlocBuilder<metaCubit.MetaCubit, metaState.MetaState>(
          //     builder: (context, state) {
          //   if (state is metaState.LoadedState) {
          //     metasBody.addAll([
          //       state.metas.terms_of_use!,
          //       state.metas.privacy_policy!,
          //       state.metas.contract_offer!,
          //       state.metas.shipping_payment!,
          //       state.metas.TTN!,
          //     ]);
          //     return GestureDetector(
          //       onTap: () {
          //         Get.to(() => MetasPage(
          //               title: metas[3],
          //               body: metasBody[3],
          //             ));
          //       },
          //       child: Container(
          //         margin: const EdgeInsets.symmetric(horizontal: 16),
          //         child: RichText(
          //           textAlign: TextAlign.left,
          //           text: const TextSpan(
          //             style: TextStyle(fontSize: 16, color: Colors.black),
          //             children: <TextSpan>[
          //               TextSpan(
          //                 text:
          //                     "При продаже каждого рекламированного товара блогером % от каждой стоимости товара будет перечисляться на счет блогера. Размещая рекламные материалы, вы принимаете условия ",
          //                 style: TextStyle(
          //                     fontSize: 12,
          //                     fontWeight: FontWeight.w400,
          //                     color: Colors.grey),
          //               ),
          //               TextSpan(
          //                 text:
          //                     "Типового договора на оказание рекламных услуг\n",
          //                 style: TextStyle(
          //                     fontSize: 12,
          //                     fontWeight: FontWeight.w400,
          //                     color: AppColors.kPrimaryColor),
          //               )
          //             ],
          //           ),
          //         ),
          //       ),
          //     );
          //   } else {
          //     return const Center(
          //         child: CircularProgressIndicator(color: Colors.indigoAccent));
          //   }
          // }),
          const SizedBox(height: 10),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Все магазины',
                  style: AppTextStyles.defaultButtonTextStyle,
                ),
                InkWell(
                  onTap: () async {
                    if (_cats.isEmpty) {
                      _cats =
                          await BlocProvider.of<catsCubit.CatsCubit>(context)
                              .catsList();

                      _cats.insert(0, CatsModel(id: 0, name: 'Все магазины'));
                    }

                    showBlogerCatsOptions(
                        context,
                        BlocProvider.of<PopularShopsCubit>(context),
                        _cats, (value) {
                      print(value);
                      BlocProvider.of<PopularShopsCubit>(context)
                          .searchByIdShops(value);
                    });
                  },
                  child: SvgPicture.asset(
                    Assets.icons.filterSvg.path,
                    color: AppColors.kLightBlackColor,
                  ),
                )
              ],
            ),
          ),
          BlocConsumer<PopularShopsCubit, PopularShopsState>(
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

                if (state is LoadedState) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
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
                              padding: const EdgeInsets.only(
                                  right: 0, left: 12, top: 12, bottom: 12),
                              margin: EdgeInsets.only(top: 10),
                              height: 100,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 96,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 0.5,
                                      ),
                                      color: const Color(0xFFF0F5F5),
                                      image: DecorationImage(
                                        image: state.popularShops[index]
                                                        .image !=
                                                    null &&
                                                state.popularShops[index].image!
                                                    .isNotEmpty
                                            ? NetworkImage(
                                                "https://lunamarket.ru/storage/${state.popularShops[index].image!}",
                                              )
                                            : AssetImage(
                                                Assets.images.aboutImage.path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 0),
                                      Text(state.popularShops[index].name ?? '',
                                          textAlign: TextAlign.center,
                                          style: AppTextStyles
                                              .defaultButtonTextStyle
                                              .copyWith(
                                                  color: AppColors
                                                      .kLightBlackColor,
                                                  fontWeight: FontWeight.w500)),
                                      SizedBox(height: 5),
                                      Text(
                                          state.popularShops[index].catName ??
                                              'Одежда',
                                          textAlign: TextAlign.center,
                                          style: AppTextStyles.categoryTextStyle
                                              .copyWith(
                                                  color: AppColors.kGray300)),
                                      SizedBox(height: 5),
                                      Row(
                                        children: [
                                          RatingBar(
                                            ignoreGestures: true,
                                            initialRating: double.parse(state
                                                .popularShops[index].rating
                                                .toString()),
                                            minRating: 0,
                                            maxRating: 5,
                                            itemCount: 5,
                                            // unratedColor: const Color(0x30F11712),
                                            itemSize: 14,
                                            unratedColor:
                                                const Color(0xFFFFC107),
                                            // itemPadding:
                                            // const EdgeInsets.symmetric(horizontal: 4.0),
                                            ratingWidget: RatingWidget(
                                              full: const Icon(
                                                Icons.star,
                                                color: Color(0xFFFFC107),
                                              ),
                                              half: const Icon(
                                                Icons.star,
                                                color: Colors.grey,
                                              ),
                                              empty: const Icon(
                                                Icons.star,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            onRatingUpdate: (double value) {},
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "${double.parse(state.popularShops[index].rating.toString())}",
                                            style: const TextStyle(
                                                color: AppColors.kGray300,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // Flexible(
                                  //     child:
                                ],
                              ),
                            )); // );
                      });
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: Colors.indigoAccent));
                }
              }),
        ],
      ),
    );
  }
}
