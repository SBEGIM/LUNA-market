import 'package:auto_route/auto_route.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/count_zero_dialog.dart';
import 'package:haji_market/src/feature/home/bloc/meta_cubit.dart';
import 'package:haji_market/src/feature/tape/bloc/tape_check_cubit.dart';
import 'package:haji_market/src/feature/tape/data/repository/tape_repository.dart';
import 'package:intl/intl.dart';
import 'package:show_image/show_image.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/widgets/custom_back_button.dart';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:haji_market/src/feature/tape/bloc/subs_cubit.dart';
import 'package:haji_market/src/feature/tape/data/models/tape_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:visibility_detector/visibility_detector.dart';
//import 'package:video_player/video_player.dart';
import '../../../chat/presentation/message.dart';
import '../../../basket/bloc/basket_cubit.dart' as basCubit;
import '../../../favorite/bloc/favorite_cubit.dart' as favCubit;
import '../../../drawer/presentation/widgets/pre_order_dialog.dart';
import '../../bloc/tape_cubit.dart' as tapeCubit;
import '../../bloc/tape_state.dart' as tapeState;

@RoutePage()
class DetailTapeCardPage extends StatefulWidget implements AutoRouteWrapper {
  final int? index;
  final int? tapeId;
  final String? shopName;
  final tapeCubit.TapeCubit tapeBloc;
  const DetailTapeCardPage(
      {required this.index,
      required this.shopName,
      Key? key,
      required this.tapeBloc,
      this.tapeId})
      : super(key: key);

  @override
  State<DetailTapeCardPage> createState() => _DetailTapeCardPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<tapeCubit.TapeCubit>.value(
          value: tapeBloc,
        ),
        BlocProvider(
          create: (context) => TapeCheckCubit(tapeRepository: TapeRepository()),
        )
      ],
      child: this,
    );
  }
}

class _DetailTapeCardPageState extends State<DetailTapeCardPage> {
  PageController controller = PageController();
  String? title;
  final TextEditingController searchController = TextEditingController();
  bool visible = true;

  // bool? inSub;
  int currentIndex = 0;

  bool stop = false;

  int compoundPrice = 0;

  procentPrice(price, compound) {
    var pp = (((price!.toInt() - compound!.toInt()) / price!.toInt()) * 100)
        as double;
    return pp.toInt();
  }

  @override
  void initState() {
    if (widget.index != null) {
      currentIndex = widget.index!;
      controller = PageController(initialPage: widget.index!);
    }
    final tape = BlocProvider.of<tapeCubit.TapeCubit>(context);
    if (tape.state is tapeState.LoadedState) {
      if ((tape.state as tapeState.LoadedState)
              .tapeModel[currentIndex]
              .tapeId !=
          null) {
        BlocProvider.of<TapeCheckCubit>(context).tapeCheck(
            tapeId: (tape.state as tapeState.LoadedState)
                .tapeModel[currentIndex]
                .tapeId!);
      }
    }

    if (BlocProvider.of<MetaCubit>(context).state is! LoadedState) {
      BlocProvider.of<MetaCubit>(context).partners();
    }
    title = 'Лента';
    // GetStorage().write('title_tape', 'Отписаться');
    super.initState();
  }

