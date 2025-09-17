import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/widgets/shimmer_box.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:haji_market/src/feature/seller/main/cubit/news_seller_cubit.dart';
import 'package:haji_market/src/feature/seller/main/cubit/news_seller_state.dart';
import 'package:haji_market/src/feature/seller/main/cubit/seller_notification_cubit.dart'
    as notificationCubit;
import 'package:haji_market/src/feature/seller/main/cubit/stories_seller_cubit.dart'
    as sellerStoriesCubit;
import 'package:haji_market/src/feature/seller/main/cubit/stories_seller_state.dart'
    as sellerStoriesState;
import 'package:haji_market/src/feature/seller/main/presentation/notification_seller_page.dart';
import 'package:haji_market/src/feature/seller/main/presentation/widget/news_card_widget.dart';
import 'package:haji_market/src/feature/seller/main/presentation/widget/stories_card_widget.dart';
import 'package:haji_market/src/feature/seller/profile/data/bloc/profile_statics_admin_cubit.dart'
    as profileStatisticsCubit;
import 'package:haji_market/src/feature/seller/profile/data/bloc/profile_statics_admin_state.dart'
    as profileStatisticsState;
import 'package:intl/intl.dart';

@RoutePage()
class HomeSellerAdminPage extends StatefulWidget {
  const HomeSellerAdminPage({super.key});

  @override
  State<HomeSellerAdminPage> createState() => _HomeSellerAdminPageState();
}

class _HomeSellerAdminPageState extends State<HomeSellerAdminPage> {
  int unreadCount = 0;

  @override
  void initState() {
    BlocProvider.of<NewsSellerCubit>(context).news();
    BlocProvider.of<profileStatisticsCubit.ProfileStaticsAdminCubit>(context)
        .statics();
    BlocProvider.of<sellerStoriesCubit.StoriesSellerCubit>(context).news();
    notificationCount();
    super.initState();
  }

  Future<int> notificationCount() async {
    unreadCount =
        await BlocProvider.of<notificationCubit.SellerNotificationCubit>(
                context)
            .count();
    setState(() {});

    return unreadCount;
  }

