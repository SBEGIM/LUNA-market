import 'package:flutter/material.dart';
import 'package:haji_market/core/common/constants.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;
  const ShimmerBox({
    super.key,
    this.width = 80,
    this.height = 16,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.kNeutral.withOpacity(0.5),
      highlightColor: Colors.white,
      child: SizedBox(
        width: width,
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: radius == null ? null : BorderRadius.circular(radius!),
            color: AppColors.kGray300,
          ),
        ),
      ),
    );
  }
}
