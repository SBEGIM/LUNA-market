import 'package:auto_route/auto_route.dart';
import 'package:haji_market/admin/admin_app/bloc/admin_navigation_cubit/admin_navigation_cubit.dart'
    as navCubit;
import 'package:haji_market/admin/tape_admin/data/cubit/tape_admin_cubit.dart'
    as tapeCubit;
import 'package:haji_market/admin/tape_admin/data/model/TapeAdminModel.dart';
import '../../../../admin/tape_admin/data/cubit/tape_admin_state.dart'
    as tapeState;
import 'package:video_player/video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:haji_market/features/app/widgets/custom_back_button.dart';
import 'package:haji_market/features/chat/presentation/chat_page.dart';
import 'package:haji_market/features/home/data/model/Cats.dart';
import 'package:haji_market/features/tape/presentation/data/bloc/subs_cubit.dart';
import 'package:haji_market/features/tape/presentation/data/models/TapeModel.dart';
import 'package:share_plus/share_plus.dart';

//import 'package:video_player/video_player.dart';
@RoutePage()
class BloggerDetailTapeCardPage extends StatefulWidget {
  final int? index;
  final String? shopName;
  const BloggerDetailTapeCardPage(
      {required this.index, required this.shopName, Key? key})
      : super(key: key);

  @override
  State<BloggerDetailTapeCardPage> createState() =>
      _BloggerDetailTapeCardPageState();
}

class _BloggerDetailTapeCardPageState extends State<BloggerDetailTapeCardPage> {
  PageController controller = PageController();
  String? title;
  final TextEditingController searchController = TextEditingController();
  // bool visible = true;

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
              BlocProvider.of<navCubit.AdminNavigationCubit>(context)
                  .emit(const navCubit.AdminNavigationState.tapeAdmin());
            }),
          ),
          // toolbarHeight: 26,
          // actions: [
          //   GestureDetector(
          //     onTap: () {
          //       if (GetStorage().read('title_tape').toString() ==
          //           'Отписаться') {
          //         GetStorage().write('title_tape', 'Подписаться');
          //       } else {
          //         GetStorage().write('title_tape', 'Отписаться');
          //       }

          //       // inSub = !inSub;
          //       setState(() {});
          //       // print('okkkwwww');
          //     },
          //     child: Container(
          //       height: 26,
          //       width: 98,
          //       alignment: Alignment.center,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(8),
          //         border: Border.all(
          //           width: 0.3,
          //           color: AppColors.kPrimaryColor,
          //         ),
          //       ),
          //       child: Text(
          //         GetStorage().read('title_tape').toString(),
          //         style: const TextStyle(
          //             color: AppColors.kPrimaryColor, fontSize: 12),
          //       ),
          //     ),
          //   ),
          // ],
          // centerTitle: true,
          // title: visible == true
          //     ? Text(
          //         '${widget.shop_name}',
          //         style: const TextStyle(
          //             color: Colors.white,
          //             fontSize: 16,
          //             fontWeight: FontWeight.w500),
          //       )
          //     : null
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
        body: BlocConsumer<tapeCubit.TapeAdminCubit, tapeState.TapeAdminState>(
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

                        //   Container(
                        //     margin: const EdgeInsets.only(left: 16, right: 16),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Container(
                        //           width: 49,
                        //           height: 28,
                        //           decoration: BoxDecoration(
                        //               color: const Color(0xFFFF3347),
                        //               borderRadius: BorderRadius.circular(6)),
                        //           margin: EdgeInsets.only(
                        //             top:
                        //                 MediaQuery.of(context).size.height * 0.15,
                        //           ),
                        //           alignment: Alignment.center,
                        //           child: Text(
                        //             '-${procentPrice(state.tapeModel[index].price, state.tapeModel[index].compound)}%',
                        //             style: const TextStyle(
                        //                 fontSize: 14,
                        //                 fontWeight: FontWeight.w400,
                        //                 color: Colors.white),
                        //           ),
                        //         ),
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.end,
                        //           children: [
                        //             // Column(
                        //             //   children: [
                        //             // Container(
                        //             //   width: 61,
                        //             //   height: 28,
                        //             //   decoration: BoxDecoration(
                        //             //       color: AppColors.kPrimaryColor,
                        //             //       borderRadius:
                        //             //           BorderRadius.circular(6)),
                        //             //   margin: const EdgeInsets.only(top: 370),
                        //             //   alignment: Alignment.center,
                        //             //   child: const Text(
                        //             //     '0·0·12',
                        //             //     style: TextStyle(
                        //             //         fontSize: 14,
                        //             //         fontWeight: FontWeight.w400,
                        //             //         color: Colors.white),
                        //             //   ),
                        //             // ),
                        //             // Container(
                        //             //   decoration: BoxDecoration(
                        //             //       color: Colors.black,
                        //             //       borderRadius:
                        //             //           BorderRadius.circular(6)),
                        //             //   // padding: const EdgeInsets.only(
                        //             //   //     left: 4, right: 4, bottom: 2, top: 2),
                        //             //   margin: const EdgeInsets.only(top: 370),
                        //             //   width: 56,
                        //             //   height: 28,
                        //             //   // margin: const EdgeInsets.only(top: 4),
                        //             //   alignment: Alignment.center,
                        //             //   child: const Text(
                        //             //     '10% Б',
                        //             //     style: TextStyle(
                        //             //         fontSize: 12,
                        //             //         fontWeight: FontWeight.w400,
                        //             //         color: Colors.white),
                        //             //   ),
                        //             // ),
                        //             //   ],
                        //             // ),
                        //           ],
                        //         ),

                        //         // Text(
                        //         //   'Артикул: ${state.tapeModel[index].id}',
                        //         //   style: const TextStyle(
                        //         //       fontSize: 12,
                        //         //       fontWeight: FontWeight.w500,
                        //         //       color: Colors.white),
                        //         // ),
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
                return const Center(
                    child:
                        CircularProgressIndicator(color: Colors.indigoAccent));
              }
            }));
  }
}

class Videos extends StatefulWidget {
  final TapeAdminModel tape;
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
    _controller = VideoPlayerController.network(
        'http://185.116.193.73/storage/${widget.tape.video}')
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
        ? GestureDetector(
            onTap: () {
              _controller!.value.isPlaying
                  ? _controller!.pause()
                  : _controller!.play();
            },
            child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: Stack(
                      children: [
                        VideoPlayer(_controller!),
                        Container(
                          alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.10),
                          child: VideoProgressIndicator(_controller!,
                              allowScrubbing: true),
                        ),
                        icon
                            ? Center(
                                child: SvgPicture.asset(
                                'assets/icons/play_tape.svg',
                                color: const Color.fromRGBO(29, 196, 207, 1),
                              ))
                            : Container(),
                      ],
                    ))))
        : const Center(
            child: CircularProgressIndicator(color: Colors.blueAccent));
  }
}
