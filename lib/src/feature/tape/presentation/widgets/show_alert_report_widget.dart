import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';

enum BrandedAlertMode { confirm, acknowledge }

Future<bool?> showBrandedAlert(
  BuildContext context, {
  // общее
  required String title,
  required String message,
  BrandedAlertMode mode = BrandedAlertMode.confirm,
  bool barrierDismissible = true,
  // тексты
  String cancelText = 'Отмена',
  String primaryText = 'Ок',
  // цвета/стили
  Color primaryColor = const Color(0xFF7B61FF),
  Gradient? primaryGradient, // для большой фиолетовой кнопки
}) {
  return showGeneralDialog<bool>(
    context: context,
    barrierLabel: 'branded_alert',
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.black.withOpacity(0.35),
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (_, __, ___) => const SizedBox.shrink(),
    transitionBuilder: (ctx, anim, __, ___) {
      final curved = CurvedAnimation(
        parent: anim,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );

      return FadeTransition(
        opacity: curved,
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: const SizedBox(),
              ),
            ),
            Center(
              child: SlideTransition(
                position: Tween(begin: const Offset(0, 0.04), end: Offset.zero)
                    .animate(curved),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 360),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.fromLTRB(20, 20, 16, 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 24,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.size22Weight600,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.size16Weight400
                              .copyWith(color: Color(0xff636366)),
                        ),
                        const SizedBox(height: 16),
                        if (mode == BrandedAlertMode.confirm)
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 52,
                                  child: TextButton(
                                    onPressed: () =>
                                        Navigator.of(ctx).pop(false),
                                    style: TextButton.styleFrom(
                                      foregroundColor: const Color(0xFF111111),
                                      backgroundColor: const Color(0xFFF1F1F1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: Text(cancelText,
                                        style: AppTextStyles.size15Weight600),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SizedBox(
                                  height: 52,
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(ctx).pop(true),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    child: Text(primaryText,
                                        style: AppTextStyles.size15Weight600
                                            .copyWith(color: AppColors.kWhite)),
                                  ),
                                ),
                              ),
                            ],
                          )
                        else
                          // acknowledge: большая «пилюля» с градиентом
                          _GradientActionButton(
                            text: primaryText,
                            onPressed: () => Navigator.of(ctx).pop(true),
                            height: 52,
                            borderRadius: 16,
                            gradient: primaryGradient ??
                                const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFF7B61FF),
                                    Color(0xFF9A57FF),
                                  ],
                                ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class _GradientActionButton extends StatelessWidget {
  const _GradientActionButton({
    required this.text,
    required this.onPressed,
    required this.gradient,
    this.height = 52,
    this.borderRadius = 26,
  });

  final String text;
  final VoidCallback onPressed;
  final Gradient gradient;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: onPressed,
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
