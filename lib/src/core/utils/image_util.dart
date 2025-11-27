import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:haji_market/src/core/presentation/widgets/dialog/toaster.dart';
import 'package:haji_market/src/core/theme/resources.dart';
import 'package:haji_market/src/core/utils/extensions/context_extension.dart';

class ImageUtil {
  ImageUtil._();

  static Widget loadingBuilder(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
    if (loadingProgress == null) {
      return child;
    }
    return const Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: AppColors.mainColor,
        // value: loadingProgress.expectedTotalBytes != null
        //     ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
        //     : null,
      ),
    );
  }

  static Widget cachedLoadingBuilder(BuildContext context, String url, DownloadProgress? progress) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: AppColors.mainColor,
        value: progress?.progress,
      ),
    );
  }

  static Future<bool> checkPermissionStatus(BuildContext context) async {
    try {
      final isAndroid = Platform.isAndroid;

      AndroidDeviceInfo? androidInfo;

      if (isAndroid) {
        androidInfo = await DeviceInfoPlugin().androidInfo;
      }

      final PermissionStatus permissionStatus =
          isAndroid && androidInfo != null && androidInfo.version.sdkInt <= 32
          ? await Permission.storage.request()
          : await Permission.photos.request();

      if (permissionStatus.isGranted) {
        return true;
      } else {
        if (!context.mounted) return false;

        Toaster.showErrorTopShortToast(
          context,
          context.localized.inTheSettingsYouNeedToProvideAccessToThePhoto,
        );

        await Future.delayed(const Duration(milliseconds: 1500));

        await openAppSettings();

        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}
