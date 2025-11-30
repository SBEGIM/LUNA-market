import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/tape/bloc/tape_cubit.dart' as tapeAdmin;
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/tape/bloc/tape_cubit.dart';
import 'package:haji_market/src/feature/tape/data/repository/tape_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../../tape/bloc/subs_cubit.dart';
import '../../../../tape/bloc/tape_state.dart' as tapeState;
import '../../../../tape/presentation/widgets/tape_card_widget.dart';
import '../../bloc/profile_statics_blogger_cubit.dart';
import '../../bloc/profile_statics_blogger_state.dart';

@RoutePage()
class ProfileBloggerTapePage extends StatefulWidget implements AutoRouteWrapper {
  final int bloggerId;
  final String bloggerCreatedAt;

  final String bloggerName;
  final String bloggerAvatar;
  final bool inSubscribe;
  final Function(bool)? onSubChanged;
  ProfileBloggerTapePage({
    required this.bloggerId,
    required this.bloggerCreatedAt,
    required this.bloggerName,
    required this.bloggerAvatar,
    Key? key,
    required this.inSubscribe,
    this.onSubChanged,
  }) : super(key: key);

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

  bool inSub = false;
  RefreshController refreshController = RefreshController();

  Future<void> onLoading() async {
    await BlocProvider.of<TapeCubit>(context).tapePagination(false, false, '', widget.bloggerId);
    await Future.delayed(const Duration(milliseconds: 2000));
    refreshController.loadComplete();
  }

  @override
  void initState() {
    inSub = widget.inSubscribe;
    BlocProvider.of<ProfileStaticsBloggerCubit>(context).statics(widget.bloggerId);
    BlocProvider.of<tapeAdmin.TapeCubit>(context).tapes(false, false, '', widget.bloggerId);
    // BlocProvider.of<tapeAdmin.TapeCubit>(context).toBloggerLoadedState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.kBackgroundColor,
      appBar: AppBar(
        // iconTheme: const IconThemeData(color: Colors.red),
        backgroundColor: AppColors.kWhite,
        surfaceTintColor: AppColors.kWhite,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: Image.asset(Assets.icons.defaultBackIcon.path, scale: 1.9),
        ),
        centerTitle: true,
        title: Text('${widget.bloggerName}', style: AppTextStyles.size18Weight600),
        // actions: [
        //   Padding(
        //       padding: const EdgeInsets.only(right: 16.0),
        //       child: SvgPicture.asset('assets/icons/notification.svg'))
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 167,
              decoration: BoxDecoration(
                color: AppColors.kWhite,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 16),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          image: DecorationImage(
                            image: widget.bloggerAvatar != null
                                ? NetworkImage(
                                    "https://lunamarket.ru/storage/${widget.bloggerAvatar}",
                                  )
                                : const AssetImage('assets/icons/profile2.png') as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.bloggerName, style: AppTextStyles.size18Weight600),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              SvgPicture.asset(Assets.icons.sellerIcon.path),
                              SizedBox(width: 5),
                              Text('Блогер', style: AppTextStyles.size13Weight400),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Дата регистрации: ${widget.bloggerCreatedAt}',
                            style: AppTextStyles.size11Weight400.copyWith(color: Color(0xffAEAEB2)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<SubsCubit>(context).sub(widget.bloggerId);
                      setState(() {
                        inSub = !inSub;
                      });

                      widget.onSubChanged?.call(inSub);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      height: 36,
                      decoration: BoxDecoration(
                        color: inSub != true
                            ? AppColors.mainPurpleColor
                            : AppColors.mainPurpleColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        inSub != true ? 'Подписаться' : 'Вы подписаны',
                        style: AppTextStyles.size14Weight600.copyWith(color: AppColors.kWhite),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            BlocBuilder<ProfileStaticsBloggerCubit, ProfileStaticsBloggerState>(
              builder: (context, state) {
                if (state is LoadedState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 72,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.loadedProfile.videoReview.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Text(
                                'Видео обзоров',
                                style: TextStyle(
                                  color: AppColors.kGray300,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Container(
                          height: 72,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ' ${state.loadedProfile.subscribers}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Text(
                                'Подписчики',
                                style: TextStyle(
                                  color: AppColors.kGray300,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Container(
                          height: 72,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ' ${state.loadedProfile.sales}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Text(
                                'Продаж',
                                style: TextStyle(
                                  color: AppColors.kGray300,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
                }
              },
            ),
            Expanded(
              // padding: const EdgeInsets.symmetric(horizontal: 16),
              // alignment: Alignment.center,
              // width: 500,
              // height: 200,
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: BlocBuilder<tapeAdmin.TapeCubit, tapeState.TapeState>(
                  builder: (context, state) {
                    if (state is tapeState.BloggerLoadedState) {
                      return SmartRefresher(
                        controller: refreshController,
                        enablePullUp: true,
                        onLoading: () {
                          onLoading();
                        },
                        onRefresh: () {
                          BlocProvider.of<TapeCubit>(
                            context,
                          ).tapes(false, false, '', widget.bloggerId);
                          refreshController.refreshCompleted();
                        },
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 150,
                            childAspectRatio: 1 / 2,
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 1,
                          ),
                          itemCount: state.tapeModel.length,
                          // children: const [],
                          itemBuilder: (context, index) {
                            return Shimmer(
                              duration: const Duration(seconds: 3), //Default value
                              interval: const Duration(
                                microseconds: 1,
                              ), //Default value: Duration(seconds: 0)
                              color: Colors.white, //Default value
                              colorOpacity: 0, //Default value
                              enabled: true, //Default value
                              direction: const ShimmerDirection.fromLTRB(), //Default Value
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.withOpacity(0.6),
                                ),
                                child: TapeCardWidget(
                                  tape: state.tapeModel[index],
                                  index: index,
                                  bloggerName: widget.bloggerName,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.indigoAccent),
                      );
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