  String formatPrice(int price) {
    final format = NumberFormat('#,###', 'ru_RU');
    return format.format(price).replaceAll(',', ' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kWhite,
        appBar: AppBar(
          backgroundColor: AppColors.kWhite,
          centerTitle: false,
          title: Text(
            'Главная',
            style: AppTextStyles.defaultAppBarTextStyle
                .copyWith(color: AppColors.mainPurpleColor),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                onTap: () {
                  Get.to(NotificationSellerPage());
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      Assets.icons.defaultNotificationIcon.path,
                      scale: 1.9,
                      color: AppColors.kLightBlackColor,
                    ),
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
                            ' $unreadCount',
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
          // leading: Icon(Icons.notifications, color: AppColors.kPinkColor),
        ),
        body: Column(
          children: [
            BlocBuilder<sellerStoriesCubit.StoriesSellerCubit,
                    sellerStoriesState.StoriesSellerState>(
                builder: (context, state) {
              if (state is sellerStoriesState.ErrorState) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                );
              }
              if (state is sellerStoriesState.LoadedState) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    height: 87,
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
                              height: 86,
                              width: 86,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: index == 0
                                      ? AppColors.mainPurpleColor
                                      : AppColors.kGray200,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    12), // 14 - (4 padding + 2 border) = 8, but 10 looks better
                                child: Image.network(
                                  "https://lunamarket.ru/storage/${state.storiesSeelerModel[index].image}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
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
                            height: 87,
                            width: 87,
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
                                child: ShimmerBox()),
                          );
                        }),
                  ),
                );
              }
            }),

            BlocBuilder<profileStatisticsCubit.ProfileStaticsAdminCubit,
                    profileStatisticsState.ProfileStaticsAdminState>(
                builder: (context, state) {
              if (state is profileStatisticsState.ErrorState) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                );
              }
              if (state is profileStatisticsState.LoadedState) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.mainBackgroundPurpleColor),
                          height: 76,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(22), // половина от 44
                                child: Container(
                                  color: AppColors.kWhite,
                                  height: 44,
                                  width: 44,
                                  child: Image.asset(
                                    Assets.icons.sellerProductsIcon.path,
                                    scale: 1.9,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShaderMask(
                                    shaderCallback: (bounds) =>
                                        const LinearGradient(
                                      colors: [
                                        Color(0xFF7D2DFF),
                                        Color(0xFF41DDFF)
                                      ],
                                    ).createShader(bounds),
                                    child: Text(
                                      ' ${formatPrice(state.loadedProfile.productCount ?? 0)}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -1,
                                        color: Colors
                                            .white, // Неважно — будет заменён градиентом
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Товары',
                                    style: AppTextStyles.size13Weight400
                                        .copyWith(color: AppColors.kGray300),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.mainBackgroundPurpleColor),
                          height: 76,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(22),
                                child: Container(
                                  color: AppColors.kWhite,
                                  height: 44,
                                  width: 44,
                                  child: Image.asset(
                                    Assets.icons.sellerSalesIcon.path,
                                    scale: 1.9,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShaderMask(
                                    shaderCallback: (bounds) =>
                                        const LinearGradient(
                                      colors: [
                                        Color(0xFF7D2DFF),
                                        Color(0xFF41DDFF)
                                      ],
                                    ).createShader(bounds),
                                    child: Text(
                                      '${formatPrice(state.loadedProfile.salesSum ?? 0)} ₽',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0,
                                        color: Colors
                                            .white, // Неважно — будет заменён градиентом
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Продажи',
                                    style: AppTextStyles.size13Weight400
                                        .copyWith(color: AppColors.kGray300),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.mainBackgroundPurpleColor),
                          height: 76,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(22), // половина от 44
                                child: Container(
                                  color: AppColors.kWhite,
                                  height: 44,
                                  width: 44,
                                  child: Image.asset(
                                    Assets.icons.sellerProductsIcon.path,
                                    scale: 1.9,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShaderMask(
                                    shaderCallback: (bounds) =>
                                        const LinearGradient(
                                      colors: [
                                        Color(0xFF7D2DFF),
                                        Color(0xFF41DDFF)
                                      ],
                                    ).createShader(bounds),
                                    child: Text(
                                      '0',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -1,
                                        color: Colors
                                            .white, // Неважно — будет заменён градиентом
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Товары',
                                    style: AppTextStyles.size13Weight400
                                        .copyWith(color: AppColors.kGray300),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.mainBackgroundPurpleColor),
                          height: 76,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(22),
                                child: Container(
                                  color: AppColors.kWhite,
                                  height: 44,
                                  width: 44,
                                  child: Image.asset(
                                    Assets.icons.sellerSalesIcon.path,
                                    scale: 1.9,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShaderMask(
                                    shaderCallback: (bounds) =>
                                        const LinearGradient(
                                      colors: [
                                        Color(0xFF7D2DFF),
                                        Color(0xFF41DDFF)
                                      ],
                                    ).createShader(bounds),
                                    child: Text(
                                      '0 ₽',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0,
                                        color: Colors
                                            .white, // Неважно — будет заменён градиентом
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Продажи',
                                    style: AppTextStyles.size13Weight400
                                        .copyWith(color: AppColors.kGray300),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }
            }),

            BlocBuilder<NewsSellerCubit, NewsSellerState>(
                builder: (context, state) {
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: state.newsSeelerModel.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                Get.to(NewsScreen(
                                  news: state.newsSeelerModel[index],
                                ));
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.all(16),
                                  height: 148,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topLeft,
                                      transform: const GradientRotation(
                                          4.2373), // 242.73 degrees in radians
                                      colors: [
                                        Color(0xFFAD32F8), // #AD32F8
                                        Color(0xFF3275F8), // #3275F8
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 300,
                                            child: Text(
                                              state.newsSeelerModel[index]
                                                  .title!,
                                              style: AppTextStyles
                                                  .defaultAppBarTextStyle
                                                  .copyWith(
                                                      color: AppColors
                                                          .kBackgroundColor),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Flexible(
                                            child: Text(
                                              state.newsSeelerModel[index]
                                                  .description!,
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3,
                                              style: AppTextStyles
                                                  .statisticsTextStyle
                                                  .copyWith(
                                                      color:
                                                          AppColors.kGray200),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 16.0),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: AppColors.kWhite,
                                          size: 20,
                                        ),
                                      )
                                    ],
                                  )));
                        }),
                  ),
                );
              } else {
                return Container(
                  color: Colors.white,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ShimmerBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width - 32,
                      radius: 8,
                    ),
                  ),
                );
              }
            }),
            // Padding(
            //   padding: const EdgeInsets.all(5.0),
            //   child: SizedBox(
            //     height: 400,
            //     child: ListView.builder(
            //         scrollDirection: Axis.vertical,
            //         itemCount: news.length,
            //         itemBuilder: (context, index) {
            //           return InkWell(
            //             onTap: () {
            //               Get.to(NewsScreen());
            //             },
            //             child: Container(
            //                 margin: const EdgeInsets.only(left: 5, bottom: 5),
            //                 padding: const EdgeInsets.all(1),
            //                 height: 148,
            //                 decoration: BoxDecoration(
            //                   gradient: LinearGradient(
            //                     begin: Alignment.topLeft,
            //                     end: Alignment.bottomRight,
            //                     transform: const GradientRotation(
            //                         4.2373), // 242.73 degrees in radians
            //                     colors: [
            //                       Color(0xFFAD32F8), // #AD32F8
            //                       Color(0xFF3275F8), // #3275F8
            //                     ],
            //                   ),
            //                   borderRadius: BorderRadius.circular(14),
            //                 ),
            //                 child: Padding(
            //                   padding: const EdgeInsets.all(4.0),
            //                   child: Column(
            //                     children: [
            //                       Padding(
            //                         padding: const EdgeInsets.all(4.0),
            //                         child: Text(
            //                           news[index].name!,
            //                           style: AppTextStyles
            //                               .defaultAppBarTextStyle
            //                               .copyWith(
            //                                   color:
            //                                       AppColors.kBackgroundColor),
            //                         ),
            //                       ),
            //                       Text(
            //                         news[index].createdAt!,
            //                         style: AppTextStyles.statisticsTextStyle
            //                             .copyWith(color: AppColors.kGray300),
            //                       )
            //                     ],
            //                   ),
            //                 )),
            //           );
            //         }),
            //   ),
            // ),
          ],
        ));
  }
}
