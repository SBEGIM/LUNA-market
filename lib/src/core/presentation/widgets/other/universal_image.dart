import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UniversalImage extends StatelessWidget {
  final String image;
  final bool useAsset; // Если true, ищем в ассетах, иначе загружаем по сети
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const UniversalImage({
    super.key,
    required this.image,
    this.useAsset = false,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.placeholder,
    this.errorWidget,
  });

  bool _isSvg(String path) {
    return path.toLowerCase().endsWith('.svg');
  }

  @override
  Widget build(BuildContext context) {
    final isSvg = _isSvg(image);

    return useAsset ? _buildAssetImage(isSvg) : _buildNetworkImage(isSvg);
  }

  Widget _buildAssetImage(bool isSvg) {
    try {
      return isSvg
          ? SvgPicture.asset(
              image,
              width: width,
              height: height,
              fit: fit,
            )
          : Image.asset(
              image,
              width: width,
              height: height,
              fit: fit,
            );
    } catch (e) {
      return errorWidget ??
          Center(
            child: Icon(
              Icons.broken_image,
              size: width ?? 50,
            ),
          );
    }
  }

  Widget _buildNetworkImage(bool isSvg) {
    return isSvg
        ? SvgPicture.network(
            image,
            width: width,
            height: height,
            fit: fit,
            placeholderBuilder: (context) =>
                placeholder ??
                const Center(
                  child: CircularProgressIndicator(),
                ),
            clipBehavior: Clip.antiAlias,
          )
        : Image.network(
            image,
            width: width,
            height: height,
            fit: fit,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return placeholder ??
                  Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
            },
            errorBuilder: (context, error, stackTrace) =>
                errorWidget ??
                Center(
                  child: Icon(
                    Icons.broken_image,
                    size: width ?? 50,
                  ),
                ),
          );
  }
}
