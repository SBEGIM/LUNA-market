import 'dart:io';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/features/tape/presentation/data/models/TapeModel.dart';
import 'package:video_player/video_player.dart';

import '../../../app/bloc/navigation_cubit/navigation_cubit.dart';

class TapeCardWidget extends StatefulWidget {
  final TapeModel tape;
  final int index;
  const TapeCardWidget({
    required this.tape,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  State<TapeCardWidget> createState() => _TapeCardWidgetState();
}

class _TapeCardWidgetState extends State<TapeCardWidget> {
  CachedVideoPlayerController? _controller;

  @override
  void initState() {
    _controller = CachedVideoPlayerController.network(
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
                child: CachedVideoPlayer(_controller!)),
          ),
        ),
        InkWell(
          onTap: () {
            BlocProvider.of<NavigationCubit>(context)
                .emit(DetailTapeState(widget.index, widget.tape.shop!.name!));
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
