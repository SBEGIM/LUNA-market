import 'package:auto_route/auto_route.dart';
import 'package:haji_market/src/feature/app/bloc/navigation_cubit/navigation_cubit.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import 'package:haji_market/src/feature/bloger/tape/bloc/tape_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/tape/bloc/tape_blogger_state.dart';
import 'package:haji_market/src/feature/bloger/tape/data/model/tape_blogger_model.dart';
import 'package:haji_market/src/feature/bloger/tape/presentation/widgets/show_blogget_tape_options_widget.dart';
import 'package:haji_market/src/feature/chat/presentation/message.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/count_zero_dialog.dart';
import 'package:haji_market/src/feature/drawer/presentation/widgets/pre_order_dialog.dart';
import 'package:haji_market/src/feature/tape/data/repository/tape_repository.dart';
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
import 'package:haji_market/src/feature/tape/data/models/tape_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:visibility_detector/visibility_detector.dart';
//import 'package:video_player/video_player.dart';

@RoutePage()
class DetailTapeBloggerCardPage extends StatefulWidget
    implements AutoRouteWrapper {
  final int? index;
  final int? tapeId;
  final String? shopName;
  final TapeBloggerCubit tapeBloc;
  final TapeBloggerModel tape;
  const DetailTapeBloggerCardPage(
      {required this.index,
      required this.shopName,
      Key? key,
      required this.tape,
      required this.tapeBloc,
      this.tapeId})
      : super(key: key);

  @override
  State<DetailTapeBloggerCardPage> createState() =>
      _DetailBloggerTapeCardPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TapeBloggerCubit>.value(
          value: tapeBloc,
        ),
      ],
      child: this,
    );
  }
}

class _DetailBloggerTapeCardPageState extends State<DetailTapeBloggerCardPage> {
  PageController controller = PageController();
  String? title;
  final TextEditingController searchController = TextEditingController();
  bool visible = true;

  // bool? inSub;
  int currentIndex = 0;

  bool stop = false;

  procentPrice(price, compound) {
    var pp = (((price!.toInt() - compound!.toInt()) / price!.toInt()) * 100)
        as double;
    return pp.toInt();
  }

