class CatsModel {
  CatsModel({
    int? id,
    String? name,
    String? icon,
    String? image,
    String? text,
    int? bonus,
    int? credit,
    bool? isSelect,
    List<CatSections>? catSections,
    dynamic createdAt,
    dynamic updatedAt,
  }) : _id = id,
       _name = name,
       _icon = icon,
       _image = image,
       _text = text,
       _bonus = bonus,
       _credit = credit,
       _isSelect = isSelect,
       _catSections = catSections,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  CatsModel.fromJson(Map<String, dynamic> json) {
    _id = _asInt(json['id']);
    _name = json['name'] as String?;
    _icon = json['icon'] as String?;
    _image = json['image'] as String?;
    _text = json['text'] as String?;
    _bonus = _asInt(json['bonus']);
    _credit = _asInt(json['credit']);
    _isSelect = json['is_select'] as bool?;
    _catSections = (json['cat_sections'] as List?)
        ?.whereType<Map<String, dynamic>>()
        .map((e) => CatSections.fromJson(e))
        .toList();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  String? _name;
  String? _icon;
  String? _image;
  String? _text;
  int? _bonus;
  bool? _isSelect;
  int? _credit;
  List<CatSections>? _catSections;
  dynamic _createdAt;
  dynamic _updatedAt;

  int? get id => _id;
  String? get name => _name;
  String? get icon => _icon;
  String? get image => _image;
  String? get text => _text;
  int? get bonus => _bonus;
  int? get credit => _credit;
  bool get isSelect => _isSelect ?? false;
  set isSelect(bool value) => _isSelect = value;
  List<CatSections>? get catSections => _catSections;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'icon': _icon,
      'image': _image,
      'text': _text,
      'bonus': _bonus,
      'credit': _credit,
      'is_select': _isSelect,
      'cat_sections': _catSections?.map((e) => e.toJson()).toList(),
      'created_at': _createdAt,
      'updated_at': _updatedAt,
    };
  }

  static int? _asInt(Object? v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is String) return int.tryParse(v);
    return null;
  }

  CatsModel copyWith({
    int? id,
    String? name,
    String? icon,
    String? image,
    String? text,
    int? bonus,
    int? credit,
    bool? isSelect,
    List<CatSections>? catSections,
    dynamic createdAt,
    dynamic updatedAt,
  }) {
    return CatsModel(
      id: id ?? _id,
      name: name ?? _name,
      icon: icon ?? _icon,
      image: image ?? _image,
      text: text ?? _text,
      bonus: bonus ?? _bonus,
      credit: credit ?? _credit,
      isSelect: isSelect ?? _isSelect,
      catSections: catSections ?? _catSections,
      createdAt: createdAt ?? _createdAt,
      updatedAt: updatedAt ?? _updatedAt,
    );
  }
}

class CatSections {
  CatSections({
    int? id,
    int? sectionId,
    int? catId,
    int? subCatId,
    Section? section,
    dynamic createdAt,
    dynamic updatedAt,
  }) : _id = id,
       _sectionId = sectionId,
       _catId = catId,
       _subCatId = subCatId,
       _section = section,
       _createdAt = createdAt,
       _updatedAt = updatedAt;

  CatSections.fromJson(Map<String, dynamic> json) {
    _id = CatsModel._asInt(json['id']);
    _sectionId = CatsModel._asInt(json['section_id']);
    _catId = CatsModel._asInt(json['cat_id']);
    _subCatId = CatsModel._asInt(json['sub_cat_id']);
    final sec = json['section'];
    _section = (sec is Map<String, dynamic>) ? Section.fromJson(sec) : null;
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  int? _sectionId;
  int? _catId;
  int? _subCatId;
  Section? _section;
  dynamic _createdAt;
  dynamic _updatedAt;

  int? get id => _id;
  int? get sectionId => _sectionId;
  int? get catId => _catId;
  int? get subCatId => _subCatId;
  Section? get section => _section;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'section_id': _sectionId, // ← fixed key
      'cat_id': _catId,
      'sub_cat_id': _subCatId,
      'section': _section?.toJson(),
      'created_at': _createdAt,
      'updated_at': _updatedAt,
    };
  }

  CatSections copyWith({
    int? id,
    int? sectionId,
    int? catId,
    int? subCatId,
    Section? section,
    dynamic createdAt,
    dynamic updatedAt,
  }) {
    return CatSections(
      id: id ?? _id,
      sectionId: sectionId ?? _sectionId,
      catId: catId ?? _catId,
      subCatId: subCatId ?? _subCatId,
      section: section ?? _section,
      createdAt: createdAt ?? _createdAt,
      updatedAt: updatedAt ?? _updatedAt,
    );
  }
}

class Section {
  Section({int? id, String? name, dynamic createdAt, dynamic updatedAt})
    : _id = id,
      _name = name,
      _createdAt = createdAt,
      _updatedAt = updatedAt;

  Section.fromJson(Map<String, dynamic> json) {
    _id = CatsModel._asInt(json['id']);
    _name = json['name'] as String?;
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  String? _name;
  dynamic _createdAt;
  dynamic _updatedAt;

  int? get id => _id;
  String? get name => _name;
  dynamic get createdAt => _createdAt;
  dynamic get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    return {'id': _id, 'name': _name, 'created_at': _createdAt, 'updated_at': _updatedAt};
  }

  Section copyWith({int? id, String? name, dynamic createdAt, dynamic updatedAt}) {
    return Section(
      id: id ?? _id,
      name: name ?? _name,
      createdAt: createdAt ?? _createdAt,
      updatedAt: updatedAt ?? _updatedAt,
    );
  }
}
