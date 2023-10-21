import 'package:auto_route/auto_route.dart';
import 'package:haji_market/bloger/tape/data/cubit/tape_blogger_state.dart';
import 'package:haji_market/bloger/tape/data/model/TapeBloggerModel.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/widgets/custom_back_button.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../tape/data/cubit/tape_blogger_cubit.dart';

//import 'package:video_player/video_player.dart';
@RoutePage()
class BloggerDetailTapeCardPage extends StatefulWidget {
  final int? index;
  final String? shopName;
  const BloggerDetailTapeCardPage({required this.index, required this.shopName, Key? key}) : super(key: key);

  @override
  State<BloggerDetailTapeCardPage> createState() => _BloggerDetailTapeCardPageState();
}

class _BloggerDetailTapeCardPageState extends State<BloggerDetailTapeCardPage> {
  PageController controller = PageController();
  String? title;
  final TextEditingController searchController = TextEditingController();
  bool visible = true;

  // bool inSub = false;

  // procentPrice(price, compound) {
  //   var pp = (((price!.toInt() - compound!.toInt()) / price!.toInt()) * 100)
  //       as double;
  //   return pp.toInt();
  // }

  @override
  void initState() {
    controller = PageController(initialPage: widget.index!);
    // title = 'Лента';
    //  GetStorage().write('title_tape', 'Отписаться');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
            backgroundColor: Colors.transparent,
            elevation: 0,
            // excludeHeaderSemantics: true,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CustomBackButton(onTap: () {
                context.router.pop();

                //Get.back();

                // BlocProvider.of<navCubit.AdminNavigationCubit>(context)
                //     .emit(const navCubit.AdminNavigationState.tapeAdmin());
              }),
            ),
            centerTitle: true,
            title: visible == true
                ? Text(
                    '${widget.shopName}',
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                  )
                : null
            // ? Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       PopupMenuButton(
            //         color: const Color.fromRGBO(230, 231, 232, 1),
            //         shape: const RoundedRectangleBorder(
            //             borderRadius:
            //                 BorderRadius.all(Radius.circular(15.0))),
            //         position: PopupMenuPosition.under,
            //         offset: const Offset(0, 25),
            //         itemBuilder: (BuildContext bc) {
            //           return [
            //             PopupMenuItem(
            //               onTap: () {
            //                 title = 'Подписки';
            //                 BlocProvider.of<tapeCubit.TapeCubit>(context)
            //                     .tapes(true, false, null);
            //                 setState(() {});
            //               },
            //               value: 0,
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   const Text(
            //                     "Подписки",
            //                     style: TextStyle(color: Colors.black),
            //                   ),
            //                   SvgPicture.asset('assets/icons/lenta1.svg'),
            //                 ],
            //               ),
            //             ),
            //             PopupMenuItem(
            //               onTap: () {
            //                 BlocProvider.of<tapeCubit.TapeCubit>(context)
            //                     .tapes(false, true, null);

            //                 title = 'Избранное';
            //                 setState(() {});
            //               },
            //               value: 1,
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   const Text("Избранное"),
            //                   SvgPicture.asset('assets/icons/lenta2.svg'),
            //                 ],
            //               ),
            //             ),
            //           ];
            //         },
            //         child: Row(
            //           children: [
            //             Text(
            //               '${title}',
            //               textAlign: TextAlign.center,
            //               style: const TextStyle(
            //                   color: AppColors.kGray900,
            //                   fontSize: 16,
            //                   fontWeight: FontWeight.w500),
            //             ),
            //             const SizedBox(width: 5),
            //             Image.asset(
            //               'assets/icons/down.png',
            //               height: 16.5,
            //               width: 9.5,
            //             )
            //           ],
            //         ), // Icon(Icons.done,color: AppColors.kPrimaryColor,size: 16,)
            //       ),
            //     ],
            //   )
            // : null,
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
                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  controller: controller,
                  itemCount: state.tapeModel.length,
                  itemBuilder: (context, index) {
                    // inFavorite = state.tapeModel[index].inFavorite;
                    // inBasket = state.tapeModel[index].inBasket;
                    return Stack(
                      children: [
                        //VideoPlayer(_controller!)5,
                        Videos(tape: state.tapeModel[index]),
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
                              top: MediaQuery.of(context).size.height * 0.78,
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 28,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                  color: const Color(0xFFFF3347),
                                                  borderRadius: BorderRadius.circular(6)),
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${state.tapeModel[index].price} руб.',
                                                style: const TextStyle(
                                                    fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Container(
                                              height: 28,
                                              width: 110,
                                              decoration: BoxDecoration(
                                                  color: Colors.orangeAccent, borderRadius: BorderRadius.circular(6)),
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Артикул: ${state.tapeModel[index].id}',
                                                style: const TextStyle(
                                                    fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
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
                                            const SizedBox(
                                              height: 6,
                                            ),
                                            Container(
                                              //height: 28,
                                              // width: 110,
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: Colors.green[700], borderRadius: BorderRadius.circular(6)),
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${state.tapeModel[index].name}',
                                                style: const TextStyle(
                                                    fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                ])),
                        //      Row(
                        //    mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        // Column(
                        //   children: [
                        // Container(
                        //   width: 61,
                        //   height: 28,
                        //   decoration: BoxDecoration(
                        //       color: AppColors.kPrimaryColor,
                        //       borderRadius:
                        //           BorderRadius.circular(6)),
                        //   margin: const EdgeInsets.only(top: 370),
                        //   alignment: Alignment.center,
                        //   child: const Text(
                        //     '0·0·12',
                        //     style: TextStyle(
                        //         fontSize: 14,
                        //         fontWeight: FontWeight.w400,
                        //         color: Colors.white),
                        //   ),
                        // ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       color: Colors.black,
                        //       borderRadius:
                        //           BorderRadius.circular(6)),
                        //   // padding: const EdgeInsets.only(
                        //   //     left: 4, right: 4, bottom: 2, top: 2),
                        //   margin: const EdgeInsets.only(top: 370),
                        //   width: 56,
                        //   height: 28,
                        //   // margin: const EdgeInsets.only(top: 4),
                        //   alignment: Alignment.center,
                        //   child: const Text(
                        //     '10% Б',
                        //     style: TextStyle(
                        //         fontSize: 12,
                        //         fontWeight: FontWeight.w400,
                        //         color: Colors.white),
                        //   ),
                        // ),
                        //   ],
                        // ),
                        //   ],
                        //   ),

                        // Text(
                        //   'Артикул: ${state.tapeModel[index].id}',
                        //   style: const TextStyle(
                        //       fontSize: 12,
                        //       fontWeight: FontWeight.w500,
                        //       color: Colors.white),
                        // ),
                        //         const SizedBox(
                        //           height: 8,
                        //         ),
                        //         SizedBox(
                        //           // width: 358,
                        //           child: Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Row(
                        //                 children: [
                        //                   Text(
                        //                     '${(state.tapeModel[index].price!.toInt() - state.tapeModel[index].compound!.toInt())} ₸ ',
                        //                     style: const TextStyle(
                        //                         color: Colors.white,
                        //                         fontSize: 16,
                        //                         fontWeight: FontWeight.w500),
                        //                   ),
                        //                   const SizedBox(
                        //                     width: 8,
                        //                   ),
                        //                   Text(
                        //                     '${state.tapeModel[index].price} ₸ ',
                        //                     style: const TextStyle(
                        //                         color: Colors.white,
                        //                         fontSize: 16,
                        //                         fontWeight: FontWeight.w500,
                        //                         decoration:
                        //                             TextDecoration.lineThrough),
                        //                   ),
                        //                 ],
                        //               ),
                        //               Row(
                        //                 children: [
                        //                   const Text(
                        //                     'в рассрочку',
                        //                     style: TextStyle(
                        //                         color: Colors.white,
                        //                         fontSize: 12,
                        //                         fontWeight: FontWeight.w400),
                        //                   ),
                        //                   const SizedBox(
                        //                     width: 4,
                        //                   ),
                        //                   Container(
                        //                     decoration: BoxDecoration(
                        //                         borderRadius:
                        //                             BorderRadius.circular(
                        //                           4,
                        //                         ),
                        //                         color: const Color(
                        //                           0x30FFFFFF,
                        //                         )),
                        //                     padding: const EdgeInsets.only(
                        //                       left: 8,
                        //                       right: 8,
                        //                       top: 4,
                        //                       bottom: 4,
                        //                     ),
                        //                     child: Text(
                        //                       '${(state.tapeModel[index].price!.toInt() - state.tapeModel[index].compound!.toInt()).toInt() ~/ 3}',
                        //                       style: const TextStyle(
                        //                           color: Colors.white,
                        //                           fontSize: 12,
                        //                           fontWeight: FontWeight.w400),
                        //                     ),
                        //                   ),
                        //                   const SizedBox(
                        //                     width: 4,
                        //                   ),
                        //                   const Text(
                        //                     'х3',
                        //                     style: TextStyle(
                        //                         color: Colors.white,
                        //                         fontSize: 12,
                        //                         fontWeight: FontWeight.w400),
                        //                   )
                        //                 ],
                        //               )
                        //             ],
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   )
                      ],
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator(color: Colors.indigoAccent));
              }
            }));
  }
}

class Videos extends StatefulWidget {
  final TapeBloggerModel tape;
  const Videos({required this.tape, super.key});

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  VideoPlayerController? _controller;
  bool icon = true;

  Function? videoStop;

  @override
  void initState() {
    _controller = VideoPlayerController.network('http://185.116.193.73/storage/${widget.tape.video}')
      ..initialize().then((_) {
        _controller!.play();
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
                                  child: VideoPlayer(_controller!))))),
                ),
              ),
              icon
                  ? GestureDetector(
                      onTap: () {
                        _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
                      },
                      child: Center(
                          child: SvgPicture.asset(
                        'assets/icons/play_tape.svg',
                        color: const Color.fromRGBO(29, 196, 207, 1),
                      )),
                    )
                  : Container(),
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.11),
                child: VideoProgressIndicator(_controller!, allowScrubbing: true),
              ),
            ],
          )
        : const Center(child: CircularProgressIndicator(color: Colors.blueAccent));
  }
}
