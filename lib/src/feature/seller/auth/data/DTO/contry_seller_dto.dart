class CountrySellerDto {
  final String name;
  final String code; // например, +7
  final String flagPath;

  CountrySellerDto({required this.name, required this.code, required this.flagPath});

  String get displayName => '$name $code';
}