  String formatPrice(int price) {
    final format = NumberFormat('#,###', 'ru_RU');
    return format.format(price).replaceAll(',', ' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //extendBody: true,
        extendBodyBehindAppBar: false,
        backgroundColor: Colors.black,
        body: BlocConsumer<tapeCubit.TapeCubit, tapeState.TapeState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is tapeState.ErrorState) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(fontSize: 20.0, color: Colors.grey),
                  ),
                );
              }
              if (state is tapeState.LoadingState) {
                return const Center(
                    child:
                        CircularProgressIndicator(color: Colors.indigoAccent));
              }

              if (state is tapeState.LoadedState) {
                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  controller: controller,
                  itemCount: state.tapeModel.length,
                  onPageChanged: (value) {
                    currentIndex = value;
                    if (state.tapeModel[value].tapeId != null) {
                      BlocProvider.of<TapeCheckCubit>(context)
                          .tapeCheck(tapeId: state.tapeModel[value].tapeId!);
                    }
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Videos(tape: state.tapeModel[index]),
                        Positioned(
                          top: 85,
                          left: 10,
                          child: BlocBuilder<tapeCubit.TapeCubit,
                              tapeState.TapeState>(
                            builder: (context, state) {
                              if (state is tapeState.LoadedState) {
                                compoundPrice = (state
                                            .tapeModel[currentIndex].price!
                                            .toInt() *
                                        (((100 -
                                                state.tapeModel[currentIndex]
                                                    .compound!
                                                    .toInt())) /
                                            100))
                                    .toInt();

                                return visible == true &&
                                        (state.tapeModel[currentIndex]
                                                .blogger !=
                                            null)
                                    ? GestureDetector(
                                        onTap: () {
                                          context.router
                                              .push(ProfileBloggerTapeRoute(
                                            bloggerAvatar: state
                                                    .tapeModel[currentIndex]
                                                    .blogger
                                                    ?.image ??
                                                '',
                                            bloggerId: state
                                                .tapeModel[currentIndex]
                                                .blogger!
                                                .id!,
                                            bloggerCreatedAt: state
                                                .tapeModel[currentIndex]
                                                .blogger!
                                                .createdAt!,
                                            bloggerName: state
                                                    .tapeModel[currentIndex]
                                                    .blogger
                                                    ?.nickName ??
                                                '',
                                            inSubscribe: state
                                                    .tapeModel[currentIndex]
                                                    .inSubscribe ??
                                                false,
                                            onSubChanged: (value) {
                                              BlocProvider.of<
                                                      tapeCubit
                                                      .TapeCubit>(context)
                                                  .updateTapeByIndex(
                                                      index: currentIndex,
                                                      updatedTape: state
                                                          .tapeModel[
                                                              currentIndex]
                                                          .copyWith(
                                                              tapeId: state
                                                                  .tapeModel[
                                                                      currentIndex]
                                                                  .tapeId,
                                                              inSubscribe:
                                                                  value));
                                            },
                                          ))
                                              .whenComplete(() {
                                            stop = false;
                                            BlocProvider.of<
                                                    tapeCubit
                                                    .TapeCubit>(context)
                                                .toLoadedState();
                                            setState(() {});
                                          });
                                          stop = true;
                                        },
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(
                                                    30), // Slightly smaller than container
                                                child: Image.network(
                                                  height: 40,
                                                  width: 40,
                                                  state.tapeModel[currentIndex]
                                                              .blogger?.image !=
                                                          null
                                                      ? "https://lunamarket.ru/storage/${state.tapeModel[currentIndex].blogger?.image}"
                                                      : "https://lunamarket.ru/storage/banners/2.png",
                                                  fit: BoxFit.cover,
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress == null)
                                                      return child;
                                                    return Container(
                                                      color: Colors.grey[100],
                                                      child: Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes!
                                                              : null,
                                                          strokeWidth: 2,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Container(
                                                    color: Colors.grey[100],
                                                    child: const Icon(
                                                        Icons.broken_image,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              SizedBox(
                                                width: 100,
                                                child: Text(
                                                  '${state.tapeModel[currentIndex].blogger?.nickName}',
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              BlocBuilder<tapeCubit.TapeCubit,
                                                  tapeState.TapeState>(
                                                builder: (context, state) {
                                                  if (state is tapeState
                                                      .LoadedState) {
                                                    return BlocConsumer<
                                                        TapeCheckCubit,
                                                        TapeCheckState>(
                                                      listener: (context,
                                                          stateCheck) {
                                                        if (stateCheck
                                                            is LoadedState) {
                                                          BlocProvider.of<tapeCubit.TapeCubit>(context).updateTapeByIndex(
                                                              index:
                                                                  currentIndex,
                                                              updatedTape: state.tapeModel[currentIndex].copyWith(
                                                                  tapeId: state
                                                                      .tapeModel[
                                                                          currentIndex]
                                                                      .tapeId,
                                                                  inBasket: stateCheck
                                                                      .tapeCheckModel
                                                                      .inBasket,
                                                                  inSubscribe:
                                                                      stateCheck
                                                                          .tapeCheckModel
                                                                          .inSubs));
                                                        }
                                                      },
                                                      builder: (context,
                                                              stateCheck) =>
                                                          GestureDetector(
                                                        onTap: () async {
                                                          // if (GetStorage().read('title_tape').toString() ==
                                                          //     'Отписаться') {
                                                          //   GetStorage().write('title_tape', 'Подписаться');
                                                          // } else {
                                                          //   GetStorage().write('title_tape', 'Отписаться');
                                                          // }

                                                          BlocProvider.of<
                                                                      SubsCubit>(
                                                                  context)
                                                              .sub(state
                                                                  .tapeModel[
                                                                      currentIndex]
                                                                  .blogger
                                                                  ?.id
                                                                  .toString());

                                                          BlocProvider.of<tapeCubit.TapeCubit>(context).update(
                                                              state.tapeModel[
                                                                  currentIndex],
                                                              currentIndex,
                                                              !(state
                                                                      .tapeModel[
                                                                          currentIndex]
                                                                      .inSubscribe ??
                                                                  true),
                                                              state
                                                                  .tapeModel[
                                                                      currentIndex]
                                                                  .inBasket,
                                                              state
                                                                  .tapeModel[
                                                                      currentIndex]
                                                                  .inFavorite,
                                                              state
                                                                      .tapeModel[
                                                                          currentIndex]
                                                                      .inReport ??
                                                                  false);

                                                          setState(() {
                                                            // inSub = !(state.tapeModel[currentIndex].inSubscribe ??
                                                            //     true);
                                                          });
                                                        },
                                                        child: Container(
                                                          height: 26,
                                                          width: 98,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .tapeColorGray,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Text(
                                                            stateCheck
                                                                    is LoadingState
                                                                ? ''
                                                                : state.tapeModel[currentIndex]
                                                                            .inSubscribe ==
                                                                        true
                                                                    ? 'Отписаться'
                                                                    : 'Подписаться',
                                                            style: const TextStyle(
                                                                color: AppColors
                                                                    .kWhite,
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                  return const SizedBox();
                                                },
                                              ),
                                              Spacer(),
                                              inReport(
                                                tape: state.tapeModel[index],
                                                index: index,
                                              ),
                                              SizedBox(width: 4),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Container(
                                                    height: 28,
                                                    width: 28,
                                                    color:
                                                        AppColors.tapeColorGray,
                                                    child: Icon(
                                                      Icons.close,
                                                      size: 22,
                                                      color: AppColors.kWhite,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 16),
                                            ],
                                          ),
                                        ))
                                    : const SizedBox();
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 90,
                          right: 0,
                          left: 0,
                          child: Container(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.327),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          context.router
                                              .push(ProfileSellerTapeRoute(
                                            chatId:
                                                state.tapeModel[index].chatId ??
                                                    0,
                                            sellerAvatar: state
                                                    .tapeModel[currentIndex]
                                                    .shop
                                                    ?.image ??
                                                '',
                                            sellerId: state
                                                .tapeModel[currentIndex]
                                                .shop!
                                                .id!,
                                            sellerCreatedAt: state
                                                .tapeModel[currentIndex]
                                                .shop!
                                                .createdAt!,
                                            sellerName: state
                                                    .tapeModel[currentIndex]
                                                    .shop
                                                    ?.name ??
                                                '',
                                            inSubscribe: state
                                                    .tapeModel[currentIndex]
                                                    .inSubscribe ??
                                                false,
                                            onSubChanged: (value) {
                                              BlocProvider.of<
                                                      tapeCubit
                                                      .TapeCubit>(context)
                                                  .updateTapeByIndex(
                                                      index: currentIndex,
                                                      updatedTape: state
                                                          .tapeModel[
                                                              currentIndex]
                                                          .copyWith(
                                                              tapeId: state
                                                                  .tapeModel[
                                                                      currentIndex]
                                                                  .tapeId,
                                                              inSubscribe:
                                                                  value));
                                            },
                                          ))
                                              .whenComplete(() {
                                            stop = false;
                                            BlocProvider.of<
                                                    tapeCubit
                                                    .TapeCubit>(context)
                                                .toLoadedState();
                                            setState(() {});
                                          });
                                          stop = true;
                                        },
                                        child: SizedBox(
                                          height: 50,
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(
                                                    30), // Slightly smaller than container
                                                child: Image.network(
                                                  height: 40,
                                                  width: 40,
                                                  state.tapeModel[currentIndex]
                                                              .shop?.image !=
                                                          null
                                                      ? "https://lunamarket.ru/storage/${state.tapeModel[currentIndex].shop?.image}"
                                                      : "https://lunamarket.ru/storage/banners/2.png",
                                                  fit: BoxFit.cover,
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress == null)
                                                      return child;
                                                    return Container(
                                                      color: Colors.grey[100],
                                                      child: Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes!
                                                              : null,
                                                          strokeWidth: 2,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  errorBuilder: (context, error,
                                                          stackTrace) =>
                                                      Container(
                                                    color: Colors.grey[100],
                                                    child: const Icon(
                                                        Icons.broken_image,
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                child: Container(
                                                  height: 20,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin: Alignment
                                                            .bottomRight,
                                                        end: Alignment.topRight,
                                                        transform:
                                                            GradientRotation(
                                                                4.2373),
                                                        colors: [
                                                          Color(0xFFAD32F8),
                                                          Color(0xFF3275F8),
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Center(
                                                    child: SizedBox(
                                                      height: 11,
                                                      width: 11,
                                                      child: Image.asset(
                                                        Assets
                                                            .icons
                                                            .sellerNavigationUnfullIcon
                                                            .path,
                                                        color: AppColors.kWhite,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Column(children: [
                                          Image.asset(
                                            Assets.icons.likeIcon.path,
                                            color: Colors.white,
                                            scale: 1.9,
                                          ),
                                          Text(
                                            ' ${state.tapeModel[index].count}',
                                            style: AppTextStyles.size16Weight400
                                                .copyWith(
                                                    color: AppColors.kWhite),
                                          ),
                                        ]),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      inFavorites(
                                        tape: state.tapeModel[index],
                                        index: index,
                                        isBlogger: false,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await Share.share(
                                              "$kDeepLinkUrl/?index\u003d${widget.index}&shop_name\u003d${widget.shopName}");
                                        },
                                        child: Column(children: [
                                          Image.asset(
                                            Assets.icons.sendIcon.path,
                                            color: Colors.white,
                                            scale: 1.9,
                                          ),
                                          Text(
                                            ' ${state.tapeModel[index].count}',
                                            style: AppTextStyles.size16Weight400
                                                .copyWith(
                                                    color: AppColors.kWhite),
                                          ),
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: AppColors.kWhite,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: SizedBox(
                                    width: 358,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 54,
                                            width: 56,
                                            decoration: BoxDecoration(
                                              color: AppColors.kWhite,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.05),
                                                  blurRadius: 8,
                                                  spreadRadius: 2,
                                                ),
                                              ],
                                            ),
                                            padding: const EdgeInsets.all(
                                                5), // White border effect
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                  12), // Slightly smaller than container
                                              child: Image.asset(
                                                Assets.images.aboutImage.path,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${state.tapeModel[index].name}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: AppTextStyles
                                                      .catalogTextStyle,
                                                ),
                                                state.tapeModel[index]
                                                            .compound !=
                                                        0
                                                    ? Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            // width: 75,
                                                            child: Text(
                                                              '${formatPrice(compoundPrice)} ₽ ',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  letterSpacing:
                                                                      0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                          Text(
                                                            '${formatPrice(state.tapeModel[index].price!)} ₽ ',
                                                            style:
                                                                const TextStyle(
                                                              color: AppColors
                                                                  .kGray300,
                                                              letterSpacing: -1,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              decorationColor:
                                                                  AppColors
                                                                      .kGray300,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Text(
                                                        '${formatPrice(state.tapeModel[index].price!)} ₽ ',
                                                        style: const TextStyle(
                                                          color: AppColors
                                                              .kGray900,
                                                          letterSpacing: 0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          inBaskets(
                                            tape: state.tapeModel[index],
                                            index: index,
                                            isBlogger: true,
                                          )
                                          // Image.asset(
                                          //     Assets.icons.tapeBasketIcon.path)
                                        ]),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              }
              if (state is tapeState.BloggerLoadedState) {
                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  controller: controller,
                  itemCount: state.tapeModel.length,
                  onPageChanged: (value) {
                    currentIndex = value;
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    // inFavorite = state.tapeModel[index].inFavorite;
                    // inBasket = state.tapeModel[index].inBasket;
                    return Stack(
                      children: [
                        //VideoPlayer(_controller!)5,
                        Videos(
                          tape: state.tapeModel[index],
                          stop: stop,
                        ),
                        // Image.network(
                        //   'http://80.87.202.73:8001/storage/${widget.tape.image}',
                        //   fit: BoxFit.cover,
                        //   height: double.infinity,
                        //   width: double.infinity,
                        //   alignment: Alignment.center,
                        // ),

                        Container(
                          margin: EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: MediaQuery.of(context).size.height * 0.12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 61,
                                height: 28,
                                decoration: BoxDecoration(
                                    color: AppColors.kPrimaryColor,
                                    borderRadius: BorderRadius.circular(6)),
                                // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.19),
                                alignment: Alignment.center,
                                child: const Text(
                                  '0·0·12',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                              state.tapeModel[index].point != 0
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      // padding: const EdgeInsets.only(
                                      //     left: 4, right: 4, bottom: 2, top: 2),
                                      margin: const EdgeInsets.only(top: 10),
                                      width: 56,
                                      height: 28,
                                      // margin: const EdgeInsets.only(top: 4),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        '10% Б',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                    )
                                  : const SizedBox(
                                      height: 28,
                                    ),

                              state.tapeModel[index].compound != 0
                                  ? Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      // padding: const EdgeInsets.only(
                                      //     left: 4, right: 4, bottom: 2, top: 2),
                                      // margin: const EdgeInsets.only(top: 370),
                                      width: 48,
                                      height: 28,
                                      margin: const EdgeInsets.only(top: 4),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '-${state.tapeModel[index].compound}%',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                    )
                                  : const SizedBox(
                                      height: 28,
                                    ),

                              // Container(
                              //   width: 49,
                              //   height: 28,
                              //   decoration: BoxDecoration(
                              //       color: const Color(0xFFFF3347), borderRadius: BorderRadius.circular(6)),
                              //   margin: EdgeInsets.only(
                              //     top: MediaQuery.of(context).size.height * 0.15,
                              //   ),
                              //   alignment: Alignment.center,
                              //   child: Text(
                              //     '-${state.tapeModel[index].compound}%',
                              //     style:
                              //         const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
                              //   ),
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.30),
                                    child: Column(
                                      children: [
                                        inReport(
                                          tape: state.tapeModel[index],
                                          index: index,
                                          isBlogger: true,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        inBaskets(
                                          tape: state.tapeModel[index],
                                          index: index,
                                          isBlogger: true,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        inFavorites(
                                          tape: state.tapeModel[index],
                                          index: index,
                                          isBlogger: true,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            await Share.share(
                                                "$kDeepLinkUrl/?index\u003d${widget.index}&shop_name\u003d${widget.shopName}");
                                          },
                                          child: SvgPicture.asset(
                                            'assets/icons/share.svg',
                                            height: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 14,
                              ),
                              SizedBox(
                                //width: 358,
                                height: 30,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // if (state.tapeModel[index].blogger != null)
                                    //   GestureDetector(
                                    //     onTap: () {
                                    //       BlocProvider.of<NavigationCubit>(context).emit(DetailBloggerTapeState(
                                    //           state.tapeModel[index].blogger!.id!,
                                    //           state.tapeModel[index].blogger?.nickName ?? '',
                                    //           state.tapeModel[index].blogger?.image ?? ''));
                                    //     },
                                    //     child: Row(
                                    //       children: [
                                    //         ClipRRect(
                                    //           borderRadius: BorderRadius.circular(5),
                                    //           child: state.tapeModel[index].blogger?.image != null
                                    //               ? Image.network(
                                    //                   'https://lunamarket.ru/storage/${state.tapeModel[index].blogger?.image}',
                                    //                   height: 30.6,
                                    //                   width: 30.6,
                                    //                 )
                                    //               : const Icon(Icons.person),
                                    //         ),
                                    //         const SizedBox(
                                    //           width: 8,
                                    //         ),
                                    //         Text(
                                    //           '${state.tapeModel[index].blogger?.nickName}',
                                    //           style: const TextStyle(
                                    //               color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                                    //         )
                                    //       ],
                                    //     ),
                                    //   )
                                    // else
                                    GestureDetector(
                                      onTap: (() {
                                        final List<int> selectedListSort = [];

                                        selectedListSort.add(
                                            state.tapeModel[index].shop!.id!);
                                        GetStorage().write('shopFilterId',
                                            selectedListSort.toString());

                                        context.router.push(ProductsRoute(
                                          cats: CatsModel(id: 0, name: ''),
                                          shopId: state
                                              .tapeModel[index].shop!.id
                                              .toString(),
                                        ));
                                      }),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Image.network(
                                              'https://lunamarket.ru/storage/${state.tapeModel[index].shop!.image}',
                                              height: 30.6,
                                              width: 30.6,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  const ErrorImageWidget(
                                                height: 30.6,
                                                width: 30.6,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            '${state.tapeModel[index].shop!.name}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        // inSubs(
                                        //   tape: state.tapeModel[index],
                                        //   index: index,
                                        // ),
                                        // SvgPicture.asset(
                                        //   'assets/icons/notification.svg',
                                        //   color: Colors.white,
                                        // ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            // Get.off(ChatPage);
                                            GetStorage()
                                                .write('video_stop', true);

                                            // if (state.tapeModel[index].chatId ==
                                            //     null) {
                                            Get.to(MessagePage(
                                                userId: state
                                                    .tapeModel[index].shop!.id,
                                                name: state.tapeModel[index]
                                                    .shop!.name,
                                                avatar: state.tapeModel[index]
                                                    .shop!.image,
                                                chatId: state
                                                    .tapeModel[index].chatId));
                                            // } else {
                                            //   Get.to(() => const ChatPage());
                                            // }

                                            // Get.to(ProductsPage(
                                            //   cats: Cats(id: 0, name: ''),
                                            // ));
                                            // GetStorage()
                                            //     .write('shopFilterId', 1);
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 108,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            // padding: const EdgeInsets.only(
                                            //     left: 8,
                                            //     right: 8,
                                            //     top: 4,
                                            //     bottom: 4),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'Написать',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 7.4,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 40,
                                child: Text(
                                  '${state.tapeModel[index].name}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              // Text(
                              //   'Артикул: ${state.tapeModel[index].id}',
                              //   style: const TextStyle(
                              //       fontSize: 12,
                              //       fontWeight: FontWeight.w500,
                              //       color: Colors.white),
                              // ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                // width: 358,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${(state.tapeModel[index].price!.toInt() - ((state.tapeModel[index].price! / 100) * state.tapeModel[index].compound!).toInt())} ₽ ',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          '${state.tapeModel[index].price} ₽',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'в рассрочку',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                4,
                                              ),
                                              color: const Color(
                                                0x30FFFFFF,
                                              )),
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                            top: 4,
                                            bottom: 4,
                                          ),
                                          child: Text(
                                            '${(state.tapeModel[index].price!.toInt() - ((state.tapeModel[index].price! / 100) * state.tapeModel[index].compound!).toInt()) ~/ 3}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        const Text(
                                          'х3',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                );
              } else {
                return const Center(
                    child:
                        CircularProgressIndicator(color: Colors.indigoAccent));
              }
            }));
  }
}

class Videos extends StatefulWidget {
  final TapeModel tape;
  final bool? stop;
  const Videos({required this.tape, super.key, this.stop});

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  VideoPlayerController? _controller;
  bool icon = true;

  Function? videoStop;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        "https://lunamarket.ru/storage/${widget.tape.video}")
      ..initialize().then((_) {
        if (widget.stop == true) {
          _controller!.pause();
        } else {
          _controller!.play();
        }
        setState(() {});
      });

    _controller!.addListener(() {
      _controller!.value.isPlaying == true ? icon = false : icon = true;

      setState(() {});
    });

    videoStop = GetStorage().listenKey('video_stop', (value) {
      if (value == true) {
        _controller!.pause();
      }
    });

    BlocProvider.of<tapeCubit.TapeCubit>(context).view(widget.tape.tapeId!);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    videoStop?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller!.value.isInitialized
        ? Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox.expand(
                child: FittedBox(
                  alignment: Alignment.center,
                  fit: BoxFit.fitWidth,
                  child: GestureDetector(
                      onTap: () {
                        _controller!.value.isPlaying
                            ? _controller!.pause()
                            : _controller!.play();
                      },
                      child: SizedBox(
                          height: _controller?.value.size.height,
                          width: _controller?.value.size.width,
                          child: AspectRatio(
                              aspectRatio: _controller!.value.aspectRatio,
                              child: VisibilityDetector(
                                  key: ObjectKey(_controller),
                                  onVisibilityChanged: (info) {
                                    if (!mounted) return;
                                    if (info.visibleFraction == 0) {
                                      _controller
                                          ?.pause(); //pausing  functionality
                                    } else {
                                      _controller?.play();
                                    }
                                  },
                                  child: VideoPlayer(_controller!))))),
                ),
              ),
              icon
                  ? GestureDetector(
                      onTap: () {
                        _controller!.value.isPlaying
                            ? _controller!.pause()
                            : _controller!.play();
                      },
                      child: Center(
                          child: SvgPicture.asset(
                        Assets.icons.playTape.path,
                        color: AppColors.mainPurpleColor,
                      )),
                    )
                  : SizedBox.shrink(),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.10),
                child:
                    VideoProgressIndicator(_controller!, allowScrubbing: true),
              ),
            ],
          )
        : const Center(
            child: CircularProgressIndicator(color: Colors.blueAccent));
  }
}

class inSubs extends StatefulWidget {
  final TapeModel tape;
  final int index;
  const inSubs({required this.tape, required this.index, super.key});

  @override
  State<inSubs> createState() => _inSubsState();
}

class _inSubsState extends State<inSubs> {
  bool? inSub;

  @override
  void initState() {
    inSub = widget.tape.inSubscribe;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        BlocProvider.of<SubsCubit>(context)
            .sub(widget.tape.shop!.id.toString());

        //widget.tape.inSubscribe = false;
        BlocProvider.of<tapeCubit.TapeCubit>(context).update(
          widget.tape,
          widget.index,
          !inSub!,
          widget.tape.inBasket,
          widget.tape.inFavorite,
          widget.tape.inReport,
        );

        setState(() {
          inSub = !inSub!;
        });
      },
      child: SvgPicture.asset(
        inSub != true
            ? 'assets/icons/notification.svg'
            : 'assets/icons/notification2.svg',
        height: 20,
        width: 20,
        color: Colors.white,
      ),
    );
  }
}

class inFavorites extends StatefulWidget {
  final TapeModel tape;
  final int index;
  final bool isBlogger;
  const inFavorites(
      {required this.tape,
      required this.index,
      super.key,
      required this.isBlogger});

  @override
  State<inFavorites> createState() => _inFavoritesState();
}

class _inFavoritesState extends State<inFavorites> {
  bool? inFavorite;

  @override
  void initState() {
    inFavorite = widget.tape.inFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final favorite = BlocProvider.of<favCubit.FavoriteCubit>(context);
        await favorite.favoriteTape(widget.tape.tapeId.toString());
        BlocProvider.of<tapeCubit.TapeCubit>(context).update(
            widget.tape,
            widget.index,
            widget.tape.inSubscribe,
            widget.tape.inBasket,
            !inFavorite!,
            widget.tape.inReport,
            isBlogger: widget.isBlogger);

        inFavorite = !inFavorite!;

        setState(() {});
      },
      child: Column(children: [
        Image.asset(
          inFavorite == false
              ? Assets.icons.favoriteIcon.path
              : Assets.icons.favoriteFullIcon.path,
          scale: 1.9,
          colorBlendMode: BlendMode.colorDodge,
        ),
        Text(
          ' ${inFavorite == false ? widget.tape.count : (widget.tape.count! + 1)}',
          style:
              AppTextStyles.size16Weight400.copyWith(color: AppColors.kWhite),
        ),
      ]),
    );
  }
}

class inBaskets extends StatefulWidget {
  final TapeModel tape;
  final int index;
  final bool isBlogger;
  const inBaskets(
      {required this.tape,
      required this.index,
      super.key,
      this.isBlogger = false});

  @override
  State<inBaskets> createState() => _inBasketsState();
}

class _inBasketsState extends State<inBaskets> {
  bool? inBasket;

  @override
  void initState() {
    inBasket = widget.tape.inBasket;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<tapeCubit.TapeCubit, tapeState.TapeState>(
      builder: (context, state) {
        if (state is tapeState.LoadedState) {
          return SizedBox(
            height: 46,
            width: 46,
            child: GestureDetector(
              onTap: () {
                if (state.tapeModel.isNotEmpty &&
                    widget.index < state.tapeModel.length) {
                  print('ok');
                } else {
                  return;
                }
                if (widget.tape.count == 0 && widget.tape.preOrder == 1) {
                  showCupertinoModalPopup<void>(
                      context: context,
                      builder: (context) => PreOrderDialog(onYesTap: () {
                            state.tapeModel[widget.index].inBasket == false
                                ? BlocProvider.of<basCubit.BasketCubit>(context)
                                    .basketAdd(widget.tape.id.toString(), '1',
                                        0, '', '',
                                        blogger_id: widget.tape.blogger?.id
                                                .toString() ??
                                            '0')
                                : BlocProvider.of<basCubit.BasketCubit>(context)
                                    .basketMinus(widget.tape.id.toString(), '1',
                                        0, 'fbs');

                            BlocProvider.of<tapeCubit.TapeCubit>(context)
                                .update(
                                    widget.tape,
                                    widget.index,
                                    widget.tape.inSubscribe,
                                    !state.tapeModel[widget.index].inBasket!,
                                    widget.tape.inFavorite,
                                    widget.tape.inReport,
                                    isBlogger: widget.isBlogger);
                            setState(
                              () {
                                inBasket = !inBasket!;
                              },
                            );

                            Get.back();
                          }));
                } else if (widget.tape.count == 0) {
                  showCupertinoModalPopup<void>(
                      context: context,
                      builder: (context) => CountZeroDialog(onYesTap: () {
                            state.tapeModel[widget.index].inBasket == false
                                ? BlocProvider.of<basCubit.BasketCubit>(context)
                                    .basketAdd(widget.tape.id.toString(), '1',
                                        0, '', '',
                                        blogger_id: widget.tape.blogger?.id
                                                .toString() ??
                                            '0')
                                : BlocProvider.of<basCubit.BasketCubit>(context)
                                    .basketMinus(widget.tape.id.toString(), '1',
                                        0, 'fbs');

                            BlocProvider.of<tapeCubit.TapeCubit>(context)
                                .update(
                                    widget.tape,
                                    widget.index,
                                    widget.tape.inSubscribe,
                                    !state.tapeModel[widget.index].inBasket!,
                                    widget.tape.inFavorite,
                                    widget.tape.inReport,
                                    isBlogger: widget.isBlogger);
                            setState(
                              () {
                                inBasket = !inBasket!;
                              },
                            );
                          }));
                } else {
                  state.tapeModel[widget.index].inBasket == false
                      ? BlocProvider.of<basCubit.BasketCubit>(context)
                          .basketAdd(widget.tape.id.toString(), '1', 0, '', '',
                              blogger_id:
                                  widget.tape.blogger?.id.toString() ?? '0')
                      : BlocProvider.of<basCubit.BasketCubit>(context)
                          .basketMinus(
                              widget.tape.id.toString(), '1', 0, 'fbs');

                  BlocProvider.of<tapeCubit.TapeCubit>(context).update(
                      widget.tape,
                      widget.index,
                      widget.tape.inSubscribe,
                      !state.tapeModel[widget.index].inBasket!,
                      widget.tape.inFavorite,
                      widget.tape.inReport,
                      isBlogger: false);
                  setState(
                    () {
                      inBasket = !inBasket!;
                    },
                  );

                  // Get.back();

                  // this.context.router.pushAndPopUntil(
                  //       const LauncherRoute(children: [BasketRoute()]),
                  //       predicate: (route) => false,
                  //     );
                }
              },
              child: Stack(children: [
                Image.asset(
                  Assets.icons.tapeBasketIcon.path,
                  height: 46,
                  width: 36,
                ),
                state.tapeModel[widget.index].inBasket != true
                    ? Positioned(
                        top: 0,
                        right: 0,
                        child: Image.asset(
                          Assets.icons.doneInBasketIcon.path,
                          scale: 1.5,
                        ),
                      )
                    : SizedBox.shrink()
              ]),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              inBasket == false
                  ? BlocProvider.of<basCubit.BasketCubit>(context).basketAdd(
                      widget.tape.id.toString(), '1', 0, '', '',
                      blogger_id: widget.tape.blogger?.id.toString() ?? '0')
                  : BlocProvider.of<basCubit.BasketCubit>(context)
                      .basketMinus(widget.tape.id.toString(), '1', 0, 'fbs');

              BlocProvider.of<tapeCubit.TapeCubit>(context).update(
                  widget.tape,
                  widget.index,
                  widget.tape.inSubscribe,
                  !inBasket!,
                  widget.tape.inFavorite,
                  widget.tape.inReport,
                  isBlogger: widget.isBlogger);
              setState(
                () {
                  inBasket = !inBasket!;
                },
              );
            },
            child: SvgPicture.asset(
              inBasket != true
                  ? 'assets/icons/shop_cart.svg'
                  : 'assets/icons/shop_cart_white.svg',
              height: inBasket != true ? 30 : 25,
              //  color: inBasket == true ? const Color.fromRGBO(255, 50, 72, 1) : null,
            ),
          );
        }
      },
    );
  }
}

class inReport extends StatefulWidget {
  final TapeModel tape;
  final int index;
  final bool isBlogger;
  const inReport(
      {required this.tape,
      required this.index,
      super.key,
      this.isBlogger = false});

  @override
  State<inReport> createState() => _inReportState();
}

class _inReportState extends State<inReport> {
  bool? inReport;

  @override
  void initState() {
    inReport = widget.tape.inBasket;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showAlertTapeWidget(context);

        BlocProvider.of<tapeCubit.TapeCubit>(context).update(
          widget.tape,
          widget.index,
          widget.tape.inSubscribe,
          widget.tape.inBasket,
          widget.tape.inFavorite,
          !inReport!,
          isBlogger: widget.isBlogger,
        );
        setState(() {
          inReport = !inReport!;
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 28,
          width: 28,
          color: AppColors.tapeColorGray,
          child: Icon(
            Icons.more_vert,
            color: AppColors.kWhite,
            size: 16,
          ),
        ),
      ),
    );
  }
}

Future<dynamic> showAlertTapeWidget(BuildContext context) async {
  return showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoActionSheet(
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text(
            'Жестокое обращение с детьми',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context, 'Two');
            Get.snackbar('Report Success', "Жестокое обращение с детьми",
                backgroundColor: AppColors.kPrimaryColor);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Спам',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context, 'Two');
            Get.snackbar('Report Success', "Спам",
                backgroundColor: AppColors.kPrimaryColor);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Вредные или опасные действия',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context, 'Two');
            Get.snackbar('Report Success', "Вредные или опасные действия",
                backgroundColor: AppColors.kPrimaryColor);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Жестокое или отталкивающее содержание',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context, 'Two');
            Get.snackbar(
                'Report Success', "Жестокое или отталкивающее содержание",
                backgroundColor: AppColors.kPrimaryColor);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Дискриминационные высказывание и оскорбления',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context, 'Two');
            Get.snackbar('Report Success',
                "Дискриминационные высказывание и оскорбления",
                backgroundColor: AppColors.kPrimaryColor);
          },
        ),
        // CupertinoActionSheetAction(
        //   child: const Text(
        //     'Пожаловаться',
        //     style: TextStyle(color: Colors.red),
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context, 'Two');
        //   },
        // ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text(
          'Отмена',
          style: TextStyle(
            color: AppColors.kPrimaryColor,
          ),
        ),
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
      ),
    ),
  );
}
