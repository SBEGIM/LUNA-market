class characteristicsDto {
  final String id;
  final String name;
  final String count;

  const characteristicsDto({
    required this.id,
    required this.name,
    required this.count,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['count'] = count;

    return map;
  }
}
