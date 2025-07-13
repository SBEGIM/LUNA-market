import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
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
                    Icon(
                      Icons.notifications_active_outlined,
                      color: AppColors.kLightBlackColor,
                      size: 30,
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
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
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
                              padding: const EdgeInsets.all(2),
                              height: 79,
                              width: 100,
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
                                child: ShimmerBox()),
                          );
                        }),
                  ),
                );
              }
            }),

            SizedBox(height: 15),
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
                    padding: const EdgeInsets.all(8.0),
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
                                  margin:
                                      const EdgeInsets.only(left: 5, bottom: 5),
                                  padding: const EdgeInsets.all(1),
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
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
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
                                            SizedBox(height: 10),
                                            Text(
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
                                            )
                                          ],
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: AppColors.kWhite,
                                          size: 20,
                                        )
                                      ],
                                    ),
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
