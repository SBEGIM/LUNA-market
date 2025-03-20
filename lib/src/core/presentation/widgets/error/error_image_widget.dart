import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haji_market/src/core/constant/constants.dart';
import 'package:haji_market/src/core/theme/resources.dart';
import 'package:haji_market/src/core/utils/image_util.dart';

class ErrorImageWidget extends StatelessWidget {
  const ErrorImageWidget({
    super.key,
    this.height,
    this.width,
    this.showLocalImage = false,
  });
  final double? height;
  final double? width;
  final bool showLocalImage;

  @override
  Widget build(BuildContext context) {
    if (showLocalImage) {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          color: AppColors.kE3E3E3,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SvgPicture.asset(
            Assets.icons.a2.path,
            width: width,
            height: height,
          ),
        ),
      );
    } else {
      return Image.network(
        Constants.common.notFoundImage,
        fit: BoxFit.cover,
        height: height,
        width: width ?? double.infinity,
        loadingBuilder: ImageUtil.loadingBuilder,
        errorBuilder: (
          context,
          exception,
          stackTrace,
        ) =>
            SizedBox(
          height: height,
          width: width ?? double.infinity,
          child: const Center(child: Text('Image Error')),
        ),
      );
    }
  }
}
