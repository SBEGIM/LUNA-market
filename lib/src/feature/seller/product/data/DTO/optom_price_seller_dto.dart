class OptomPriceSellerDto {
  final String count;
  final String price;
  final String total;

  const OptomPriceSellerDto(
      {required this.count, required this.price, required this.total});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    map['price'] = price;
    map['total'] = total;

    return map;
  }
}
