import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlUtil {
  UrlUtil._();

  static Future<bool> launch(
    BuildContext context, {
    required String url,
  }) async {
    try {
      final uri = Uri.parse(url);

      return launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      log('$e', name: 'UrlUtil');
      return false;
    }
  }

  static Future<bool> launchPhoneUrl(
    BuildContext context, {
    required String phone,
  }) async {
    try {
      final Uri phoneLaunchUri = Uri(
        scheme: 'tel',
        path: phone,
      );

      return launchUrl(phoneLaunchUri);
    } catch (e) {
      log('$e', name: 'UrlUtil');

      return false;
    }
  }
}
