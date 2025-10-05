import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/bloger/tape/bloc/tape_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/tape/bloc/upload_video_blogger_cubit.dart';
import 'package:haji_market/src/feature/bloger/tape/bloc/upload_video_blogger_state.dart';
import 'package:haji_market/src/feature/bloger/tape/data/model/tape_blogger_model.dart';
import 'package:haji_market/src/feature/bloger/tape/presentation/widgets/delete_video_dialog.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class BloggerTapeCardPage extends StatefulWidget {
  final TapeBloggerModel tape;
  final int index;
  const BloggerTapeCardPage({
    required this.tape,
    required this.index,
    super.key,
  });

  @override
  State<BloggerTapeCardPage> createState() => _BloggerTapeCardPageState();
}

class _BloggerTapeCardPageState extends State<BloggerTapeCardPage> {
  VideoPlayerController? _controller;
  bool isLoaded = false;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        'https://lunamarket.ru/storage/${widget.tape.video}')
      ..initialize().then((_) {
        _controller!.pause();
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  String formatViews(int views) {
    if (views >= 1000000) {
      return '${(views / 1000000).toStringAsFixed(1)} млн';
    } else if (views >= 1000) {
      return '${(views / 1000).toStringAsFixed(1)} тыс';
    } else {
      return '$views';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Positioned.fill(
            child: SizedBox.expand(
              child: FittedBox(
                  alignment: Alignment.center,
                  fit: BoxFit.fitHeight,
                  child: SizedBox(
                    height: _controller!.value.size.height,
                    width: _controller!.value.size.width,
                    child: AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: Opacity(
                          opacity: widget.tape.isDelete == true ? 0.4 : 1,
                          child: VideoPlayer(_controller!)),
                    ),
                  )),
            ),
          ),
          widget.tape.isDelete == true
              ? Center(
                  child: Text(
                    'Товар \nнедоступен',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.size14Weight600
                        .copyWith(color: AppColors.kWhite),
                  ),
                )
              : const SizedBox.shrink(),
          // Padding(
          //   padding: const EdgeInsets.only(right: 8.0, top: 8),
          //   child: Align(
          //       alignment: Alignment.topRight,
          //       child: SvgPicture.asset('assets/icons/play.svg')),
          // ),

          Positioned(
              top: 4,
              left: 4,
              child: Material(
                borderRadius: BorderRadius.circular(15),
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  child: Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      '${widget.tape.shop!.name}',
                      style: AppTextStyles.aboutTextStyle.copyWith(
                        color: widget.tape.isDelete != true
                            ? AppColors.kWhite
                            : AppColors.kWhite.withOpacity(0.5),
                        height: 20 / 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                ),
              )),

          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 8),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(children: [
                  Image.asset(Assets.icons.viewTapeIcon.path, scale: 1.9),
                  SizedBox(width: 8),
                  Text(
                    '${formatViews(widget.tape.viewCount ?? 0)}',
                    style: AppTextStyles.size14Weight600
                        .copyWith(color: AppColors.kWhite),
                  )
                ])),
          ),

          // BlocListener<UploadVideoBLoggerCubit, UploadVideoBloggerCubitState>(
          //   listener: (context, state) {
          //     if (state is LoadedOrderState) {
          //       if (isLoaded) {
          //         BlocProvider.of<TapeBloggerCubit>(context)
          //             .tapes(false, false, '');
          //         isLoaded = false;
          //       }
          //     }
          //   },
          //   child: Positioned(
          //       top: 4,
          //       left: 4,
          //       child: Material(
          //         borderRadius: BorderRadius.circular(15),
          //         color: Colors.transparent,
          //         child: InkWell(
          //           borderRadius: BorderRadius.circular(15),
          //           onTap: () {
          //             showCupertinoModalPopup<void>(
          //               context: context,
          //               builder: (context) => DeleteVideoDialog(
          //                 onYesTap: () {
          //                   if (widget.tape.tapeId != null) {
          //                     BlocProvider.of<UploadVideoBLoggerCubit>(context)
          //                         .delete(tapeId: widget.tape.tapeId!);
          //                     isLoaded = true;
          //                     Navigator.pop(context);
          //                   }
          //                 },
          //               ),
          //             );
          //           },
          //           child: const Padding(
          //             padding: EdgeInsets.all(6.0),
          //             child: Icon(
          //               Icons.delete,
          //               color: Colors.red,
          //             ),
          //           ),
          //         ),
          //       )),
          // )
          // Container(
          //   alignment: Alignment.center,
          //   margin: const EdgeInsets.only(top: 225),
          //   decoration: BoxDecoration(
          //     color: Colors.grey.withOpacity(0.5),
          //     borderRadius: const BorderRadius.only(
          //       topLeft: Radius.circular(0),
          //       topRight: Radius.circular(0),
          //       bottomLeft: Radius.circular(8),
          //       bottomRight: Radius.circular(8),
          //     ),
          //   ),
          //   child: Text(
          //     '${tape.shop!.name}',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(color: Colors.white, fontSize: 12),
          //   ),
          // ),
        ],
      ),
    );
  }
}
