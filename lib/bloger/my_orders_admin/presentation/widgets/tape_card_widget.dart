import 'dart:io';

import 'package:haji_market/admin/admin_app/bloc/admin_navigation_cubit/admin_navigation_cubit.dart';
import 'package:haji_market/admin/tape_admin/data/model/TapeAdminModel.dart';
import 'package:haji_market/bloger/tape/data/model/TapeBloggerModel.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/features/tape/presentation/data/models/TapeModel.dart';
import 'package:video_player/video_player.dart';

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

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        'http://185.116.193.73/storage/${widget.tape.video}')
      ..initialize().then((_) {
        _controller!.pause();
        // setState(() {});
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
    return Stack(
      children: [
        Positioned.fill(
          child: AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: VideoPlayer(_controller!)),
          ),
        ),
        InkWell(
          onTap: () {
            BlocProvider.of<AdminNavigationCubit>(context).emit(
                DetailTapeAdminState(widget.index, widget.tape.shop!.name!));
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
            child: Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset('assets/icons/play.svg')),
          ),
        ),
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
    );
  }
}
