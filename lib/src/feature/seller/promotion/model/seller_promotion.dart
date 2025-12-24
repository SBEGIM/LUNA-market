import 'package:intl/intl.dart';

/// Lightweight promotion entity for UI mock purposes.
enum PromotionScope { allProducts, manual }

enum PromotionLifecycle { upcoming, active, finished }

class SellerPromotion {
  SellerPromotion({
    required this.id,
    required this.title,
    required this.scope,
    required this.discountPercent,
    required this.startDate,
    required this.endDate,
    this.productNames = const <String>[],
  });

  final String id;
  final String title;
  final PromotionScope scope;
  final int discountPercent;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> productNames;

  PromotionLifecycle get lifecycle {
    final now = DateTime.now();
    if (now.isBefore(startDate)) return PromotionLifecycle.upcoming;
    if (now.isAfter(endDate)) return PromotionLifecycle.finished;
    return PromotionLifecycle.active;
  }

  String get scopeLabel => scope == PromotionScope.allProducts ? 'Все товары' : 'Выбрано вручную';

  String get periodLabel {
    final formatter = DateFormat('dd.MM.yyyy');
    return '${formatter.format(startDate)} - ${formatter.format(endDate)}';
  }

  SellerPromotion copyWith({
    String? id,
    String? title,
    PromotionScope? scope,
    int? discountPercent,
    DateTime? startDate,
    DateTime? endDate,
    List<String>? productNames,
  }) {
    return SellerPromotion(
      id: id ?? this.id,
      title: title ?? this.title,
      scope: scope ?? this.scope,
      discountPercent: discountPercent ?? this.discountPercent,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      productNames: productNames ?? this.productNames,
    );
  }
}
