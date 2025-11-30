import 'package:flutter/material.dart';
import 'package:haji_market/src/core/presentation/widgets/dialog/toaster.dart';
import 'package:haji_market/src/core/utils/extensions/context_extension.dart';
import 'package:haji_market/src/core/utils/talker_logger_util.dart';

import 'package:url_launcher/url_launcher.dart';

class UrlUtil {
  const UrlUtil._();

  static Future<bool> launch(
    BuildContext context, {
    required String url,
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    try {
      var newUrl = url;
      if (url.length >= 5 && url.substring(0, 5).contains('http')) {
        newUrl = url;
      } else {
        newUrl = 'https://$url';
      }
      final uri = Uri.parse(newUrl);

      return launchUrl(uri, mode: mode);
    } catch (e, st) {
      TalkerLoggerUtil.talker.handle('UrlUtil.launch => $e', st);
      Toaster.showErrorTopShortToast(context, context.localized.invalidLinkFormat);
      return false;
    }
  }

  // static void launchMaybeDeepLink({
  //   required BuildContext context,
  //   required String url,
  // }) {
  //   try {
  //     final uri = Uri.parse(url);

  //     DeepLinkHandler.handle(
  //       uri: uri,
  //       context: context,
  //       isFromLauncher: true,
  //       onUnknownPath: (path) {
  //         Analytics.instance.logLaunchLink(url);
  //         launchUrl(
  //           uri,
  //           mode: LaunchMode.externalApplication,
  //         );
  //       },
  //     );
  //   } catch (e, st) {
  //     ISpectTalker.handle(
  //       exception: 'UrlUtil.launchMaybeDeepLink => $e',
  //       stackTrace: st,
  //     );

  //     Toaster.showErrorTopShort(
  //       context,
  //       L10n.current.invalidLinkFormat,
  //     );
  //   }
  // }

  // static void launchMaybeWebViewPortable({
  //   required BuildContext context,
  //   required String url,
  // }) {
  //   try {
  //     final uri = Uri.parse(url);

  //     WebviewHandlerUtil.handle(
  //       uri: uri,
  //       context: context,
  //       isFromLauncher: true,
  //       onUnknownPath: (path) {
  //         launchUrl(
  //           uri,
  //           mode: LaunchMode.externalApplication,
  //         );
  //       },
  //     );
  //   } catch (e, st) {
  //     ISpectTalker.handle(
  //       exception: 'UrlUtil.launchMaybeDeepLink => $e',
  //       stackTrace: st,
  //     );

  //     Toaster.showErrorTopShort(
  //       context,
  //       L10n.current.invalidLinkFormat,
  //     );
  //   }
  // }

  static Future<bool> launchPhoneUrl(BuildContext context, {required String phone}) async {
    try {
      final phoneLaunchUri = Uri(scheme: 'tel', path: phone);

      return launchUrl(phoneLaunchUri);
    } catch (e, st) {
      TalkerLoggerUtil.talker.handle('UrlUtil.launchPhoneUrl => $e', st);

      Toaster.showErrorTopShortToast(context, context.localized.invalidNumberFormat);
      return false;
    }
  }

  static Future<bool> launchSMSUrl(BuildContext context, {required String phone}) async {
    try {
      final phoneLaunchUri = Uri(scheme: 'sms', path: phone);

      return launchUrl(phoneLaunchUri);
    } catch (e, st) {
      TalkerLoggerUtil.talker.handle('UrlUtil.launchSMSUrl => $e', st);

      Toaster.showErrorTopShortToast(context, context.localized.invalidNumberFormat);
      return false;
    }
  }

  static Future<bool> launchEmailUrl(
    BuildContext context, {
    required String email,
    String? subject,
  }) async {
    try {
      final phoneLaunchUri = Uri(
        scheme: 'mailto',
        path: email,
        query: subject != null ? 'subject=$subject' : null,
      );
      return launchUrl(phoneLaunchUri);
    } catch (e, st) {
      TalkerLoggerUtil.talker.handle('UrlUtil.launchEmailUrl => $e', st);

      Toaster.showErrorTopShortToast(context, context.localized.incorrectEmailFormat);
      return false;
    }
  }

  static Future<bool> launchWhatsappUrl(
    BuildContext context, {
    required String phone,
    String? text,
  }) async {
    final whatsapp = phone;
    final whatappUrlIos = 'https://wa.me/$whatsapp';
    try {
      final Uri phoneLaunchUri = Uri.parse(
        whatappUrlIos,
      ).replace(queryParameters: {if (text != null) 'text': text});

      return launchUrl(phoneLaunchUri, mode: LaunchMode.externalApplication);
    } catch (e, st) {
      TalkerLoggerUtil.talker.handle('UrlUtil.launchWhatsappUrl => $e', st);

      Toaster.showErrorTopShortToast(context, context.localized.invalidNumberFormat);
      return false;
    }
  }

  /// Converts fully qualified YouTube Url to video id.
  ///
  /// If videoId is passed as url then no conversion is done.
  static String? convertUrlToYouTubeId(String url, {bool trimWhitespaces = true}) {
    final result = url.trim();
    if (!result.contains('http') && (result.length == 11)) return url;

    for (final exp in [
      RegExp(r'^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$'),
      RegExp(r'^https:\/\/(?:music\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$'),
      RegExp(r'^https:\/\/(?:www\.|m\.)?youtube\.com\/shorts\/([_\-a-zA-Z0-9]{11}).*$'),
      RegExp(
        r'^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$',
      ),
      RegExp(r'^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$'),
      RegExp(
        r'^https:\/\/(?:www\.|m\.)?youtube\.com\/live\/([_\-a-zA-Z0-9]{11}).*$',
      ), // Added RegExp for live videos
    ]) {
      final Match? match = exp.firstMatch(result);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }
}
