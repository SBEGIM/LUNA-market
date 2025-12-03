import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/src/core/common/constants.dart';
import 'package:haji_market/src/feature/app/widgets/error_image_widget.dart';
import 'package:video_player/video_player.dart';

class ProductImages extends StatefulWidget {
  final List<String>? images;
  final String? video;
  const ProductImages({required this.images, super.key, this.video});

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int imageIndex = 0;
  VideoPlayerController? _controller;
  VideoPlayerController? _controller2;
  bool icon = true;

  @override
  void initState() {
    if (widget.video != null) {
      _controller =
          VideoPlayerController.network(
              // 'https://lunamarket.ru/storage/${widget.product.path?.first ?? ''}'
              'https://lunamarket.ru/storage/${widget.video}',
            )
            ..initialize().then((_) {
              _controller!.pause();
              // setState(() {});
            });

      _controller!.addListener(() {
        _controller!.value.isPlaying == true ? icon = false : icon = true;

        setState(() {});
      });
      _controller2 =
          VideoPlayerController.network(
              // 'https://lunamarket.ru/storage/${widget.product.path?.first ?? ''}'
              'https://lunamarket.ru/storage/${widget.video}',
            )
            ..initialize().then((_) {
              _controller2!.pause();
              // setState(() {});
            });

      _controller2!.addListener(() {
        _controller2!.value.isPlaying == true ? icon = false : icon = true;

        setState(() {});
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (imageIndex == (widget.images?.length ?? 0))
            Container(
              margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
              height: 343,
              width: 378,
              child: GestureDetector(
                onTap: () {
                  _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
                },
                child: Stack(
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: VideoPlayer(_controller!),
                      ),
                    ),
                    // Positioned(
                    //   bottom: 10,
                    //   right: 0,
                    //   left: 0,
                    //   // alignment: Alignment.bottomCenter,
                    //   // padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.01),
                    //   child: VideoProgressIndicator(_controller!, allowScrubbing: true),
                    // ),
                    icon
                        ? Positioned.fill(
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/play_tape.svg',
                                height: 54,
                                width: 54,
                                color: const Color.fromRGBO(29, 196, 207, 1),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            )
          else
            Container(
              margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
              height: 343,
              width: 378,
              child: widget.images?.length != 0
                  ? Image.network(
                      "https://lunamarket.ru/storage/${widget.images![imageIndex]}",
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const ErrorImageWidget(),
                    )
                  : Image.asset('assets/icons/no_data.png'),
            ),
          Container(
            margin: const EdgeInsets.only(top: 82, left: 16, right: 16),
            height: 80,
            // width: 80,
            // color: Colors.red,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (widget.images?.length ?? 0) + ((widget.video != null ? 1 : 0)),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (() {
                    imageIndex = index;
                    setState(() {});
                  }),
                  child: Container(
                    margin: const EdgeInsets.only(top: 24, left: 8),
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 0.3,
                        color: imageIndex == index ? AppColors.kPrimaryColor : Colors.grey,
                      ),
                    ),
                    //color: Colors.red,
                    child: index == (widget.images?.length ?? 0)
                        ? VideoPlayer(_controller2!)
                        : Image.network(
                            "https://lunamarket.ru/storage/${widget.images![index]}",
                            fit: BoxFit.cover,
                          ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
