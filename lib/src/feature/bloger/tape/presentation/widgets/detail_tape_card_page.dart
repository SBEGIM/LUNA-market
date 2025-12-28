import 'package:auto_route/auto_route.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/app/router/app_router.dart';
import 'package:haji_market/src/feature/bloger/tape/bloc/tape_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/tape/bloc/tape_blogger_state.dart';
import 'package:haji_market/src/feature/bloger/tape/data/model/tape_blogger_model.dart';
import 'package:haji_market/src/feature/bloger/tape/presentation/widgets/show_blogget_tape_options_widget.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:visibility_detector/visibility_detector.dart';

@RoutePage()
class DetailTapeBloggerCardPage extends StatefulWidget implements AutoRouteWrapper {
  final int? index;
  final int? tapeId;
  final String? shopName;
  final TapeBloggerCubit tapeBloc;
  final TapeBloggerModel tape;

  const DetailTapeBloggerCardPage({
    required this.index,
    required this.shopName,
    super.key,
    required this.tape,
    required this.tapeBloc,
    this.tapeId,
  });

  @override
  State<DetailTapeBloggerCardPage> createState() => _DetailBloggerTapeCardPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<TapeBloggerCubit>.value(value: tapeBloc)],
      child: this,
    );
  }
}

class _DetailBloggerTapeCardPageState extends State<DetailTapeBloggerCardPage> {
  PageController controller = PageController();
  String? title;
  final TextEditingController searchController = TextEditingController();
  bool visible = true;

  int currentIndex = 0;

  bool stop = false;

  String formatPrice(int price) {
    final format = NumberFormat('#,###', 'ru_RU');
    return format.format(price).replaceAll(',', ' ');
  }

  int compoundPrice = 0;

  @override
  void initState() {
    if (widget.index != null) {
      currentIndex = widget.index!;
      controller = PageController(initialPage: widget.index!);
    }
    final tape = BlocProvider.of<TapeBloggerCubit>(context);
    if (tape.state is LoadedState) {
      final loadedState = tape.state as LoadedState;
      if (loadedState.tapeModel[currentIndex].tapeId != null) {}
    }

    title = 'Лента';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actionsPadding: EdgeInsets.only(right: 16),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: InkWell(
            onTap: () {
              // Get.back();
              context.router.pop();
            },
            child: Icon(Icons.arrow_back, size: 25, color: AppColors.kWhite),
          ),
        ),
        toolbarHeight: 32,
        centerTitle: true,
        title: InkWell(
          onTap: () {
            context.router.push(
              ProfileSellerTapeBloggerRoute(
                chatId: widget.tape.chatId ?? 0,
                sellerAvatar: widget.tape.shop?.image ?? '',
                sellerId: widget.tape.shop!.id!,
                sellerCreatedAt: widget.tape.shop!.createdAt!,
                sellerName: widget.tape.shop!.name ?? '',
                inSubscribe: false,
                onSubChanged: (value) {
                  // BlocProvider.of<TapeBloggerCubit>(context).updateTapeByIndex(
                  //   index: currentIndex,
                  //   updatedTape: state.tapeModel[currentIndex].copyWith(
                  //     tapeId: state.tapeModel[currentIndex].tapeId,
                  //     inSellerSubscribe: value,
                  //   ),
                  // );
                },
              ),
            );
            stop = true;
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 16, // половина от 32
                backgroundImage: NetworkImage(
                  widget.tape.shop?.image != null
                      ? "https://lunamarket.ru/storage/${widget.tape.shop?.image}"
                      : "https://lunamarket.ru/storage/banners/2.png",
                ),
                backgroundColor: Colors.grey[200], // запасной фон
              ),
              const SizedBox(width: 12),
              Text(
                '${widget.shopName}',
                style: AppTextStyles.size18Weight600.copyWith(color: AppColors.kWhite),
              ),
            ],
          ),
        ),
        actions: [
          InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              showBlogerTapeOptions(context, widget.tapeId!, widget.tape);
            },
            child: Icon(Icons.more_vert, size: 25, color: AppColors.kWhite),
          ),
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
            return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
          }

          if (state is LoadedState) {
            compoundPrice =
                (state.tapeModel[currentIndex].price!.toInt() *
                        (((100 - state.tapeModel[currentIndex].compound!.toInt())) / 100))
                    .toInt();
            return Stack(
              children: [
                Videos(tape: state.tapeModel[widget.index!]),
                Positioned(
                  bottom: 50,
                  left: 16,
                  right: 17,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.327),
                        child: Column(
                          children: [
                            IsLikeWidget(tape: widget.tape, index: currentIndex),
                            const SizedBox(height: 10),
                            InFavoritesWidget(tape: widget.tape, index: currentIndex),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () async {},
                              child: Column(
                                children: [
                                  Image.asset(
                                    Assets.icons.sendIcon.path,
                                    color: Colors.white,
                                    scale: 1.9,
                                  ),
                                  Text(
                                    ' ${state.tapeModel[currentIndex].statistics?.send ?? 0}',
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
                                      'https://lunamarket.ru/storage/${state.tapeModel[currentIndex].image}',
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
                                      '${state.tapeModel[currentIndex].name}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: AppTextStyles.size14Weight600,
                                    ),
                                    state.tapeModel[currentIndex].compound != 0
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
                                                '${formatPrice(state.tapeModel[currentIndex].price!)} ₽ ',
                                                style: AppTextStyles.size14Weight500.copyWith(
                                                  color: AppColors.kGray300,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Text(
                                            '${formatPrice(state.tapeModel[currentIndex].price!)} ₽ ',
                                            style: AppTextStyles.size16Weight600,
                                          ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              InBasketsWidget(
                                index: currentIndex,
                                count: widget.tape.basketCount ?? 0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
              ],
            );
          } else {
            return Center(child: Container());
          }
        },
      ),
    );
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
            ],
          )
        : const Center(child: CircularProgressIndicator(color: Colors.blueAccent));
  }
}

