import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:haji_market/src/core/constant/generated/assets.gen.dart';
import 'package:haji_market/src/feature/bloger/shop/bloc/blogger_tape_upload_cubit.dart';
import 'package:haji_market/src/feature/bloger/shop/bloc/blogger_tape_upload_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/common/constants.dart';

class EditTapeVidoePage extends StatefulWidget {
  int id;

  EditTapeVidoePage({required this.id, super.key});

  @override
  State<EditTapeVidoePage> createState() => _EditTapeVidoePageState();
}

class _EditTapeVidoePageState extends State<EditTapeVidoePage> {
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

  bool check = false;

  XFile? _video;

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
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        backgroundColor: AppColors.kWhite,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            Assets.icons.defaultBackIcon.path,
            scale: 1.9,
          ),
        ),
        title: const Text('Добавить видеообзор',
            style: AppTextStyles.size18Weight600),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Прикрепите видеообзор товара',
                style: AppTextStyles.size16Weight600),
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
                decoration: BoxDecoration(
                    color: AppColors.kGray1,
                    borderRadius: BorderRadius.circular(16)),
                child: DottedBorder(
                  dashPattern: [4, 4],
                  strokeWidth: 1,
                  color: Color(0xff8E8E93),
                  radius: Radius.circular(16),
                  borderType: BorderType.RRect,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (_video != null &&
                          _controller != null &&
                          _controller!.value.isInitialized)
                        Center(
                          child: AspectRatio(
                            aspectRatio: _controller!.value.aspectRatio,
                            child: VideoPlayer(_controller!),
                          ),
                        )
                      else
                        Center(
                          child: Image.asset(
                            Assets.icons.uploadVideoIcon.path,
                            // color: _image != null
                            //     ? AppColors.mainPurpleColor
                            //     : Colors.grey,
                            height: 18,
                            width: 30,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              width: 358,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xffF7F7F7)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Требования к видео',
                      style: AppTextStyles.size16Weight600),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Image.asset(
                        Assets.icons.defaultCheckIcon.path,
                        color: AppColors.mainPurpleColor,
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(width: 10),
                      const Text(
                        'Разрешение — 1080×1350/566×1080',
                        style: AppTextStyles.size14Weight400,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Image.asset(
                        Assets.icons.defaultCheckIcon.path,
                        color: AppColors.mainPurpleColor,
                        width: 20,
                        height: 20,
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
                      Image.asset(
                        Assets.icons.defaultCheckIcon.path,
                        color: AppColors.mainPurpleColor,
                        width: 20,
                        height: 20,
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
                      Image.asset(
                        Assets.icons.defaultCheckIcon.path,
                        color: AppColors.mainPurpleColor,
                        width: 20,
                        height: 20,
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
            Flexible(
              child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 170, minHeight: 170)),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 7.5, vertical: 16),
              child: SizedBox(
                height: 60,
                child: Row(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        check = !check;
                        setState(() {});
                      },
                      child: Image.asset(
                        check
                            ? Assets.icons.defaultCheckIcon.path
                            : Assets.icons.defaultUncheckIcon.path,
                        color: check ? AppColors.kLightBlackColor : null,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: SizedBox(
                        width: 311,
                        child: RichText(
                          text: TextSpan(
                            style: AppTextStyles.size14Weight400
                                .copyWith(color: Color(0xFF8E8E93)),
                            children: [
                              TextSpan(text: 'Размещая рекламные материалы, '),
                              TextSpan(
                                  text: 'вы принимаете условия ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text:
                                      'Типового договора на оказание рекламных услуг.',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: AppColors.mainPurpleColor)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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
          return ColoredBox(
            color: AppColors.kWhite,
            child: InkWell(
                onTap: () async {
                  if (_video != null &&
                      state is! LoadingState &&
                      check == true) {
                    button = true;
                    await BlocProvider.of<BloggerTapeUploadCubit>(context)
                        .uploadVideo(widget.id.toString(), _video!.path);
                  }
                },
                child: Container(
                    height: 52,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    margin: EdgeInsets.only(
                        bottom: 42, top: 16, left: 16, right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: (_video != null && check == true)
                          ? AppColors.mainPurpleColor
                          : AppColors.mainPurpleColor.withOpacity(0.3),
                    ),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    // padding: const EdgeInsets.only(left: 16, right: 16),
                    child: state is LoadingState
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: const CircularProgressIndicator(
                              color: AppColors.kWhite,
                            ))
                        : Text(
                            'Cохранить',
                            style: AppTextStyles.size18Weight600
                                .copyWith(color: AppColors.kWhite),
                            textAlign: TextAlign.center,
                          ))),
          );
        },
      ),
    );
  }
}
