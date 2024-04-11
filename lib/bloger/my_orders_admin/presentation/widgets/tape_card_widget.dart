import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haji_market/bloger/my_orders_admin/data/bloc/upload_video_blogger_cubit.dart';
import 'package:haji_market/bloger/my_orders_admin/data/bloc/upload_video_blogger_state.dart';
import 'package:haji_market/bloger/my_orders_admin/presentation/widgets/delete_video_dialog.dart';
import 'package:haji_market/bloger/tape/data/cubit/tape_blogger_cubit.dart';
import 'package:haji_market/bloger/tape/data/model/TapeBloggerModel.dart';
import 'package:haji_market/features/app/router/app_router.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BloggerTapeCardWidget extends StatefulWidget {
  final TapeBloggerModel tape;
  final int index;
  const BloggerTapeCardWidget({
    required this.tape,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  State<BloggerTapeCardWidget> createState() => _BloggerTapeCardWidgetState();
}

class _BloggerTapeCardWidgetState extends State<BloggerTapeCardWidget> {
  VideoPlayerController? _controller;
  bool isLoaded = false;

  @override
  void initState() {
    _controller = VideoPlayerController.network('http://185.116.193.73/storage/${widget.tape.video}')
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

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
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
                      child: Opacity(opacity: widget.tape.isDelete == true ? 0.3 : 1, child: VideoPlayer(_controller!)),
                    ),
                  )),
            ),
          ),
          widget.tape.isDelete == true
              ? const Positioned(
                  top: 150,
                  left: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.close_outlined),
                      SizedBox(
                        height: 25,
                        child: Text(
                          'Товар удален продавцом',
                          maxLines: 2,
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox(),
          InkWell(
            onTap: () {
              context.router
                  .push(BloggerDetailTapeCardRoute(index: widget.index, shopName: widget.tape.shop?.name ?? ''));
              // BlocProvider.of<AdminNavigationCubit>(context).emit(
              //     DetailTapeAdminState(widget.index, widget.tape.shop!.name!));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const Base(
              //             index: 4,
              //           )),
              // );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 8),
              child: Align(alignment: Alignment.topRight, child: SvgPicture.asset('assets/icons/play.svg')),
            ),
          ),
          BlocListener<UploadVideoBLoggerCubit, UploadVideoBloggerCubitState>(
            listener: (context, state) {
              if (state is LoadedOrderState) {
                if (isLoaded) {
                  BlocProvider.of<TapeBloggerCubit>(context).tapes(false, false, '');
                  isLoaded = false;
                }
              }
            },
            child: Positioned(
                top: 4,
                left: 4,
                child: Material(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      showCupertinoModalPopup<void>(
                        context: context,
                        builder: (context) => DeleteVideoDialog(
                          onYesTap: () {
                            if (widget.tape.tapeId != null) {
                              BlocProvider.of<UploadVideoBLoggerCubit>(context).delete(tapeId: widget.tape.tapeId!);
                              isLoaded = true;
                              Navigator.pop(context);
                            }
                          },
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                )),
          )
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
