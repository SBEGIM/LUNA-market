import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/tape/presentation/data/bloc/tape_cubit.dart'
    as tapeAdmin;
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/tape/presentation/data/bloc/tape_cubit.dart';
import 'package:haji_market/features/tape/presentation/data/repository/tape_repo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../features/app/bloc/navigation_cubit/navigation_cubit.dart';
import '../../../../features/tape/presentation/data/bloc/tape_state.dart'
    as tapeState;

import '../../../../features/app/presentaion/base.dart';
import '../../../../features/tape/presentation/widgets/tape_card_widget.dart';
import '../../../auth/presentation/ui/blog_auth_register_page.dart';
import '../../../my_orders_admin/presentation/widgets/tape_card_widget.dart';
import '../../../my_products_admin/presentation/widgets/statistics_blogger_show_page.dart';
import '../data/bloc/profile_statics_blogger_cubit.dart';
import '../data/bloc/profile_statics_blogger_state.dart';
import '../widgets/reqirect_profile_page.dart';
import 'blogger_cards_page.dart';

@RoutePage()
class ProfileBloggerTapePage extends StatefulWidget with AutoRouteWrapper {
  int bloggerId;
  String bloggerName;
  String bloggerAvatar;
  ProfileBloggerTapePage(
      {required this.bloggerId,
      required this.bloggerName,
      required this.bloggerAvatar,
      Key? key})
      : super(key: key);

  @override
  State<ProfileBloggerTapePage> createState() => _ProfileBloggerTapePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<TapeCubit>(
      create: (context) => TapeCubit(tapeRepository: TapeRepository()),
      child: this,
    );
  }
}

class _ProfileBloggerTapePageState extends State<ProfileBloggerTapePage> {
  final _box = GetStorage();
  RefreshController refreshController = RefreshController();

  Future<void> onLoading() async {
    await BlocProvider.of<TapeCubit>(context)
        .tapePagination(false, false, '', widget.bloggerId);
    await Future.delayed(const Duration(milliseconds: 2000));
    refreshController.loadComplete();
  }

  @override
  void initState() {
    BlocProvider.of<ProfileStaticsBloggerCubit>(context)
        .statics(widget.bloggerId);
    BlocProvider.of<tapeAdmin.TapeCubit>(context)
        .tapes(false, false, '', widget.bloggerId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        // iconTheme: const IconThemeData(color: Colors.red),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.kPrimaryColor,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Профиль блогера',
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        // actions: [
        //   Padding(
        //       padding: const EdgeInsets.only(right: 16.0),
        //       child: SvgPicture.asset('assets/icons/notification.svg'))
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              horizontalTitleGap: 12,
              leading: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    image: DecorationImage(
                      image: widget.bloggerAvatar != null
                          ? NetworkImage(
                              "http://185.116.193.73/storage/${widget.bloggerAvatar}")
                          : const AssetImage('assets/icons/profile2.png')
                              as ImageProvider,
                      fit: BoxFit.cover,
                    )),
              ),
              title: Text(
                widget.bloggerName,
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.kGray900,
                    fontSize: 16),
              ),
              trailing: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const ReqirectProfilePage()),
                  // );
                },
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 1,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                  child: const Text(
                    'Подписаться',
                    style: TextStyle(
                        color: AppColors.kPrimaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              width: 500,
              height: 76,
              child: BlocConsumer<ProfileStaticsBloggerCubit,
                  ProfileStaticsBloggerState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is LoadedState) {
                    return Container(
                      padding: const EdgeInsets.only(top: 16, left: 16),
                      alignment: Alignment.center,
                      //  height: 76,
                      // width: 343,
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  state.loadedProfile.videoReview.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Text(
                                  'Видео обзоров',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(width: 40),
                            Column(
                              children: [
                                Text(
                                  state.loadedProfile.subscribers.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Text(
                                  'Подписчиков',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(width: 40),
                            Column(
                              children: [
                                Text(
                                  state.loadedProfile.sales.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Text(
                                  'Продаж',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ]),
                    );
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: Colors.indigoAccent));
                  }
                },
              ),
            ),
            Expanded(
              // padding: const EdgeInsets.symmetric(horizontal: 16),
              // alignment: Alignment.center,
              // width: 500,
              // height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: BlocConsumer<tapeAdmin.TapeCubit, tapeState.TapeState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is tapeState.BloggerLoadedState) {
                      return SmartRefresher(
                          controller: refreshController,
                          enablePullUp: true,
                          onLoading: () {
                            onLoading();
                          },
                          onRefresh: () {
                            BlocProvider.of<tapeAdmin.TapeCubit>(context)
                                .tapes(false, false, '', widget.bloggerId);
                            refreshController.refreshCompleted();
                          },
                          child: GridView.builder(
                            padding: const EdgeInsets.all(1),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 150,
                              childAspectRatio: 1 / 2,
                              mainAxisSpacing: 3,
                              crossAxisSpacing: 3,
                            ),
                            itemCount: state.tapeModel.length,
                            // children: const [],
                            itemBuilder: (context, index) {
                              return Shimmer(
                                duration:
                                    const Duration(seconds: 3), //Default value
                                interval: const Duration(
                                    microseconds:
                                        1), //Default value: Duration(seconds: 0)
                                color: Colors.white, //Default value
                                colorOpacity: 0, //Default value
                                enabled: true, //Default value
                                direction: const ShimmerDirection
                                    .fromLTRB(), //Default Value
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey.withOpacity(0.6),
                                  ),
                                  child: TapeCardWidget(
                                    tape: state.tapeModel[index],
                                    index: index,
                                  ),
                                ),
                              );
                            },
                          ));
                    } else {
                      return const Center(
                          child: CircularProgressIndicator(
                              color: Colors.indigoAccent));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
