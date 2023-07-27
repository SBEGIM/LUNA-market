
import 'package:flutter/material.dart';
import 'package:haji_market/features/app/widgets/image_util.dart';
const NOT_FOUND_IMAGE =
    'https://cdn.shopify.com/shopifycloud/shopify/assets/no-image-2048-5e88c1b20e087fb7bbe9a3771824e743c244f437e4f8ba93bbf7b11b53f7824c_600x600.gif';

const NO_IMAGE_AVAILABLE =
    'https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image@2x.png';

class ErrorImageWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const ErrorImageWidget({
    super.key,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      NOT_FOUND_IMAGE,
      fit: BoxFit.cover,
      height: height,
      width: width ?? double.infinity,
      loadingBuilder: ImageUtil.loadingBuilder,
      errorBuilder: (
        BuildContext context,
        Object exception,
        StackTrace? stackTrace,
      ) {
        return SizedBox(
          height: height,
          width: width ?? double.infinity,
          child: const Center(child: Text('Image Error')),
        );
      },
    );
  }
}
