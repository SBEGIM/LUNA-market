import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:haji_market/bloger/my_orders_admin/data/bloc/upload_video_blogger_cubit.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/common/constants.dart';

class UpdateProductVideoPage extends StatefulWidget {
  final int product_id;
  const UpdateProductVideoPage({required this.product_id, super.key});

  @override
  State<UpdateProductVideoPage> createState() => _UpdateProductVideoPageState();
}

class _UpdateProductVideoPageState extends State<UpdateProductVideoPage> {
  XFile? _video;
  final ImagePicker _picker = ImagePicker();
  bool change = false;

  Future<void> _getImage() async {
    final video = change == true
        ? await _picker.pickVideo(source: ImageSource.camera)
        : await _picker.pickVideo(source: ImageSource.gallery);

    setState(() {
      _video = video;
    });
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
            Icons.arrow_back_ios,
            color: AppColors.kPrimaryColor,
          ),
        ),
        // iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
        title: const Text(
          'Загрузить видео',
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
            const Text(
              'Видео товара',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Формат - mp4,mpeg',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                if (_video == null) {
                  Get.defaultDialog(
                      title: "Загрузить видео",
                      middleText: '',
                      textConfirm: 'Камера',
                      textCancel: 'Галлерея',
                      titlePadding: const EdgeInsets.only(top: 40),
                      onConfirm: () {
                        change = true;
                        setState(() {
                          change;
                        });
                        _getImage();
                      },
                      onCancel: () {
                        change = false;
                        setState(() {
                          change;
                        });
                        _getImage();
                      });
                }
              },
              child: Container(
                  width: 343,
                  height: 56,
                  //  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/video.svg',
                        color: _video != null
                            ? AppColors.kPrimaryColor
                            : Colors.grey,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Добавить видео',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 12),
            const Text(
              'Разрешение — 1080×1350 px — для горизонтального; 566×1080 px — для вертикального; Расширение — mov, mp4; jpg, png; Размер — 4 ГБ — для видео, 30 МБ — для фото; Длительность — от 3 до 60 секунд.',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: InkWell(
            onTap: () {
              // Get.to(BasketOrderPage());

              final fileVideo = _video != null ? _video!.path : null;
              BlocProvider.of<UploadVideoBLoggerCubit>(context)
                  .upload(fileVideo, widget.product_id);

              Navigator.pop(context);
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
                          color: AppColors.kPrimaryColor,
                        ),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        // padding: const EdgeInsets.only(left: 16, right: 16),
                        child: const Text(
                          'Готово',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        )),
                  ],
                ))),
      ),
    );
  }
}
