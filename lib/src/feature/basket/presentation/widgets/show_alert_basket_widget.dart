import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:haji_market/src/core/common/constants.dart';

enum AccountAlertMode { confirm, acknowledge }

Future<bool?> showBasketAlert(
  BuildContext context, {
  // общее
  String? title,
  String? message,
  AccountAlertMode mode = AccountAlertMode.confirm,
  bool barrierDismissible = false,
  // тексты
  String? cancelText,
  String? primaryText,
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
                              if (title != null)
                                Text(
                                  title,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.size18Weight600,
                                ),
                              if (title != null) const SizedBox(height: 8),
                              if (message != null)
                                Text(
                                  message,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.size14Weight500.copyWith(
                                    color: Color(0xff3A3A3C),
                                  ),
                                ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),

                        // кнопочная панель БЕЗ нижнего padding — линии вплотную к низу
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                          child: Container(
                            height: 52,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                top: BorderSide(
                                  color: Color(0xFFD1D1D6),
                                  width: 1,
                                ), // сплошная линия сверху на всю ширину
                              ),
                            ),
                            child: Row(
                              children: [
                                if (cancelText != null)
                                  // левая кнопка + вертикальный разделитель по центру
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () => Navigator.of(ctx).pop(false),
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        foregroundColor: Colors.black,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        ),
                                      ),
                                      child: Text(
                                        cancelText,
                                        style: AppTextStyles.size18Weight600.copyWith(
                                          color: Color(0xff636366),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (cancelText != null)
                                  const VerticalDivider(
                                    // та самая линия по центру, тянется на всю высоту 46
                                    width: 0,
                                    thickness: 1,
                                    color: Color(0xFFD1D1D6),
                                  ),
                                if (primaryText != null)
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () => Navigator.of(ctx).pop(true),
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        foregroundColor: primaryColor ?? Color(0xffFF3347),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        ),
                                      ),
                                      child: Text(
                                        primaryText,
                                        style: AppTextStyles.size18Weight600.copyWith(
                                          color: primaryColor ?? AppColors.mainRedColor,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
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
