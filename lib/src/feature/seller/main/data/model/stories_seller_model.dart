class SellerStoriesModel {
  final int id;
  final String? title;
  final String image;
  final int? position;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<SellerStoriesItemModel> stories;
  final bool? isView; // 👈 локальный флаг

  SellerStoriesModel({
    required this.id,
    this.title,
    required this.image,
    this.position,
    this.createdAt,
    this.updatedAt,
    required this.stories,
    this.isView = false, // 👈 по умолчанию
  });

  factory SellerStoriesModel.fromJson(Map<String, dynamic> json) {
    return SellerStoriesModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      position: json['position'],
      isView: json['is_view'],
      createdAt: DateTime.tryParse(json['created_at'] ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
      stories: (json['stories'] as List)
          .map((item) => SellerStoriesItemModel.fromJson(item))
          .toList(),
    );
  }

  SellerStoriesModel copyWith({
    int? id,
    String? title,
    String? image,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<SellerStoriesItemModel>? stories,
    bool? isView,
  }) {
    return SellerStoriesModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      stories: stories ?? this.stories,
      isView: isView ?? this.isView,
    );
  }
}

class SellerStoriesItemModel {
  final int id;
  final int storiesId;
  final String image;
  final String? title;
  final String? description;
  final String? link;
  final int? view;
  final int? click;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool? isView; // 👈 локальный флаг

  SellerStoriesItemModel({
    required this.id,
    required this.storiesId,
    required this.image,
    this.title,
    this.description,
    this.link,
    this.view,
    this.click,
    required this.createdAt,
    required this.updatedAt,
    this.isView, // 👈 по умолчанию
  });

  factory SellerStoriesItemModel.fromJson(Map<String, dynamic> json) {
    return SellerStoriesItemModel(
      id: json['id'],
      storiesId: json['stories_id'],
      image: json['image'],
      title: json['title'],
      description: json['description'],
      link: json['link'],
      view: json['view'],
      click: json['click'],
      isView: json['is_view'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  SellerStoriesItemModel copyWith({
    int? id,
    int? storiesId,
    String? image,
    String? title,
    String? description,
    String? link,
    int? view,
    int? click,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isView,
  }) {
    return SellerStoriesItemModel(
      id: id ?? this.id,
      storiesId: storiesId ?? this.storiesId,
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
      link: link ?? this.link,
      view: view ?? this.view,
      click: click ?? this.click,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isView: isView ?? this.isView,
    );
  }
}
