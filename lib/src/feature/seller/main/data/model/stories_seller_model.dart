class SellerStoriesModel {
  final int id;
  final String? title;
  final String image;
  final int? position;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<SellerStoriesItemModel> stories;

  SellerStoriesModel({
    required this.id,
    this.title,
    required this.image,
    this.position,
    this.createdAt,
    this.updatedAt,
    required this.stories,
  });

  factory SellerStoriesModel.fromJson(Map<String, dynamic> json) {
    return SellerStoriesModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      position: json['position'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      stories: (json['stories'] as List)
          .map((item) => SellerStoriesItemModel.fromJson(item))
          .toList(),
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
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
