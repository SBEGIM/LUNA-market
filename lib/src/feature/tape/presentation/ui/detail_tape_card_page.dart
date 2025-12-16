import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/count_zero_dialog.dart';
import 'package:haji_market/src/feature/home/bloc/meta_cubit.dart';
import 'package:haji_market/src/feature/tape/bloc/tape_check_cubit.dart';
import 'package:haji_market/src/feature/tape/data/repository/tape_repository.dart';
import 'package:haji_market/src/feature/tape/presentation/widgets/show_report_widget.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/tape/bloc/subs_cubit.dart';
import 'package:haji_market/src/feature/tape/data/models/tape_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:visibility_detector/visibility_detector.dart';
//import 'package:video_player/video_player.dart';
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
  const DetailTapeCardPage({
    required this.index,
    required this.shopName,
    Key? key,
    required this.tapeBloc,
    this.tapeId,
  }) : super(key: key);

  @override
  State<DetailTapeCardPage> createState() => _DetailTapeCardPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<tapeCubit.TapeCubit>.value(value: tapeBloc),
        BlocProvider(create: (context) => TapeCheckCubit(tapeRepository: TapeRepository())),
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
    var pp = (((price!.toInt() - compound!.toInt()) / price!.toInt()) * 100) as double;
    return pp.toInt();
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    if (widget.index != null) {
      currentIndex = widget.index!;
      controller = PageController(initialPage: widget.index!);
    }
    final tape = BlocProvider.of<tapeCubit.TapeCubit>(context);
    if (tape.state is tapeState.LoadedState) {
      if ((tape.state as tapeState.LoadedState).tapeModel[currentIndex].tapeId != null) {
        BlocProvider.of<TapeCheckCubit>(
          context,
        ).tapeCheck(tapeId: (tape.state as tapeState.LoadedState).tapeModel[currentIndex].tapeId!);
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
  void dispose() {
    // Возвращаем панели, когда выходим со страницы
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark, // белые иконки в статус-баре (если он появится)
      child: Scaffold(
        //extendBody: true,
        extendBodyBehindAppBar: true,
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
              return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
            }

            if (state is tapeState.LoadedState) {
              return PageView.builder(
                scrollDirection: Axis.vertical,
                controller: controller,
                itemCount: state.tapeModel.length,
                onPageChanged: (value) {
                  currentIndex = value;
                  if (state.tapeModel[value].tapeId != null) {
                    BlocProvider.of<TapeCheckCubit>(
                      context,
                    ).tapeCheck(tapeId: state.tapeModel[value].tapeId!);
                  }
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Videos(tape: state.tapeModel[index]),
                      Positioned(
                        top: 55,
                        left: 16,
                        right: 16,
                        child: BlocBuilder<tapeCubit.TapeCubit, tapeState.TapeState>(
                          builder: (context, state) {
                            if (state is tapeState.LoadedState) {
                              compoundPrice =
                                  (state.tapeModel[currentIndex].price!.toInt() *
                                          (((100 -
                                                  state.tapeModel[currentIndex].compound!
                                                      .toInt())) /
                                              100))
                                      .toInt();

                              return visible == true &&
                                      (state.tapeModel[currentIndex].blogger != null)
                                  ? GestureDetector(
                                      onTap: () {
                                        context.router
                                            .push(
                                              ProfileBloggerTapeRoute(
                                                bloggerAvatar:
                                                    state.tapeModel[currentIndex].blogger?.image ??
                                                    '',
                                                bloggerId:
                                                    state.tapeModel[currentIndex].blogger!.id!,
                                                bloggerCreatedAt: state
                                                    .tapeModel[currentIndex]
                                                    .blogger!
                                                    .createdAt!,
                                                bloggerName:
                                                    state
                                                        .tapeModel[currentIndex]
                                                        .blogger
                                                        ?.nickName ??
                                                    '',
                                                inSubscribe:
                                                    state.tapeModel[currentIndex].inSubscribe ??
                                                    false,
                                                onSubChanged: (value) {
                                                  BlocProvider.of<tapeCubit.TapeCubit>(
                                                    context,
                                                  ).updateTapeByIndex(
                                                    index: currentIndex,
                                                    updatedTape: state.tapeModel[currentIndex]
                                                        .copyWith(
                                                          tapeId:
                                                              state.tapeModel[currentIndex].tapeId,
                                                          inSubscribe: value,
                                                        ),
                                                  );
                                                },
                                              ),
                                            )
                                            .whenComplete(() {
                                              stop = false;
                                              BlocProvider.of<tapeCubit.TapeCubit>(
                                                context,
                                              ).toLoadedState();
                                              setState(() {});
                                            });
                                        stop = true;
                                      },
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(30),
                                              child: Image.network(
                                                state.tapeModel[currentIndex].blogger?.image != null
                                                    ? "https://lunamarket.ru/storage/${state.tapeModel[currentIndex].blogger?.image}"
                                                    : "https://lunamarket.ru/storage/banners/2.png",
                                                height: 40,
                                                width: 40,
                                                fit: BoxFit.cover,
                                                // loadingBuilder / errorBuilder — как у тебя
                                              ),
                                            ),

                                            const SizedBox(width: 8),

                                            // Имя блогера — занимает всё оставшееся пространство
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 65,
                                                    child: Text(
                                                      '${state.tapeModel[currentIndex].blogger?.nickName}',
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  BlocBuilder<
                                                    tapeCubit.TapeCubit,
                                                    tapeState.TapeState
                                                  >(
                                                    builder: (context, state) {
                                                      if (state is tapeState.LoadedState) {
                                                        return BlocConsumer<
                                                          TapeCheckCubit,
                                                          TapeCheckState
                                                        >(
                                                          listener: (context, stateCheck) {
                                                            if (stateCheck is LoadedState) {
                                                              BlocProvider.of<tapeCubit.TapeCubit>(
                                                                context,
                                                              ).update(
                                                                state.tapeModel[currentIndex],
                                                                currentIndex,
                                                                stateCheck.tapeCheckModel.inSubs,
                                                                stateCheck.tapeCheckModel.inBasket,
                                                                stateCheck
                                                                    .tapeCheckModel
                                                                    .inFavorite,
                                                                state
                                                                    .tapeModel[currentIndex]
                                                                    .inReport,
                                                                stateCheck.tapeCheckModel.isLiked,
                                                                state
                                                                        .tapeModel[index]
                                                                        .statistics
                                                                        ?.like ??
                                                                    0,
                                                                state
                                                                        .tapeModel[index]
                                                                        .statistics
                                                                        ?.favorite ??
                                                                    0,
                                                                state
                                                                        .tapeModel[currentIndex]
                                                                        .statistics
                                                                        ?.send ??
                                                                    0,
                                                              );

                                                              BlocProvider.of<tapeCubit.TapeCubit>(
                                                                context,
                                                              ).updateTapeByIndex(
                                                                index: currentIndex,
                                                                updatedTape: state
                                                                    .tapeModel[currentIndex]
                                                                    .copyWith(
                                                                      tapeId: state
                                                                          .tapeModel[currentIndex]
                                                                          .tapeId,
                                                                      inBasket: stateCheck
                                                                          .tapeCheckModel
                                                                          .inBasket,
                                                                      inSubscribe: stateCheck
                                                                          .tapeCheckModel
                                                                          .inSubs,
                                                                      inFavorite: stateCheck
                                                                          .tapeCheckModel
                                                                          .inFavorite,
                                                                      isLiked: stateCheck
                                                                          .tapeCheckModel
                                                                          .isLiked,
                                                                    ),
                                                              );
                                                            }
                                                          },
                                                          builder: (context, stateCheck) {
                                                            final title = stateCheck is LoadingState
                                                                ? ''
                                                                : (state
                                                                              .tapeModel[currentIndex]
                                                                              .inSubscribe ==
                                                                          true
                                                                      ? 'Вы подписаны'
                                                                      : 'Подписаться');

                                                            return GestureDetector(
                                                              onTap: () {
                                                                BlocProvider.of<SubsCubit>(
                                                                  context,
                                                                ).sub(
                                                                  state
                                                                      .tapeModel[currentIndex]
                                                                      .blogger
                                                                      ?.id
                                                                      .toString(),
                                                                );
                                                                BlocProvider.of<tapeCubit.TapeCubit>(
                                                                  context,
                                                                ).update(
                                                                  state.tapeModel[currentIndex],
                                                                  currentIndex,
                                                                  !(state
                                                                          .tapeModel[currentIndex]
                                                                          .inSubscribe ??
                                                                      true),
                                                                  state
                                                                      .tapeModel[currentIndex]
                                                                      .inBasket,
                                                                  state
                                                                      .tapeModel[currentIndex]
                                                                      .inFavorite,
                                                                  state
                                                                          .tapeModel[currentIndex]
                                                                          .inReport ??
                                                                      false,
                                                                  state
                                                                          .tapeModel[currentIndex]
                                                                          .isLiked ??
                                                                      false,
                                                                  state
                                                                          .tapeModel[index]
                                                                          .statistics
                                                                          ?.like ??
                                                                      0,
                                                                  state
                                                                          .tapeModel[index]
                                                                          .statistics
                                                                          ?.favorite ??
                                                                      0,
                                                                  state
                                                                          .tapeModel[currentIndex]
                                                                          .statistics
                                                                          ?.send ??
                                                                      0,
                                                                );
                                                                setState(() {});
                                                              },
                                                              child: Container(
                                                                height: 26,
                                                                padding: const EdgeInsets.symmetric(
                                                                  horizontal: 8,
                                                                ),
                                                                alignment: Alignment.center,
                                                                decoration: BoxDecoration(
                                                                  color: AppColors.tapeColorGray,
                                                                  borderRadius:
                                                                      BorderRadius.circular(8),
                                                                ),
                                                                child: Text(
                                                                  title,
                                                                  style: const TextStyle(
                                                                    color: AppColors.kWhite,
                                                                    fontSize: 12,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      }
                                                      return const SizedBox.shrink();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),

                                            inReport(tape: state.tapeModel[index], index: index),

                                            const SizedBox(width: 8),

                                            InkWell(
                                              onTap: () => Navigator.pop(context),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(15),
                                                child: Container(
                                                  height: 28,
                                                  width: 28,
                                                  color: AppColors.tapeColorGray,
                                                  child: const Icon(
                                                    Icons.close,
                                                    size: 22,
                                                    color: AppColors.kWhite,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox();
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        right: 16,
                        left: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.327,
                              ),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.router
                                          .push(
                                            ProfileSellerTapeRoute(
                                              chatId: state.tapeModel[index].chatId ?? 0,
                                              sellerAvatar:
                                                  state.tapeModel[currentIndex].shop?.image ?? '',
                                              sellerId: state.tapeModel[currentIndex].shop!.id!,
                                              sellerCreatedAt:
                                                  state.tapeModel[currentIndex].shop!.createdAt!,
                                              sellerName:
                                                  state.tapeModel[currentIndex].shop?.name ?? '',
                                              inSubscribe:
                                                  state.tapeModel[currentIndex].inSellerSubscribe ??
                                                  false,
                                              onSubChanged: (value) {
                                                BlocProvider.of<tapeCubit.TapeCubit>(
                                                  context,
                                                ).updateTapeByIndex(
                                                  index: currentIndex,
                                                  updatedTape: state.tapeModel[currentIndex]
                                                      .copyWith(
                                                        tapeId:
                                                            state.tapeModel[currentIndex].tapeId,
                                                        inSellerSubscribe: value,
                                                      ),
                                                );
                                              },
                                            ),
                                          )
                                          .whenComplete(() {
                                            stop = false;
                                            BlocProvider.of<tapeCubit.TapeCubit>(
                                              context,
                                            ).toLoadedState();
                                            setState(() {});
                                          });
                                      stop = true;
                                    },
                                    child: SizedBox(
                                      height: 52,
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ), // Slightly smaller than container
                                            child: Image.network(
                                              height: 40,
                                              width: 40,
                                              state.tapeModel[currentIndex].shop?.image != null
                                                  ? "https://lunamarket.ru/storage/${state.tapeModel[currentIndex].shop?.image}"
                                                  : "https://lunamarket.ru/storage/banners/2.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 3,
                                            right: 0,
                                            left: 0,
                                            child: Container(
                                              height: 20,
                                              width: 38,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  transform: GradientRotation(4.2373),
                                                  colors: [Color(0xFFAD32F8), Color(0xFF3275F8)],
                                                ),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(top: 4.5, bottom: 4.5),
                                                  child: Image.asset(
                                                    Assets.icons.sellerNavigationUnfullIcon.path,
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
                                  SizedBox(height: 17.5),
                                  isLike(
                                    tape: state.tapeModel[index],
                                    index: index,
                                    isBlogger: false,
                                  ),
                                  const SizedBox(height: 10),
                                  inFavorites(
                                    tape: state.tapeModel[index],
                                    index: index,
                                    isBlogger: false,
                                  ),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () async {
                                      await Share.share(
                                        "$kDeepLinkUrl/?index\u003d${widget.index}&shop_name\u003d${widget.shopName}",
                                      );

                                      BlocProvider.of<tapeCubit.TapeCubit>(context).update(
                                        state.tapeModel[index],
                                        index,
                                        state.tapeModel[index].inSubscribe,
                                        state.tapeModel[index].inBasket,
                                        state.tapeModel[index].inFavorite,
                                        state.tapeModel[index].inFavorite,
                                        state.tapeModel[index].isLiked,
                                        state.tapeModel[index].statistics?.like ?? 0,
                                        state.tapeModel[index].statistics?.favorite ?? 0,
                                        (state.tapeModel[index].statistics?.send ?? 0) + 1,
                                        isBlogger: false,
                                      );

                                      BlocProvider.of<tapeCubit.TapeCubit>(
                                        context,
                                      ).share(state.tapeModel[index].tapeId!);

                                      setState(() {});
                                    },
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          Assets.icons.sendIcon.path,
                                          color: Colors.white,
                                          scale: 1.9,
                                        ),
                                        Text(
                                          ' ${state.tapeModel[index].statistics?.send}',
                                          style: AppTextStyles.size16Weight400.copyWith(
                                            color: AppColors.kWhite,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 14),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              height: 70,
                              decoration: BoxDecoration(
                                color: AppColors.kWhite,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: SizedBox(
                                width: 358,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 54,
                                      width: 56,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(width: 0.7, color: Color(0xffEAECED)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.7),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            'https://lunamarket.ru/storage/${state.tapeModel[index].image}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${state.tapeModel[index].name}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: AppTextStyles.size14Weight600,
                                          ),
                                          state.tapeModel[index].compound != 0
                                              ? Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      // width: 75,
                                                      child: Text(
                                                        '${formatPrice(compoundPrice)} ₽ ',
                                                        style: AppTextStyles.size16Weight600,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${formatPrice(state.tapeModel[index].price!)} ₽ ',
                                                      style: AppTextStyles.size14Weight500.copyWith(
                                                        decoration: TextDecoration.lineThrough,
                                                        color: Color(0xff8E8E93),
                                                        decorationColor: Color(0xff8E8E93),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Text(
                                                  '${formatPrice(state.tapeModel[index].price!)} ₽ ',
                                                  style: AppTextStyles.size16Weight600,
                                                ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    inBaskets(
                                      tape: state.tapeModel[index],
                                      index: index,
                                      isBlogger: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
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
                  if (state.tapeModel[value].tapeId != null) {
                    BlocProvider.of<TapeCheckCubit>(
                      context,
                    ).tapeCheck(tapeId: state.tapeModel[value].tapeId!);
                  }
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Videos(tape: state.tapeModel[index]),
                      Positioned(
                        top: 85,
                        left: 16,
                        right: 16,
                        child: BlocBuilder<tapeCubit.TapeCubit, tapeState.TapeState>(
                          builder: (context, state) {
                            if (state is tapeState.LoadedState) {
                              compoundPrice =
                                  (state.tapeModel[currentIndex].price!.toInt() *
                                          (((100 -
                                                  state.tapeModel[currentIndex].compound!
                                                      .toInt())) /
                                              100))
                                      .toInt();

                              return visible == true &&
                                      (state.tapeModel[currentIndex].blogger != null)
                                  ? GestureDetector(
                                      onTap: () {
                                        context.router
                                            .push(
                                              ProfileBloggerTapeRoute(
                                                bloggerAvatar:
                                                    state.tapeModel[currentIndex].blogger?.image ??
                                                    '',
                                                bloggerId:
                                                    state.tapeModel[currentIndex].blogger!.id!,
                                                bloggerCreatedAt: state
                                                    .tapeModel[currentIndex]
                                                    .blogger!
                                                    .createdAt!,
                                                bloggerName:
                                                    state
                                                        .tapeModel[currentIndex]
                                                        .blogger
                                                        ?.nickName ??
                                                    '',
                                                inSubscribe:
                                                    state.tapeModel[currentIndex].inSubscribe ??
                                                    false,
                                                onSubChanged: (value) {
                                                  BlocProvider.of<tapeCubit.TapeCubit>(
                                                    context,
                                                  ).updateTapeByIndex(
                                                    index: currentIndex,
                                                    updatedTape: state.tapeModel[currentIndex]
                                                        .copyWith(
                                                          tapeId:
                                                              state.tapeModel[currentIndex].tapeId,
                                                          inSubscribe: value,
                                                        ),
                                                  );
                                                },
                                              ),
                                            )
                                            .whenComplete(() {
                                              stop = false;
                                              BlocProvider.of<tapeCubit.TapeCubit>(
                                                context,
                                              ).toLoadedState();
                                              setState(() {});
                                            });
                                        stop = true;
                                      },
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(30),
                                              child: Image.network(
                                                state.tapeModel[currentIndex].blogger?.image != null
                                                    ? "https://lunamarket.ru/storage/${state.tapeModel[currentIndex].blogger?.image}"
                                                    : "https://lunamarket.ru/storage/banners/2.png",
                                                height: 40,
                                                width: 40,
                                                fit: BoxFit.cover,
                                                // loadingBuilder / errorBuilder — как у тебя
                                              ),
                                            ),

                                            const SizedBox(width: 8),

                                            // Имя блогера — занимает всё оставшееся пространство
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 65,
                                                    child: Text(
                                                      '${state.tapeModel[currentIndex].blogger?.nickName}',
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  BlocBuilder<
                                                    tapeCubit.TapeCubit,
                                                    tapeState.TapeState
                                                  >(
                                                    builder: (context, state) {
                                                      if (state is tapeState.LoadedState) {
                                                        return BlocConsumer<
                                                          TapeCheckCubit,
                                                          TapeCheckState
                                                        >(
                                                          listener: (context, stateCheck) {
                                                            if (stateCheck is LoadedState) {
                                                              BlocProvider.of<tapeCubit.TapeCubit>(
                                                                context,
                                                              ).update(
                                                                state.tapeModel[currentIndex],
                                                                currentIndex,
                                                                stateCheck.tapeCheckModel.inSubs,
                                                                stateCheck.tapeCheckModel.inBasket,
                                                                stateCheck
                                                                    .tapeCheckModel
                                                                    .inFavorite,
                                                                state
                                                                    .tapeModel[currentIndex]
                                                                    .inReport,
                                                                stateCheck.tapeCheckModel.isLiked,
                                                                state
                                                                        .tapeModel[index]
                                                                        .statistics
                                                                        ?.like ??
                                                                    0,
                                                                state
                                                                        .tapeModel[index]
                                                                        .statistics
                                                                        ?.favorite ??
                                                                    0,
                                                                state
                                                                        .tapeModel[currentIndex]
                                                                        .statistics
                                                                        ?.send ??
                                                                    0,
                                                              );

                                                              BlocProvider.of<tapeCubit.TapeCubit>(
                                                                context,
                                                              ).updateTapeByIndex(
                                                                index: currentIndex,
                                                                updatedTape: state
                                                                    .tapeModel[currentIndex]
                                                                    .copyWith(
                                                                      tapeId: state
                                                                          .tapeModel[currentIndex]
                                                                          .tapeId,
                                                                      inBasket: stateCheck
                                                                          .tapeCheckModel
                                                                          .inBasket,
                                                                      inSubscribe: stateCheck
                                                                          .tapeCheckModel
                                                                          .inSubs,
                                                                      inFavorite: stateCheck
                                                                          .tapeCheckModel
                                                                          .inFavorite,
                                                                      isLiked: stateCheck
                                                                          .tapeCheckModel
                                                                          .isLiked,
                                                                    ),
                                                              );
                                                            }
                                                          },
                                                          builder: (context, stateCheck) {
                                                            final title = stateCheck is LoadingState
                                                                ? ''
                                                                : (state
                                                                              .tapeModel[currentIndex]
                                                                              .inSubscribe ==
                                                                          true
                                                                      ? 'Вы подписаны'
                                                                      : 'Подписаться');

                                                            return GestureDetector(
                                                              onTap: () {
                                                                BlocProvider.of<SubsCubit>(
                                                                  context,
                                                                ).sub(
                                                                  state
                                                                      .tapeModel[currentIndex]
                                                                      .blogger
                                                                      ?.id
                                                                      .toString(),
                                                                );
                                                                BlocProvider.of<tapeCubit.TapeCubit>(
                                                                  context,
                                                                ).update(
                                                                  state.tapeModel[currentIndex],
                                                                  currentIndex,
                                                                  !(state
                                                                          .tapeModel[currentIndex]
                                                                          .inSubscribe ??
                                                                      true),
                                                                  state
                                                                      .tapeModel[currentIndex]
                                                                      .inBasket,
                                                                  state
                                                                      .tapeModel[currentIndex]
                                                                      .inFavorite,
                                                                  state
                                                                          .tapeModel[currentIndex]
                                                                          .inReport ??
                                                                      false,
                                                                  state
                                                                          .tapeModel[currentIndex]
                                                                          .isLiked ??
                                                                      false,
                                                                  state
                                                                          .tapeModel[index]
                                                                          .statistics
                                                                          ?.like ??
                                                                      0,
                                                                  state
                                                                          .tapeModel[index]
                                                                          .statistics
                                                                          ?.favorite ??
                                                                      0,
                                                                  state
                                                                          .tapeModel[currentIndex]
                                                                          .statistics
                                                                          ?.send ??
                                                                      0,
                                                                );
                                                                setState(() {});
                                                              },
                                                              child: Container(
                                                                height: 26,
                                                                padding: const EdgeInsets.symmetric(
                                                                  horizontal: 8,
                                                                ),
                                                                alignment: Alignment.center,
                                                                decoration: BoxDecoration(
                                                                  color: AppColors.tapeColorGray,
                                                                  borderRadius:
                                                                      BorderRadius.circular(8),
                                                                ),
                                                                child: Text(
                                                                  title,
                                                                  style: const TextStyle(
                                                                    color: AppColors.kWhite,
                                                                    fontSize: 12,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      }
                                                      return const SizedBox.shrink();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),

                                            inReport(tape: state.tapeModel[index], index: index),

                                            const SizedBox(width: 4),

                                            InkWell(
                                              onTap: () => Navigator.pop(context),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(15),
                                                child: Container(
                                                  height: 28,
                                                  width: 28,
                                                  color: AppColors.tapeColorGray,
                                                  child: const Icon(
                                                    Icons.close,
                                                    size: 22,
                                                    color: AppColors.kWhite,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink();
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 90,
                        right: 16,
                        left: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.327,
                              ),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.router
                                          .push(
                                            ProfileSellerTapeRoute(
                                              chatId: state.tapeModel[index].chatId ?? 0,
                                              sellerAvatar:
                                                  state.tapeModel[currentIndex].shop?.image ?? '',
                                              sellerId: state.tapeModel[currentIndex].shop!.id!,
                                              sellerCreatedAt:
                                                  state.tapeModel[currentIndex].shop!.createdAt!,
                                              sellerName:
                                                  state.tapeModel[currentIndex].shop?.name ?? '',
                                              inSubscribe:
                                                  state.tapeModel[currentIndex].inSellerSubscribe ??
                                                  false,
                                              onSubChanged: (value) {
                                                BlocProvider.of<tapeCubit.TapeCubit>(
                                                  context,
                                                ).updateTapeByIndex(
                                                  index: currentIndex,
                                                  updatedTape: state.tapeModel[currentIndex]
                                                      .copyWith(
                                                        tapeId:
                                                            state.tapeModel[currentIndex].tapeId,
                                                        inSellerSubscribe: value,
                                                      ),
                                                );
                                              },
                                            ),
                                          )
                                          .whenComplete(() {
                                            stop = false;
                                            BlocProvider.of<tapeCubit.TapeCubit>(
                                              context,
                                            ).toLoadedState();
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
                                              30,
                                            ), // Slightly smaller than container
                                            child: Image.network(
                                              height: 40,
                                              width: 40,
                                              state.tapeModel[currentIndex].shop?.image != null
                                                  ? "https://lunamarket.ru/storage/${state.tapeModel[currentIndex].shop?.image}"
                                                  : "https://lunamarket.ru/storage/banners/2.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            left: 0,
                                            child: Container(
                                              height: 20,
                                              width: 38,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topRight,
                                                  end: Alignment.bottomLeft,
                                                  transform: GradientRotation(4.2373),
                                                  colors: [Color(0xFFAD32F8), Color(0xFF3275F8)],
                                                ),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(top: 4.5, bottom: 4.5),
                                                  child: Image.asset(
                                                    Assets.icons.sellerNavigationUnfullIcon.path,
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
                                  isLike(
                                    tape: state.tapeModel[index],
                                    index: index,
                                    isBlogger: false,
                                  ),
                                  const SizedBox(height: 10),
                                  inFavorites(
                                    tape: state.tapeModel[index],
                                    index: index,
                                    isBlogger: false,
                                  ),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () async {
                                      await Share.share(
                                        "$kDeepLinkUrl/?index\u003d${widget.index}&shop_name\u003d${widget.shopName}",
                                      );

                                      BlocProvider.of<tapeCubit.TapeCubit>(context).update(
                                        state.tapeModel[index],
                                        index,
                                        state.tapeModel[index].inSubscribe,
                                        state.tapeModel[index].inBasket,
                                        state.tapeModel[index].inFavorite,
                                        state.tapeModel[index].inFavorite,
                                        state.tapeModel[index].isLiked,
                                        state.tapeModel[index].statistics?.like ?? 0,
                                        state.tapeModel[index].statistics?.favorite ?? 0,
                                        (state.tapeModel[index].statistics?.send ?? 0) + 1,
                                        isBlogger: false,
                                      );

                                      BlocProvider.of<tapeCubit.TapeCubit>(
                                        context,
                                      ).share(state.tapeModel[index].tapeId!);

                                      setState(() {});
                                    },
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          Assets.icons.sendIcon.path,
                                          color: Colors.white,
                                          scale: 1.9,
                                        ),
                                        Text(
                                          ' ${state.tapeModel[index].statistics?.send}',
                                          style: AppTextStyles.size16Weight400.copyWith(
                                            color: AppColors.kWhite,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 14),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              height: 70,
                              decoration: BoxDecoration(
                                color: AppColors.kWhite,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: SizedBox(
                                width: 358,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 54,
                                      width: 56,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(width: 0.33, color: AppColors.kGray300),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.3),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(16),
                                          child: Image.network(
                                            'https://lunamarket.ru/storage/${state.tapeModel[index].image}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${state.tapeModel[index].name}',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: AppTextStyles.size14Weight600,
                                          ),
                                          state.tapeModel[index].compound != 0
                                              ? Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      // width: 75,
                                                      child: Text(
                                                        '${formatPrice(compoundPrice)} ₽ ',
                                                        style: AppTextStyles.size16Weight600,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${formatPrice(state.tapeModel[index].price!)} ₽ ',
                                                      style: AppTextStyles.size14Weight500.copyWith(
                                                        color: AppColors.kGray300,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Text(
                                                  '${formatPrice(state.tapeModel[index].price!)} ₽ ',
                                                  style: AppTextStyles.size16Weight600,
                                                ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    inBaskets(
                                      tape: state.tapeModel[index],
                                      index: index,
                                      isBlogger: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
            }
          },
        ),
      ),
    );
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
    _controller =
        VideoPlayerController.network("https://lunamarket.ru/storage/${widget.tape.video}")
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
                  fit: BoxFit.fitHeight,
                  child: GestureDetector(
                    onTap: () {
                      _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
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
                              _controller?.pause(); //pausing  functionality
                            } else {
                              _controller?.play();
                            }
                          },
                          child: VideoPlayer(_controller!),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              icon
                  ? GestureDetector(
                      onTap: () {
                        _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
                      },
                      child: Center(
                        child: Image.asset(Assets.icons.tapePlayIcon.path, height: 36, width: 36),
                      ),
                    )
                  : SizedBox.shrink(),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: Container(
                    // увеличь при необходимости до 140–160
                    height: MediaQuery.of(context).padding.top + 120,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xF0000000), // 0% — очень тёмный
                          Color(0xB3000000), // 50%
                          Color(0x66000000), // 60%
                          Color(0x00000000), // 70% — прозрачно
                        ],
                        stops: [0.0, 0.5, 0.6, 0.7],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : const Center(child: CircularProgressIndicator(color: Colors.blueAccent));
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
        BlocProvider.of<SubsCubit>(context).sub(widget.tape.shop!.id.toString());

        //widget.tape.inSubscribe = false;
        BlocProvider.of<tapeCubit.TapeCubit>(context).update(
          widget.tape,
          widget.index,
          !inSub!,
          widget.tape.inBasket,
          widget.tape.inFavorite,
          widget.tape.inReport,
          widget.tape.isLiked,
          widget.tape.statistics?.like ?? 0,
          widget.tape.statistics?.favorite ?? 0,
          widget.tape.statistics?.send ?? 0,
        );

        setState(() {
          inSub = !inSub!;
        });
      },
      child: SvgPicture.asset(
        inSub != true ? 'assets/icons/notification.svg' : 'assets/icons/notification2.svg',
        height: 20,
        width: 20,
        color: Colors.white,
      ),
    );
  }
}

class isLike extends StatefulWidget {
  final TapeModel tape;
  final int index;
  final bool isBlogger;
  const isLike({required this.tape, required this.index, super.key, required this.isBlogger});

  @override
  State<isLike> createState() => _isLikeState();
}

class _isLikeState extends State<isLike> {
  bool? isLiked;

  @override
  void initState() {
    isLiked = widget.tape.isLiked ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // final favorite = BlocProvider.of<tapcubit.TapeCubit>(context);
        // await favorite.favoriteTape(widget.tape.tapeId.toString());
        BlocProvider.of<tapeCubit.TapeCubit>(context).update(
          widget.tape,
          widget.index,
          widget.tape.inSubscribe,
          widget.tape.inBasket,
          widget.tape.inFavorite,
          widget.tape.inFavorite,
          !isLiked!,
          isLiked == false
              ? (widget.tape.statistics?.like ?? 0) + 1
              : (widget.tape.statistics?.like ?? 0) - 1,
          widget.tape.statistics?.favorite ?? 0,
          widget.tape.statistics?.send ?? 0,
          isBlogger: widget.isBlogger,
        );

        isLiked = !isLiked!;

        BlocProvider.of<tapeCubit.TapeCubit>(context).like(widget.tape.tapeId!);

        setState(() {});
      },
      child: Column(
        children: [
          Image.asset(
            isLiked == false ? Assets.icons.likeIcon.path : Assets.icons.likeFullIcon.path,
            scale: 1.9,
            colorBlendMode: BlendMode.colorDodge,
          ),
          Text(
            '${widget.tape.statistics?.like}',
            style: AppTextStyles.size16Weight400.copyWith(color: AppColors.kWhite),
          ),
        ],
      ),
    );
  }
}

class inFavorites extends StatefulWidget {
  final TapeModel tape;
  final int index;
  final bool isBlogger;
  const inFavorites({required this.tape, required this.index, super.key, required this.isBlogger});

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
          widget.tape.isLiked,
          widget.tape.statistics?.like ?? 0,
          inFavorite == false
              ? (widget.tape.statistics?.favorite ?? 0) + 1
              : (widget.tape.statistics?.favorite ?? 0) - 1,
          widget.tape.statistics?.send ?? 0,
          isBlogger: widget.isBlogger,
        );

        inFavorite = !inFavorite!;

        setState(() {});
      },
      child: Column(
        children: [
          Image.asset(
            inFavorite == false
                ? Assets.icons.favoriteIcon.path
                : Assets.icons.favoriteFullIcon.path,
            scale: 1.9,
            colorBlendMode: BlendMode.colorDodge,
          ),
          Text(
            '${widget.tape.statistics?.favorite}',
            style: AppTextStyles.size16Weight400.copyWith(color: AppColors.kWhite),
          ),
        ],
      ),
    );
  }
}

class inBaskets extends StatefulWidget {
  final TapeModel tape;
  final int index;
  final bool isBlogger;
  const inBaskets({required this.tape, required this.index, super.key, this.isBlogger = false});

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
            height: 36,
            width: 36,
            child: GestureDetector(
              onTap: () {
                if (state.tapeModel.isNotEmpty && widget.index < state.tapeModel.length) {
                  print('ok');
                } else {
                  return;
                }
                if (widget.tape.count == 0 && widget.tape.preOrder == 1) {
                  showCupertinoModalPopup<void>(
                    context: context,
                    builder: (context) => PreOrderDialog(
                      onYesTap: () {
                        state.tapeModel[widget.index].inBasket == false
                            ? BlocProvider.of<basCubit.BasketCubit>(context).basketAdd(
                                widget.tape.id.toString(),
                                '1',
                                0,
                                '',
                                '',
                                blogger_id: widget.tape.blogger?.id.toString() ?? '0',
                              )
                            : BlocProvider.of<basCubit.BasketCubit>(
                                context,
                              ).basketMinus(widget.tape.id.toString(), '1', 0, 'fbs');

                        BlocProvider.of<tapeCubit.TapeCubit>(context).update(
                          widget.tape,
                          widget.index,
                          widget.tape.inSubscribe,
                          !state.tapeModel[widget.index].inBasket!,
                          widget.tape.inFavorite,
                          widget.tape.inReport,
                          widget.tape.isLiked,
                          widget.tape.statistics?.like ?? 0,
                          widget.tape.statistics?.favorite ?? 0,
                          widget.tape.statistics?.send ?? 0,
                          isBlogger: widget.isBlogger,
                        );
                        setState(() {
                          inBasket = !inBasket!;
                        });

                        Get.back();
                      },
                    ),
                  );
                } else if (widget.tape.count == 0) {
                  showCupertinoModalPopup<void>(
                    context: context,
                    builder: (context) => CountZeroDialog(
                      onYesTap: () {
                        state.tapeModel[widget.index].inBasket == false
                            ? BlocProvider.of<basCubit.BasketCubit>(context).basketAdd(
                                widget.tape.id.toString(),
                                '1',
                                0,
                                '',
                                '',
                                blogger_id: widget.tape.blogger?.id.toString() ?? '0',
                              )
                            : BlocProvider.of<basCubit.BasketCubit>(
                                context,
                              ).basketMinus(widget.tape.id.toString(), '1', 0, 'fbs');

                        BlocProvider.of<tapeCubit.TapeCubit>(context).update(
                          widget.tape,
                          widget.index,
                          widget.tape.inSubscribe,
                          !state.tapeModel[widget.index].inBasket!,
                          widget.tape.inFavorite,
                          widget.tape.inReport,
                          widget.tape.isLiked,
                          widget.tape.statistics?.like ?? 0,
                          widget.tape.statistics?.favorite ?? 0,
                          widget.tape.statistics?.send ?? 0,
                          isBlogger: widget.isBlogger,
                        );
                        setState(() {
                          inBasket = !inBasket!;
                        });
                      },
                    ),
                  );
                } else {
                  state.tapeModel[widget.index].inBasket == false
                      ? BlocProvider.of<basCubit.BasketCubit>(context).basketAdd(
                          widget.tape.id.toString(),
                          '1',
                          0,
                          '',
                          '',
                          blogger_id: widget.tape.blogger?.id.toString() ?? '0',
                        )
                      : BlocProvider.of<basCubit.BasketCubit>(
                          context,
                        ).basketMinus(widget.tape.id.toString(), '1', 0, 'fbs');

                  BlocProvider.of<tapeCubit.TapeCubit>(context).update(
                    widget.tape,
                    widget.index,
                    widget.tape.inSubscribe,
                    !state.tapeModel[widget.index].inBasket!,
                    widget.tape.inFavorite,
                    widget.tape.inReport,
                    widget.tape.isLiked,
                    widget.tape.statistics?.like ?? 0,
                    widget.tape.statistics?.favorite ?? 0,
                    widget.tape.statistics?.send ?? 0,
                    isBlogger: false,
                  );
                  setState(() {
                    inBasket = !inBasket!;
                  });

                  // Get.back();

                  // this.context.router.pushAndPopUntil(
                  //       const LauncherRoute(children: [BasketRoute()]),
                  //       predicate: (route) => false,
                  //     );
                }
              },
              child: Stack(
                children: [
                  SizedBox(
                    height: 36,
                    width: 36,
                    child: Image.asset(Assets.icons.tapeBasketIcon.path, fit: BoxFit.cover),
                  ),
                  state.tapeModel[widget.index].inBasket == true
                      ? Align(
                          alignment: Alignment.topRight,
                          child: SizedBox(
                            width: 18,
                            height: 18,
                            child: Image.asset(
                              Assets.icons.doneInBasketIcon.path,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
          );
        } else {
          return GestureDetector(
            onTap: () {
              inBasket == false
                  ? BlocProvider.of<basCubit.BasketCubit>(context).basketAdd(
                      widget.tape.id.toString(),
                      '1',
                      0,
                      '',
                      '',
                      blogger_id: widget.tape.blogger?.id.toString() ?? '0',
                    )
                  : BlocProvider.of<basCubit.BasketCubit>(
                      context,
                    ).basketMinus(widget.tape.id.toString(), '1', 0, 'fbs');

              BlocProvider.of<tapeCubit.TapeCubit>(context).update(
                widget.tape,
                widget.index,
                widget.tape.inSubscribe,
                !inBasket!,
                widget.tape.inFavorite,
                widget.tape.inReport,
                widget.tape.isLiked,
                widget.tape.statistics?.like ?? 0,
                widget.tape.statistics?.favorite ?? 0,
                widget.tape.statistics?.send ?? 0,
                isBlogger: widget.isBlogger,
              );
              setState(() {
                inBasket = !inBasket!;
              });
            },
            child: SvgPicture.asset(
              inBasket != true ? 'assets/icons/shop_cart.svg' : 'assets/icons/shop_cart_white.svg',
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
  const inReport({required this.tape, required this.index, super.key, this.isBlogger = false});

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
        List<String> _reports = [
          'Жестокое обращение с детьми',
          'Спам',
          'Вредные или опасные действия',
          'Жестокое или отталкивающее содержание',
          'Дискриминация или оскорбления',
        ];

        showReportOptions(context, widget.tape.id!, 'Пожаловаться на видео:', _reports, (value) {});

        BlocProvider.of<tapeCubit.TapeCubit>(context).update(
          widget.tape,
          widget.index,
          widget.tape.inSubscribe,
          widget.tape.inBasket,
          widget.tape.inFavorite,
          !inReport!,
          widget.tape.isLiked,
          widget.tape.statistics?.like ?? 0,
          widget.tape.statistics?.favorite ?? 0,
          widget.tape.statistics?.send ?? 0,
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
          child: Icon(Icons.more_vert, color: AppColors.kWhite, size: 16),
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
          child: const Text('Жестокое обращение с детьми', style: TextStyle(color: Colors.black)),
          onPressed: () {
            Navigator.pop(context, 'Two');
            Get.snackbar(
              'Report Success',
              "Жестокое обращение с детьми",
              backgroundColor: AppColors.kPrimaryColor,
            );
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Спам', style: TextStyle(color: Colors.black)),
          onPressed: () {
            Navigator.pop(context, 'Two');
            Get.snackbar('Report Success', "Спам", backgroundColor: AppColors.kPrimaryColor);
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Вредные или опасные действия', style: TextStyle(color: Colors.black)),
          onPressed: () {
            Navigator.pop(context, 'Two');
            Get.snackbar(
              'Report Success',
              "Вредные или опасные действия",
              backgroundColor: AppColors.kPrimaryColor,
            );
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
              'Report Success',
              "Жестокое или отталкивающее содержание",
              backgroundColor: AppColors.kPrimaryColor,
            );
          },
        ),
        CupertinoActionSheetAction(
          child: const Text(
            'Дискриминационные высказывание и оскорбления',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context, 'Two');
            Get.snackbar(
              'Report Success',
              "Дискриминационные высказывание и оскорбления",
              backgroundColor: AppColors.kPrimaryColor,
            );
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
        child: const Text('Отмена', style: TextStyle(color: AppColors.kPrimaryColor)),
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
      ),
    ),
  );
}
