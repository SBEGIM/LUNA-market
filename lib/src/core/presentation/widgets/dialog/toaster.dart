import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:haji_market/src/core/theme/resources.dart';

@sealed
class Toaster {
  const Toaster._();

  static final FToast _fToast = FToast();

  static void showTopShortToast(
    BuildContext context, {
    required String message,
    double radius = 12,
    EdgeInsetsGeometry? padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    Color? color,
    Color? textColor,
    Widget? body,
    String? svgIconPath,
    IconData? icon,
  }) {
    _prepareToast(context);

    final Widget toast = _buildToast(
      message: message,
      padding: padding,
      radius: radius,
      backgroundColor: color ?? AppColors.base900.withOpacity(0.94),
      textColor: textColor ?? AppColors.white,
      body: body,
      svgIconPath: svgIconPath,
      icon: icon ?? Icons.check_circle_rounded,
    );

    _showToast(
      context,
      toast: toast,
      duration: const Duration(milliseconds: 1800),
    );
  }

  static void showErrorTopShortToast(
    BuildContext context,
    String message, {
    double radius = 12,
    EdgeInsetsGeometry? padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    Color? color,
    Color? textColor,
    Widget? body,
    String? svgIconPath,
    IconData? icon,
  }) {
    _prepareToast(context);

    final Widget toast = _buildToast(
      message: message,
      padding: padding,
      radius: radius,
      backgroundColor: color ?? AppColors.additionalRed,
      textColor: textColor ?? AppColors.white,
      body: body,
      svgIconPath: svgIconPath,
      icon: icon ?? Icons.error_outline_rounded,
    );

    _showToast(
      context,
      toast: toast,
      duration: const Duration(milliseconds: 2200),
    );
  }

  static Widget _buildToast({
    required String message,
    required EdgeInsetsGeometry? padding,
    required double radius,
    required Color backgroundColor,
    required Color textColor,
    Widget? body,
    String? svgIconPath,
    IconData? icon,
  }) {
    final Widget resolvedBody = body ??
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (svgIconPath != null || icon != null) ...[
              if (svgIconPath != null)
                SvgPicture.asset(
                  svgIconPath,
                  width: 22,
                  height: 22,
                  colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
                )
              else
                Icon(icon, color: textColor, size: 22),
              const SizedBox(width: 12),
            ],
            Flexible(
              child: Text(
                message,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.body14Semibold.copyWith(color: textColor),
              ),
            ),
          ],
        );

    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
        boxShadow: const [
          BoxShadow(color: Color(0x1A000000), blurRadius: 16, offset: Offset(0, 8)),
          BoxShadow(color: Color(0x0F000000), blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: resolvedBody,
    );
  }

  static void _prepareToast(BuildContext context) {
    _fToast.init(context);
    _fToast.removeQueuedCustomToasts();
  }

  static void _showToast(
    BuildContext context, {
    required Widget toast,
    required Duration duration,
  }) {
    _fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: duration,
      positionedToastBuilder: (context, child, gravity) {
        final double topOffset = MediaQuery.of(context).padding.top + 12;

        return Positioned(
          top: topOffset,
          left: 0,
          right: 0,
          child: child,
        );
      },
    );
  }
}