  @override
  void initState() {
    print(widget.tapeId);

    if (widget.index != null) {
      currentIndex = widget.index!;
      controller = PageController(initialPage: widget.index!);
    }
    final tape = BlocProvider.of<TapeBloggerCubit>(context);
    if (tape.state is TapeBloggerState) {
      if ((tape.state as LoadedState).tapeModel[currentIndex].tapeId != null) {}
    }

    // if (BlocProvider.of<MetaCubit>(context).state is! LoadedState) {
    //   BlocProvider.of<MetaCubit>(context).partners();
    // }
    title = 'Лента';
    // GetStorage().write('title_tape', 'Отписаться');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                size: 25,
                color: AppColors.kWhite,
              )),
          toolbarHeight: 26,
          centerTitle: true,
          title:
              //  Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              // ClipRRect(
              //   borderRadius: BorderRadius.circular(5),
              //   child: Image.network(
              //     'https://lunamarket.ru/storage/}',
              //     height: 30.6,
              //     width: 30.6,
              //     errorBuilder: (context, error, stackTrace) =>
              //         const ErrorImageWidget(
              //       height: 30.6,
              //       width: 30.6,
              //     ),
              //   ),
              // ),
              //  SizedBox(width: 10),
              Text(
            '${widget.shopName}',
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          // ],
          // ),
          actions: [
            InkWell(
              onTap: () {
                showBlogerTapeOptions(context, widget.tapeId!, widget.tape);
              },
              child: Icon(
                Icons.more_vert,
                size: 25,
                color: AppColors.kWhite,
              ),
            )
          ],
        ),
        body: BlocConsumer<TapeBloggerCubit, TapeBloggerState>(
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
                return const Center(
                    child:
                        CircularProgressIndicator(color: Colors.indigoAccent));
              }

              if (state is LoadedState) {
                return Stack(
                  children: [
                    Videos(tape: state.tapeModel[widget.index!]),
                    Positioned(
                      bottom: 50,
                      left: 8,
                      right: 8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 164,
                            width: 310,
                            decoration: BoxDecoration(
                                color: AppColors.kWhite,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 124,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 104,
                                              width: 104,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                  // Добавляем линию вокруг контейнера
                                                  color: AppColors.kGray200,
                                                  // Цвет линии (можно изменить на нужный)
                                                  width: 1, // Толщина линии
                                                ),
                                              ),
                                              child: Image.network(
                                                'https://lunamarket.ru/storage/${state.tapeModel[widget.index!].image}',
                                                fit: BoxFit.contain,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    const ErrorImageWidget(
                                                  height: 104,
                                                  width: 104,
                                                ),
                                                // loadingBuilder: (context, child,
                                                //     loadingProgress) {
                                                //   if (loadingProgress == null)
                                                //     return child;
                                                //   return const Center(
                                                //       child:
                                                //           CircularProgressIndicator(
                                                //               strokeWidth: 2));
                                                // },
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 180,
                                                  child: Text(
                                                    '${state.tapeModel[widget.index!].name}',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '${(state.tapeModel[widget.index!].price!.toInt() - ((state.tapeModel[widget.index!].price! / 100) * state.tapeModel[widget.index!].compound!).toInt())} ₽ ',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          '${state.tapeModel[widget.index!].price} ₽',
                                                          style: const TextStyle(
                                                              color: AppColors
                                                                  .kGray300,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              decorationColor:
                                                                  AppColors
                                                                      .kGray300),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 8),
                                                    Container(
                                                      width: 100,
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: AppColors
                                                              .mainPurpleColor
                                                              .withOpacity(
                                                                  0.3)),
                                                      child: Text(
                                                        '${(state.tapeModel[widget.index!].price!.toInt() - ((state.tapeModel[widget.index!].price! / 100) * state.tapeModel[widget.index!].compound!).toInt()) ~/ 3} ₽/ мес',
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Container(
                                    width: 290,
                                    height: 32,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.mainPurpleColor),
                                    child: Text(
                                      'Посмотреть товар',
                                      style: AppTextStyles
                                          .defaultButtonTextStyle
                                          .copyWith(
                                              color: AppColors.kButtonColor),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                )
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Icon(
                                Icons.sell,
                                color: AppColors.kWhite,
                                size: 25,
                              ),
                              Text(
                                '${state.tapeModel[currentIndex].basketCount}',
                                style: AppTextStyles.catalogTextStyle
                                    .copyWith(color: AppColors.kWhite),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Icon(
                                Icons.bookmark,
                                color: AppColors.kWhite,
                                size: 25,
                              ),
                              Text(
                                '${state.tapeModel[currentIndex].viewCount}',
                                style: AppTextStyles.catalogTextStyle
                                    .copyWith(color: AppColors.kWhite),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              InkWell(
                                onTap: () async {
                                  await Share.share(
                                      "$kDeepLinkUrl/?index\u003d${widget.index}&shop_name\u003d${widget.shopName}");
                                },
                                child: Icon(
                                  Icons.send,
                                  color: AppColors.kWhite,
                                  size: 25,
                                ),
                              ),
                              Text(
                                '${state.tapeModel[currentIndex].shareCount}',
                                style: AppTextStyles.catalogTextStyle
                                    .copyWith(color: AppColors.kWhite),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return Center(child: Container());
              }
            }));
  }
}

class Videos extends StatefulWidget {
  final TapeBloggerModel tape;
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

    // BlocProvider.of<TapeBloggerCubit>(context).view(widget.tape.tapeId!);
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
                        'assets/icons/play_tape.svg',
                        color: AppColors.mainPurpleColor,
                      )),
                    )
                  : Container(),
            ],
          )
        : const Center(
            child: CircularProgressIndicator(color: Colors.blueAccent));
  }
}
