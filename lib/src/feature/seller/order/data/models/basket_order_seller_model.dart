class BasketStatusTimelineItem {
  BasketStatusTimelineItem({
    String? key,
    int? step,
    String? title,
    String? date,
    bool? isDone,
  }) {
    _key = key;
    _step = step;
    _title = title;
    _date = date;
    _isDone = isDone;
  }

  BasketStatusTimelineItem.fromJson(dynamic json) {
    _key = json['key'];
    _step = json['step'];
    _title = json['title'];
    _date = json['date'];
    _isDone = json['is_done'];
  }

  String? _key;
  int? _step;
  String? _title;
  String? _date;
  bool? _isDone;

  String? get key => _key;
  int? get step => _step;
  String? get title => _title;
  String? get date => _date;
  bool? get isDone => _isDone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = _key;
    map['step'] = _step;
    map['title'] = _title;
    map['date'] = _date;
    map['is_done'] = _isDone;
    return map;
  }
}

class Product {
  Product({
    int? id,
    int? shopId,
    String? shopName,
    String? shopCityName,
    String? shopAddress,
    int? shopCourier,
    String? shopPhone,
    String? shopImage,
    int? productId,
    String? productName,
    List<String>? path,
    int? count,
    int? price,
    int? optom,
    String? status,
    String? address,
    String? shopSchedule,
  }) {
    _id = id;
    _shopId = shopId;
    _shopName = shopName;
    _shopCityName = shopCityName;
    _shopAddress = shopAddress;
    _shopCourier = shopCourier;
    _shopPhone = shopPhone;
    _shopImage = shopImage;
    _productId = productId;
    _productName = productName;
    _path = path;
    _count = count;
    _price = price;
    _optom = optom;
    _status = status;
    _address = address;
    _shopSchedule = shopSchedule;
  }

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _shopId = json['shop_id'];
    _shopName = json['shop_name'];
    _shopCityName = json['shop_city_name'];
    _shopAddress = json['shop_address'];
    _shopCourier = json['shop_courier'];
    _shopPhone = json['shop_phone'];
    _shopImage = json['shop_image'];
    _productId = json['product_id'];
    _productName = json['product_name'];
    _path = json['path'] != null ? List<String>.from(json['path']) : [];
    _count = json['count'];
    _price = json['price'];
    _optom = json['optom'];
    _status = json['status'];
    _address = json['address'];
    _shopSchedule = json['shop_schedule'];
  }

  int? _id;
  int? _shopId;
  String? _shopName;
  String? _shopCityName;
  String? _shopAddress;
  int? _shopCourier;
  String? _shopPhone;
  String? _shopImage;
  int? _productId;
  String? _productName;
  List<String>? _path;
  int? _count;
  int? _price;
  int? _optom;
  String? _status;
  String? _address;
  String? _shopSchedule;

  int? get id => _id;
  int? get shopId => _shopId;
  String? get shopName => _shopName;
  String? get shopCityName => _shopCityName;
  String? get shopAddress => _shopAddress;
  int? get shopCourier => _shopCourier;
  String? get shopPhone => _shopPhone;
  String? get shopImage => _shopImage;
  int? get productId => _productId;
  String? get productName => _productName;
  List<String>? get path => _path;
  int? get count => _count;
  int? get price => _price;
  int? get optom => _optom;
  String? get status => _status;
  String? get address => _address;
  String? get shopSchedule => _shopSchedule;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['shop_id'] = _shopId;
    map['shop_name'] = _shopName;
    map['shop_city_name'] = _shopCityName;
    map['shop_address'] = _shopAddress;
    map['shop_courier'] = _shopCourier;
    map['shop_phone'] = _shopPhone;
    map['shop_image'] = _shopImage;
    map['product_id'] = _productId;
    map['product_name'] = _productName;
    map['path'] = _path;
    map['count'] = _count;
    map['price'] = _price;
    map['optom'] = _optom;
    map['status'] = _status;
    map['address'] = _address;
    map['shop_schedule'] = _shopSchedule;
    return map;
  }
}

