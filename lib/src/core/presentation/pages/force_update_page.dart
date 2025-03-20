import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:haji_market/src/core/constant/localization/localization.dart';
import 'package:haji_market/src/core/presentation/widgets/buttons/custom_button.dart';
import 'package:haji_market/src/core/theme/resources.dart';
import 'package:haji_market/src/core/utils/extensions/context_extension.dart';

class ForceUpdatePage extends StatelessWidget {
  const ForceUpdatePage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.error,
    this.stackTrace,
  });

  factory ForceUpdatePage.forceUpdate({
    required Future<void> Function() onTap,
  }) =>
      ForceUpdatePage(
        title: Localization.currentLocalizations.updateTheApplication,
        subtitle: Localization
            .currentLocalizations.theCurrentVersionTheApplicationInvalid,
        icon: Assets.images.webp.forceUpdate.path,
        onTap: onTap,
      );

  factory ForceUpdatePage.noInternet({
    required Future<void> Function() onTap,
  }) =>
      ForceUpdatePage(
        title: Localization.currentLocalizations.noInternetConnection,
        subtitle: Localization
            .currentLocalizations.checkConnectionYourWiFSonyaPhoneTryAgain,
        icon: Assets.images.webp.noInternet.path,
        onTap: onTap,
      );

  factory ForceUpdatePage.noAvailable({
    required Future<void> Function() onTap,
    Object? error,
    StackTrace? stackTrace,
    String? title,
    String? subtitle,
  }) =>
      ForceUpdatePage(
        title: title ??
            Localization
                .currentLocalizations.theServiceIsTemporarilyUnavailable,
        subtitle: subtitle ??
            Localization.currentLocalizations.thisProcessWorksPleaseAgainLater,
        icon: Assets.images.webp.appNotAvailable.path,
        onTap: onTap,
        error: error,
        stackTrace: stackTrace,
      );

  factory ForceUpdatePage.lowInternetConnection({
    required Future<void> Function() onTap,
  }) =>
      ForceUpdatePage(
        title: Localization.currentLocalizations.weakInternetConnection,
        subtitle: Localization
            .currentLocalizations.checkYourInternetConnectionTryAgainLater,
        icon: Assets.images.webp.weakInternetConnection.path,
        onTap: onTap,
      );

  final String title;
  final String subtitle;
  final String icon;
  final Future<void> Function() onTap;

  /// The error that caused the initialization to fail.
  final Object? error;

  /// The stack trace of the error that caused the initialization to fail.
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SvgPicture.asset(
                Assets.images.svg.topGreenCurveContainer.path,
                width: context.screenSize.width,
                fit: BoxFit.fitWidth,
              ),
              Positioned(
                bottom: 75,
                right: 25,
                left: 25,
                child: Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.title24Semibold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const Gap(16),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.title18w500
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          if (kDebugMode && error != null && stackTrace != null) ...[
            Text('$error'),
            Text('$stackTrace'),
          ] else
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Image.asset(icon),
            ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
                bottom: MediaQuery.viewPaddingOf(context).bottom + 20),
            child: CustomButton(
              onPressed: onTap,
              style: null,
              text: context.localized.update,
              child: null,
            ),
          ),
        ],
      ),
    );
  }
}
