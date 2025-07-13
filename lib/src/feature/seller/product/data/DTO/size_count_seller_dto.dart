class SizeCountSellerDto {
  final String id;
  final String name;
  final String count;

  const SizeCountSellerDto({
    required this.id,
    required this.name,
    required this.count,
  });

  SizeCountSellerDto copyWith({
    String? id,
    String? name,
    String? count,
  }) {
    return SizeCountSellerDto(
      id: id ?? this.id,
      name: name ?? this.name,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'count': count,
    };
  }
}