class User {
  User({
    int? id,
    int? cityId,
    String? firstName,
    String? lastName,
    String? surName,
    String? email,
    String? phone,
    String? accessToken,
    String? deviceToken,
    String? deviceType,
    String? avatar,
    num? bonus,
    String? gender,
    int? active,
    int? online,
    String? birthday,
    String? lang,
    int? code,
    int? push,
    String? createdAt,
    String? updatedAt,
    int? userId,
    String? country,
    String? city,
    String? street,
    String? entrance,
    String? floor,
    String? apartament,
    String? intercom,
    String? comment,
  }) {
    _id = id;
    _cityId = cityId;
    _firstName = firstName;
    _lastName = lastName;
    _surName = surName;
    _email = email;
    _phone = phone;
    _accessToken = accessToken;
    _deviceToken = deviceToken;
    _deviceType = deviceType;
    _avatar = avatar;
    _bonus = bonus;
    _gender = gender;
    _active = active;
    _online = online;
    _birthday = birthday;
    _lang = lang;
    _code = code;
    _push = push;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _userId = userId;
    _country = country;
    _city = city;
    _street = street;
    _entrance = entrance;
    _floor = floor;
    _apartament = apartament;
    _intercom = intercom;
    _comment = comment;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _cityId = json['city_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _surName = json['sur_name'];
    _email = json['email'];
    final dynamic phoneRaw = json['phone'];
    _phone = phoneRaw?.toString();
    _accessToken = json['access_token'];
    _deviceToken = json['device_token'];
    _deviceType = json['device_type'];
    _avatar = json['avatar'];
    _bonus = json['bonus'];
    _gender = json['gender'];
    _active = json['active'];
    _online = json['online'];
    _birthday = json['birthday'];
    _lang = json['lang'];
    _code = json['code'];
    _push = json['push'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _userId = json['user_id'];
    _country = json['country'];
    _city = json['city'];
    _street = json['street'];
    _entrance = json['entrance'];
    _floor = json['floor'];
    _apartament = json['apartament'];
    _intercom = json['intercom'];
    _comment = json['comment'];
  }

  int? _id;
  int? _cityId;
  String? _firstName;
  String? _lastName;
  String? _surName;
  String? _email;
  String? _phone;
  String? _accessToken;
  String? _deviceToken;
  String? _deviceType;
  String? _avatar;
  num? _bonus;
  String? _gender;
  int? _active;
  int? _online;
  String? _birthday;
  String? _lang;
  int? _code;
  int? _push;
  String? _createdAt;
  String? _updatedAt;
  int? _userId;
  String? _country;
  String? _city;
  String? _street;
  String? _entrance;
  String? _floor;
  String? _apartament;
  String? _intercom;
  String? _comment;

  int? get id => _id;
  int? get cityId => _cityId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get surName => _surName;
  String? get email => _email;
  String? get phone => _phone;
  String? get accessToken => _accessToken;
  String? get deviceToken => _deviceToken;
  String? get deviceType => _deviceType;
  String? get avatar => _avatar;
  num? get bonus => _bonus;
  String? get gender => _gender;
  int? get active => _active;
  int? get online => _online;
  String? get birthday => _birthday;
  String? get lang => _lang;
  int? get code => _code;
  int? get push => _push;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get userId => _userId;
  String? get country => _country;
  String? get city => _city;
  String? get street => _street;
  String? get entrance => _entrance;
  String? get floor => _floor;
  String? get apartament => _apartament;
  String? get intercom => _intercom;
  String? get comment => _comment;

  // удобный геттер для ФИО, если понадобится
  String get fullName {
    final parts = <String>[];
    if (_lastName != null && _lastName!.isNotEmpty) parts.add(_lastName!);
    if (_firstName != null && _firstName!.isNotEmpty) parts.add(_firstName!);
    if (_surName != null && _surName!.isNotEmpty) parts.add(_surName!);
    return parts.join(' ');
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['city_id'] = _cityId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['sur_name'] = _surName;
    map['email'] = _email;
    map['phone'] = _phone;
    map['access_token'] = _accessToken;
    map['device_token'] = _deviceToken;
    map['device_type'] = _deviceType;
    map['avatar'] = _avatar;
    map['bonus'] = _bonus;
    map['gender'] = _gender;
    map['active'] = _active;
    map['online'] = _online;
    map['birthday'] = _birthday;
    map['lang'] = _lang;
    map['code'] = _code;
    map['push'] = _push;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['user_id'] = _userId;
    map['country'] = _country;
    map['city'] = _city;
    map['street'] = _street;
    map['entrance'] = _entrance;
    map['floor'] = _floor;
    map['apartament'] = _apartament;
    map['intercom'] = _intercom;
    map['comment'] = _comment;
    return map;
  }
}

class BasketOrderSellerModel {
  BasketOrderSellerModel({
    int? id,
    int? shopId,
    List<Product>? product,
    User? user,
    int? chatId,
    int? summa,
    String? status,
    int? bonus,
    int? courier,
    int? deliveryDay,
    int? deliveryPrice,
    int? preOrder,
    String? size,
    String? date,
    String? updatedAt,
    String? comment,
    String? fulfillment,
    String? returnDate,
    String? expectedDeliveryDate,
    int? currentStep,
    List<BasketStatusTimelineItem>? basketStatusTimeline,
  }) {
    _id = id;
    _shopId = shopId;
    _product = product;
    _user = user;
    _chatId = chatId;
    _summa = summa;
    _status = status;
    _bonus = bonus;
    _courier = courier;
    _deliveryDay = deliveryDay;
    _deliveryPrice = deliveryPrice;
    _preOrder = preOrder;
    _size = size;
    _date = date;
    _updatedAt = updatedAt;
    _comment = comment;
    _fulfillment = fulfillment;
    _returnDate = returnDate;
    _expectedDeliveryDate = expectedDeliveryDate;
    _currentStep = currentStep;
    _basketStatusTimeline = basketStatusTimeline;
  }

  BasketOrderSellerModel.fromJson(dynamic json) {
    _id = json['id'];
    _shopId = json['shop_id'];
    if (json['product'] != null) {
      _product = [];
      json['product'].forEach((v) {
        _product?.add(Product.fromJson(v));
      });
    }
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _chatId = json['chat_id'];
    _summa = json['summa'];
    _status = json['status'];
    _comment = json['comment'];
    _bonus = json['bonus'];
    _preOrder = json['pre_order'];
    _courier = json['courier'];
    _deliveryDay = json['delivery_day'];
    _deliveryPrice = json['delivery_price'];
    _size = json['size'];
    _date = json['date'];
    _updatedAt = json['updated_at'];
    _fulfillment = json['fulfillment'];
    _returnDate = json['return_date'];
    _expectedDeliveryDate = json['expected_delivery_date'];
    _currentStep = json['current_step'];
    if (json['basket_status_timeline'] != null) {
      _basketStatusTimeline = [];
      json['basket_status_timeline'].forEach((v) {
        _basketStatusTimeline?.add(BasketStatusTimelineItem.fromJson(v));
      });
    }
  }

  int? _id;
  int? _shopId;
  List<Product>? _product;
  User? _user;
  int? _chatId;
  int? _summa;
  String? _status;
  int? _bonus;
  int? _courier;
  int? _deliveryDay;
  int? _deliveryPrice;
  int? _preOrder;
  String? _size;
  String? _date;
  String? _updatedAt;
  String? _comment;
  String? _fulfillment;
  String? _returnDate;
  String? _expectedDeliveryDate;
  int? _currentStep;
  List<BasketStatusTimelineItem>? _basketStatusTimeline;

  int? get id => _id;
  int? get shopId => _shopId;
  List<Product>? get product => _product;
  User? get user => _user;
  int? get chatId => _chatId;
  int? get summa => _summa;
  String? get status => _status;
  int? get bonus => _bonus;
  int? get courier => _courier;
  int? get deliveryDay => _deliveryDay;
  int? get deliveryPrice => _deliveryPrice;
  int? get preOrder => _preOrder;
  int? get preorder => _preOrder; // чтобы старый код не падал
  String? get size => _size;
  String? get date => _date;
  String? get updatedAt => _updatedAt;
  String? get comment => _comment;
  String? get fulfillment => _fulfillment;
  String? get returnDate => _returnDate;
  String? get expectedDeliveryDate => _expectedDeliveryDate;
  int? get currentStep => _currentStep;
  List<BasketStatusTimelineItem>? get basketStatusTimeline =>
      _basketStatusTimeline;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['shop_id'] = _shopId;
    if (_product != null) {
      map['product'] = _product?.map((v) => v.toJson()).toList();
    }
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['chat_id'] = _chatId;
    map['summa'] = _summa;
    map['status'] = _status;
    map['comment'] = _comment;
    map['bonus'] = _bonus;
    map['pre_order'] = _preOrder;
    map['courier'] = _courier;
    map['delivery_day'] = _deliveryDay;
    map['delivery_price'] = _deliveryPrice;
    map['size'] = _size;
    map['date'] = _date;
    map['updated_at'] = _updatedAt;
    map['fulfillment'] = _fulfillment;
    map['return_date'] = _returnDate;
    map['expected_delivery_date'] = _expectedDeliveryDate;
    map['current_step'] = _currentStep;
    if (_basketStatusTimeline != null) {
      map['basket_status_timeline'] =
          _basketStatusTimeline?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