class InBasketsWidget extends StatefulWidget {
  final int index;
  final int count;
  const InBasketsWidget({required this.index, required this.count, super.key});

  @override
  State<InBasketsWidget> createState() => _InBasketsWidgetState();
}

class _InBasketsWidgetState extends State<InBasketsWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      width: 46,
      child: GestureDetector(
        onTap: () {},
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset(Assets.icons.tapeBasketIcon.path, height: 36, width: 36),
            Positioned(
              top: -2,
              right: -2,
              child: Container(
                height: 24,
                width: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green, // фон бейджа
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2), // белая обводка
                ),
                child: Text(
                  '${widget.count}',
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IsLikeWidget extends StatefulWidget {
  final TapeBloggerModel tape;
  final int index;
  const IsLikeWidget({required this.tape, required this.index, super.key});

  @override
  State<IsLikeWidget> createState() => _IsLikeWidgetState();
}

class _IsLikeWidgetState extends State<IsLikeWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {},
      child: Column(
        children: [
          Image.asset(
            Assets.icons.likeFullIcon.path,
            scale: 1.9,
            colorBlendMode: BlendMode.colorDodge,
          ),
          Text(
            '${widget.tape.statistics?.like ?? 0}',
            style: AppTextStyles.size16Weight400.copyWith(color: AppColors.kWhite),
          ),
        ],
      ),
    );
  }
}

class InFavoritesWidget extends StatefulWidget {
  final TapeBloggerModel tape;
  final int index;
  const InFavoritesWidget({required this.tape, required this.index, super.key});

  @override
  State<InFavoritesWidget> createState() => _InFavoritesWidgetState();
}

class _InFavoritesWidgetState extends State<InFavoritesWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {},
      child: Column(
        children: [
          Image.asset(
            Assets.icons.favoriteFullIcon.path,
            scale: 1.9,
            colorBlendMode: BlendMode.colorDodge,
          ),
          Text(
            '${widget.tape.statistics?.favorite ?? 0}',
            style: AppTextStyles.size16Weight400.copyWith(color: AppColors.kWhite),
          ),
        ],
      ),
    );
  }
}
