import 'package:flutter/material.dart';
import 'package:haji_market/src/core/presentation/widgets/shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    this.width = 80,
    this.height = 16,
    this.radius = 16,
    this.color,
    this.backgroundColor,
    this.direction,
    this.border,
  });
  final double? width;
  final double? height;
  final double radius;
  final Color? color;
  final Color? backgroundColor;
  final ShimmerDirection? direction;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) => Shimmer(
        color: backgroundColor ?? Colors.white,
        colorOpacity: 1,
        cornerRadius: radius,
        direction: direction ?? const ShimmerDirection.fromLeftToRight(),
        child: SizedBox(
          width: width,
          height: height,
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: border,
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              color: color ?? const Color(0xffEAECED),
            ),
          ),
        ),
      );
  // Shimmer.fromColors(
  //   baseColor: const Color(0xffEAECED).withOpacity(0.9),
  //   highlightColor: const Color(0xffEAECED).withOpacity(0.3),
  //   child: SizedBox(
  //     width: width,
  //     height: height,
  //     child: DecoratedBox(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.all(Radius.circular(radius)),
  //         color: const Color(0xffEAECED).withOpacity(0.9),
  //       ),
  //     ),
  //   ),
  // );
}
