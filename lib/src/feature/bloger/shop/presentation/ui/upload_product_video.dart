import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/common/constants.dart';
import '../../bloc/blogger_tape_upload_cubit.dart';
import '../../bloc/blogger_tape_upload_state.dart';

class UploadProductVideoPage extends StatefulWidget {
  int id;

  UploadProductVideoPage({required this.id, super.key});

  @override
  State<UploadProductVideoPage> createState() => _UploadProductVideoPageState();
}

class _UploadProductVideoPageState extends State<UploadProductVideoPage> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  bool change = false;
  bool button = true;
  VideoPlayerController? _controller;
  Future<void> initVideo(String path) async {
    _controller = VideoPlayerController.file(File(path))
      ..initialize().then((_) {
        _controller!.pause();
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _getVideo() async {
    final image = change == true
        ? await _picker.pickVideo(source: ImageSource.camera)
        : await _picker.pickVideo(
            source: ImageSource.gallery,
            maxDuration: const Duration(minutes: 2));

    setState(() {
      _image = image;
    });
    initVideo(_image!.path);
    // final edit = BlocProvider.of<LoginCubit>(context);
    // await edit.edit(_box.read('name') ?? '', _box.read('phone') ?? '',
    //     _image != null ? _image!.path : "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.kLightBlackColor,
          ),
        ),
        // iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        title: const Text(
          'Добавить видеообзор',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Прикрепите видеообзор товара',
                style: AppTextStyles.statisticsTextStyle
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            if (_image != null &&
                _controller != null &&
                _controller!.value.isInitialized)
              Center(
                child: SizedBox(
                  height: 200,
                  child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: VideoPlayer(_controller!)),
                  ),
                ),
              ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                // if (_image == null) {
                Get.defaultDialog(
                    title: "Загрузить видео",
                    middleText: '',
                    textConfirm: 'Камера',
                    textCancel: 'Фото',
                    titlePadding: const EdgeInsets.only(top: 40),
                    onConfirm: () {
                      change = true;
                      setState(() {
                        change;
                      });
                      _getVideo();
                    },
                    onCancel: () {
                      change = false;
                      setState(() {
                        change;
                      });
                      _getVideo();
                    });
                // }
              },
              child: Container(
                  width: 120,
                  height: 120,
                  //  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.kGray1,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 1, color: AppColors.kGray300)),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/video.svg',
                        color: _image != null
                            ? AppColors.mainPurpleColor
                            : Colors.grey,
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 12),
            Container(
              height: 200,
              width: 358,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.kGray1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Требования к видео',
                      style: AppTextStyles.statisticsTextStyle
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.mainPurpleColor,
                      ),
                      SizedBox(width: 10),
                      const Text(
                        'Разрешение — 1080×1350/566×1080',
                        style: AppTextStyles.statisticsTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.mainPurpleColor,
                      ),
                      SizedBox(width: 10),
                      const Text(
                        'Формат — mp4,mov',
                        style: AppTextStyles.statisticsTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.mainPurpleColor,
                      ),
                      SizedBox(width: 10),
                      const Text(
                        'Размер — 4 ГБ',
                        style: AppTextStyles.statisticsTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppColors.mainPurpleColor,
                      ),
                      SizedBox(width: 10),
                      const Text(
                        'Длительность — от 3 до 60 секунд.',
                        style: AppTextStyles.statisticsTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: BlocConsumer<BloggerTapeUploadCubit, BloggerTapeUploadState>(
        listener: (context, state) {
          if (state is LoadedState) {
            Navigator.pop(context);

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const BaseAdmin()),
            // );
          }
        },
        builder: (context, state) {
          return Container(
            color: Colors.white,
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            child: InkWell(
                onTap: () async {
                  if (_image != null && state is! LoadingState) {
                    button = true;
                    await BlocProvider.of<BloggerTapeUploadCubit>(context)
                        .uploadVideo(widget.id.toString(), _image!.path);
                  }
                },
                child: SizedBox(
                    height: 80,
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        Container(
                            height: 46,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _image != null
                                  ? AppColors.mainPurpleColor
                                  : AppColors.mainPurpleColor.withOpacity(0.3),
                            ),
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            // padding: const EdgeInsets.only(left: 16, right: 16),
                            child: state is LoadingState
                                ? const CircularProgressIndicator()
                                : Text(
                                    'Опубликовать',
                                    style: TextStyle(
                                        color: AppColors.kWhite,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                  )),
                      ],
                    ))),
          );
        },
      ),
    );
  }
}
