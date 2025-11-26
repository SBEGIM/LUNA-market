import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';

enum BaskerAlertMode { confirm, acknowledge }

Future<bool?> showBasketCountZeroAlert(
  BuildContext context, {
  // общее
  required String title,
  required String message,
  BaskerAlertMode mode = BaskerAlertMode.confirm,
  bool barrierDismissible = false,
  // тексты
  String cancelText = 'Отмена',
  String primaryText = 'Ок',
  // цвета/стили
  Color primaryColor = AppColors.kWhite,
  Gradient? primaryGradient, // для большой фиолетовой кнопки
}) {
  return showGeneralDialog<bool>(
    context: context,
    barrierLabel: 'branded_alert',
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.black.withValues(alpha: 0.35),
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (_, _, _) => const SizedBox.shrink(),
    transitionBuilder: (ctx, anim, _, _) {
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
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Navigator.of(ctx).pop();
                },
                child: IgnorePointer(
                  // чтобы блюр не перехватывал события
                  ignoring: true,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: const SizedBox(),
                  ),
                ),
              ),
            ),
            Center(
              child: SlideTransition(
                position: Tween(begin: const Offset(0, 0.04), end: Offset.zero).animate(curved),
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 360),
                    // margin: const EdgeInsets.symmetric(horizontal: 20),
                    // padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
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
                        // контент с отступами
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 4),
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
                                style: AppTextStyles.size16Weight500.copyWith(
                                  color: Color(0xff636366),
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                          child: Container(
                            height: 52,
                            width: double.infinity,
                            margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                            decoration: BoxDecoration(
                              color: AppColors.mainPurpleColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: TextButton(
                              onPressed: () => Navigator.of(ctx).pop(true),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                foregroundColor: primaryColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              child: Text(
                                primaryText,
                                style: AppTextStyles.size18Weight600.copyWith(color: primaryColor),
                              ),
                            ),
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
