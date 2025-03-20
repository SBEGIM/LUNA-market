import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:haji_market/src/core/presentation/widgets/buttons/custom_material_button.dart';
import 'package:haji_market/src/core/theme/resources.dart';

enum SuccessAlertDialogLottieType { done, question }

class SuccessAlertDialog extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final EdgeInsets? insetPadding;
  final bool enableCloseButton;
  final SuccessAlertDialogLottieType successAlertDialogLottieType;
  final Widget Function(BuildContext context)? buttonsBuilder;
  final void Function(BuildContext context)? closeButtonOnTap;
  const SuccessAlertDialog({
    super.key,
    this.title,
    this.subtitle,
    this.insetPadding,
    this.enableCloseButton = true,
    required this.successAlertDialogLottieType,
    this.buttonsBuilder,
    this.closeButtonOnTap,
  });

  static Future<void> show(
    BuildContext context, {
    String? title,
    String? subtitle,
    Widget Function(BuildContext context)? buttonsBuilder,
    EdgeInsets? insetPadding,
    bool useRootNavigator = true,
    TextStyle? firstButtonStyle,
    TextStyle? secondButtonStyle,
    bool enableCloseButton = true,
    void Function(BuildContext context)? closeButtonOnTap,
    bool barrierDismissible = true,
    SuccessAlertDialogLottieType successAlertDialogLottieType =
        SuccessAlertDialogLottieType.done,
  }) {
    return showDialog(
      context: context,
      useRootNavigator: useRootNavigator,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => SuccessAlertDialog(
        title: title,
        subtitle: subtitle,
        insetPadding: insetPadding,
        enableCloseButton: enableCloseButton,
        successAlertDialogLottieType: successAlertDialogLottieType,
        buttonsBuilder: buttonsBuilder,
        closeButtonOnTap: closeButtonOnTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      insetPadding: insetPadding ?? const EdgeInsets.symmetric(horizontal: 24),
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24)
            .copyWith(bottom: 14, top: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (enableCloseButton)
              Align(
                alignment: Alignment.topRight,
                child: Transform.translate(
                  offset: const Offset(10, 0),
                  child: CustomMaterialButton(
                    onTap: closeButtonOnTap != null
                        ? () {
                            closeButtonOnTap!(context);
                          }
                        : () {
                            context.router.maybePop();
                          },
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(Assets.icons.close.path),
                  ),
                ),
              ),
            Lottie.asset(
              switch (successAlertDialogLottieType) {
                SuccessAlertDialogLottieType.done => Assets.lottie.done.path,
                SuccessAlertDialogLottieType.question =>
                  Assets.lottie.question.path,
              },
              height: 250,
              fit: BoxFit.cover,
            ),
            if (title != null) ...[
              Text(
                title!,
                textAlign: TextAlign.center,
                style: AppTextStyles.title22W600H26,
              ),
              const Gap(12),
            ],
            if (subtitle != null) ...[
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: AppTextStyles.subheadlineRegular,
              ),
              const Gap(12),
            ],
            if (buttonsBuilder != null) buttonsBuilder!(context),
          ],
        ),
      ),
    );
  }
}
