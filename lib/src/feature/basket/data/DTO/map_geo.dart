class MapGeo {
  final double lat;
  final double long;
  final String address;
  final String? second;

  const MapGeo({
    required this.address,
    required this.lat,
    required this.long,
    this.second,
  });
}
