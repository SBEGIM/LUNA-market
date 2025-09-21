import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/bloger/profile/bloc/profile_statics_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/profile/bloc/profile_statics_blogger_state.dart';
import 'package:haji_market/src/feature/chat/presentation/message.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:haji_market/src/feature/tape/bloc/subs_cubit.dart';
import 'package:haji_market/src/feature/tape/bloc/tape_cubit.dart' as tapeAdmin;
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/tape/bloc/tape_cubit.dart';
import 'package:haji_market/src/feature/tape/bloc/tape_state.dart' as tapeState;
import 'package:haji_market/src/feature/tape/data/repository/tape_repository.dart';
import 'package:haji_market/src/feature/tape/presentation/widgets/tape_card_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

@RoutePage()
class ProfileSellerTapePage extends StatefulWidget implements AutoRouteWrapper {
  final int sellerId;
  final int chatId;
  final String sellerCreatedAt;
  final String sellerName;
  final String sellerAvatar;
  final bool inSubscribe;
  final Function(bool)? onSubChanged;
  ProfileSellerTapePage(
      {required this.sellerId,
      required this.chatId,
      required this.sellerCreatedAt,
      required this.sellerName,
      required this.sellerAvatar,
      Key? key,
      required this.inSubscribe,
      this.onSubChanged})
      : super(key: key);

  @override
  State<ProfileSellerTapePage> createState() => _ProfileBloggerTapePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<TapeCubit>(
      create: (context) => TapeCubit(tapeRepository: TapeRepository()),
      child: this,
    );
  }
}

class _ProfileBloggerTapePageState extends State<ProfileSellerTapePage> {
  final _box = GetStorage();

  bool inSub = false;
  RefreshController refreshController = RefreshController();

  Future<void> onLoading() async {
    await BlocProvider.of<TapeCubit>(context)
        .tapePagination(false, false, '', 42);
    await Future.delayed(const Duration(milliseconds: 2000));
    refreshController.loadComplete();
  }

  @override
  void initState() {
    inSub = widget.inSubscribe;
    BlocProvider.of<ProfileStaticsBloggerCubit>(context)
        .statics(widget.sellerId);
    BlocProvider.of<tapeAdmin.TapeCubit>(context).tapes(false, false, '', 42);
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
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.router.pop();
          },
          icon: Image.asset(Assets.icons.defaultBackIcon.path, scale: 1.9),
        ),
        centerTitle: true,
        title: Text(
          '${widget.sellerName}',
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
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
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 157,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppColors.kWhite,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  SizedBox(height: 12),
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
                              image: widget.sellerAvatar != null
                                  ? NetworkImage(
                                      "https://lunamarket.ru/storage/${widget.sellerAvatar}")
                                  : const AssetImage(
                                          'assets/icons/profile2.png')
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            )),
                      ),
                      SizedBox(width: 12),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.sellerName,
                            style: AppTextStyles.size18Weight600,
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              SvgPicture.asset(Assets.icons.sellerIcon.path),
                              SizedBox(width: 5),
                              Text(
                                'Официальный партнер',
                                style: AppTextStyles.size13Weight400,
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Дата регистрации: ${widget.sellerCreatedAt}',
                            style: AppTextStyles.size11Weight400.copyWith(
                              color: AppColors.kGray300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              BlocProvider.of<SubsCubit>(context)
                                  .subShop(widget.sellerId);
                              setState(() {
                                inSub = !inSub;
                              });

                              widget.onSubChanged?.call(inSub);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 16, right: 0, top: 15, bottom: 5),
                              height: 36,
                              decoration: BoxDecoration(
                                color: inSub != true
                                    ? AppColors.mainPurpleColor
                                    : AppColors.mainPurpleColor
                                        .withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                inSub != true ? 'Подписаться' : 'Вы подписаны',
                                style: AppTextStyles.size14Weight600
                                    .copyWith(color: AppColors.kWhite),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              GetStorage().write('video_stop', true);

                              // if (state.tapeModel[index].chatId ==
                              //     null) {
                              Get.to(MessagePage(
                                  userId: widget.sellerId,
                                  name: widget.sellerName,
                                  avatar: widget.sellerAvatar,
                                  chatId: widget.sellerId));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 8, right: 0, top: 15, bottom: 5),
                              height: 36,
                              decoration: BoxDecoration(
                                color: AppColors.kGray2,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Cообщение',
                                style: AppTextStyles.size14Weight600
                                    .copyWith(color: Color(0xFF636366)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              GetStorage().remove('CatId');
                              GetStorage().remove('subCatFilterId');
                              GetStorage().remove('shopFilterId');
                              GetStorage().remove('search');
                              GetStorage()
                                  .write('shopFilter', widget.sellerName ?? '');
                              // GetStorage().write('shopFilterId', state.popularShops[index].id);

                              List<int> selectedListSort = [];

                              selectedListSort.add(widget.sellerId as int);

                              GetStorage().write(
                                  'shopFilterId', selectedListSort.toString());

                              // GetStorage().write('shopSelectedIndexSort', index);
                              context.router.push(ProductsRoute(
                                cats: CatsModel(
                                    id: 0,
                                    name: widget.sellerName,
                                    text: 'Все товары',
                                    image:
                                        'cat/40/image/qRPANK2TsQxyJfmaFlfcoHgOUEdMKKyzc8wlVX8F.png'),
                                shopId: widget.sellerId.toString(),
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 8, right: 16, top: 15, bottom: 5),
                              height: 36,
                              decoration: BoxDecoration(
                                color: AppColors.kGray2,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'В магазин',
                                style: AppTextStyles.size14Weight600
                                    .copyWith(color: Color(0xFF636366)),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            BlocBuilder<ProfileStaticsBloggerCubit, ProfileStaticsBloggerState>(
              builder: (context, state) {
                if (state is LoadedState) {
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 128,
                          height: 72,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.loadedProfile.videoReview.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              const Text(
                                'Видео обзоров',
                                style: TextStyle(
                                    color: AppColors.kGray300,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 128,
                          height: 72,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ' ${state.loadedProfile.subscribers}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              const Text(
                                'Подписчики',
                                style: TextStyle(
                                    color: AppColors.kGray300,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 128,
                          height: 72,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ' ${state.loadedProfile.sales}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                              const Text(
                                'Продаж',
                                style: TextStyle(
                                    color: AppColors.kGray300,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ]);
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: Colors.indigoAccent));
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
                            BlocProvider.of<TapeCubit>(context)
                                .tapes(false, false, '', widget.sellerId);
                            refreshController.refreshCompleted();
                          },
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 150,
                              childAspectRatio: 1 / 2,
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 1,
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
