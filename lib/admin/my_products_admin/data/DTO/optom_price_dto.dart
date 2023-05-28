class optomPriceDto {
  final String count;
  final String price;

  const optomPriceDto({
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
