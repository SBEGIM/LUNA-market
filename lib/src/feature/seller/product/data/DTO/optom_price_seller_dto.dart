class OptomPriceSellerDto {
  final String count;
  final String price;

  const OptomPriceSellerDto({
    required this.count,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['price'] = price;

    return map;
  }
}
