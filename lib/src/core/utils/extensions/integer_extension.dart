import 'dart:math';

import 'package:intl/intl.dart';

extension IntegerExtension on num? {
  String priceFormat() {
    if (this == null) {
      return '';
    }
    final priceFormatter = NumberFormat();

    return '${priceFormatter.format(this).replaceAll(',', ' ')} ₸';
  }

  String thousandFormat() {
    if (this == null) {
      return '';
    }
    final priceFormatter = NumberFormat();

    return priceFormatter.format(this).replaceAll(',', ' ');
  }

  String formattedTime() {
    if (this == null) return '';

    final sec = this! % 60;
    final min = (this! / 60).floor();
    final minute = min.toString().length <= 1 ? '0$min' : '$min';
    final second = sec.toString().length <= 1 ? '0$sec' : '$sec';
    return '$minute:$second';
  }

  double getVideoProgress(num? videoDuration) {
    if (videoDuration == null || videoDuration == 0) {
      return 0;
    } else {
      return min((this ?? 0) / videoDuration, 1);
    }
  }
}
