class BasketOrderSellerModel {
  BasketOrderSellerModel({
    int? id,
    List<Product>? product,
    List<Product>? productFBS,
    List<Product>? productRealFBS,
    User? user,
    int? chatId,
    int? summa,
    int? priceFBS,
    int? priceRealFBS,
    String? status,
    String? statusFBS,
    String? statusRealFBS,
    int? bonus,
    int? courier,
    int? deliveryDay,
    int? deliveryPrice,
    int? preorder,
    String? size,
    String? date,
    String? comment,
    String? fulfillment,
    String? returnDate,
  }) {
    _id = id;
    _product = product;
    _productFBS = productFBS;
    _productRealFBS = productRealFBS;
    _user = user!;
    _chatId = chatId;
    _summa = summa;
    _priceFBS = priceFBS;
    _priceRealFBS = priceRealFBS;
    _size = size;
    _status = status;
    _statusFBS = statusFBS;
    _statusRealFBS = statusRealFBS;
    _productFBS = productFBS;
    _productRealFBS = productRealFBS;
    _bonus = bonus;
    _courier = courier;
    _deliveryDay = deliveryDay;
    _deliveryPrice = deliveryPrice;
    _preorder = preorder;
    _date = date;
    _fulfillment = fulfillment;
    _returnDate = returnDate;
  }

  BasketOrderSellerModel.fromJson(dynamic json) {
    _id = json['id'];
    if (json['product'] != null) {
      _product = [];
      json['product'].forEach((v) {
        _product?.add(Product.fromJson(v));
      });
    }
    if (json['product_fbs'] != null) {
      _productFBS = [];
      json['product_fbs'].forEach((v) {
        _productFBS?.add(Product.fromJson(v));
      });
    }
    if (json['product_realFBS'] != null) {
      _productRealFBS = [];
      json['product_realFBS'].forEach((v) {
        _productRealFBS?.add(Product.fromJson(v));
      });
    }
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _chatId = json['chat_id'];
    _summa = json['summa'];
    _priceFBS = json['price_fbs'];
    _priceRealFBS = json['price_realFBS'];
    _status = json['status'];
    _statusFBS = json['status_fbs'];
    _statusRealFBS = json['status_realFBS'];
    _bonus = json['bonus'];
    _preorder = json['pre_order'];
    _courier = json['courier'];
    _deliveryDay = json['delivery_day'];
    _deliveryPrice = json['delivery_price'];
    _size = json['size'];
    _date = json['date'];
    _comment = json['comment'];
    _fulfillment = json['fulfillment'];
    _returnDate = json['return_date'];
  }
  int? _id;
  List<Product>? _product;
  List<Product>? _productFBS;
  List<Product>? _productRealFBS;
  User? _user;
  int? _chatId;
  int? _summa;
  String? _status;
  String? _statusFBS;
  String? _statusRealFBS;
  int? _priceFBS;
  int? _priceRealFBS;
  int? _bonus;
  int? _preorder;
  int? _courier;
  int? _deliveryDay;
  int? _deliveryPrice;
  String? _size;
  String? _date;
  String? _comment;
  String? _fulfillment;
  String? _returnDate;

  int? get id => _id;
  List<Product>? get product => _product;
  List<Product>? get productFBS => _productFBS;
  List<Product>? get productRealFBS => _productRealFBS;
  User? get user => _user;
  int? get chatId => _chatId;
  int? get summa => _summa;
  int? get priceFBS => _priceFBS;
  int? get priceRealFBS => _priceRealFBS;
  int? get bonus => _bonus;
  int? get preorder => _preorder;
  int? get courier => _courier;
  int? get deliveryDay => _deliveryDay;
  int? get deliveryPrice => _deliveryPrice;
  String? get status => _status;
  String? get statusFBS => _statusFBS;
  String? get statusRealFBS => _statusRealFBS;
  String? get size => _size;
  String? get date => _date;
  String? get comment => _comment;
  String? get fulfillment => _fulfillment;
  String? get returnDate => _returnDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_product != null) {
      map['product'] = _product?.map((v) => v.toJson()).toList();
    }
    if (_productFBS != null) {
      map['product_fbs'] = _productFBS?.map((v) => v.toJson()).toList();
    }
    if (_productRealFBS != null) {
      map['product_realFBS'] = _productRealFBS?.map((v) => v.toJson()).toList();
    }
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['chatId'] = _chatId;
    map['summa'] = _summa;
    map['price_fbs'] = _priceFBS;
    map['price_realFBS'] = _priceRealFBS;
    map['size'] = _size;
    map['status'] = _status;
    map['status_fbs'] = _statusFBS;
    map['status_realFBS'] = _statusRealFBS;
    map['bonus'] = _bonus;
    map['preorder'] = _preorder;
    map['courier'] = _courier;
    map['delivery_day'] = _deliveryDay;
    map['delivery_price'] = _deliveryPrice;
    map['date'] = _date;
    map['comment'] = _comment;
    map['fulfillment'] = _fulfillment;
    map['return_date'] = _returnDate;
    return map;
  }
}

class Product {
  Product({
    int? id,
    String? shopName,
    String? shopAddress,
    int? shopCourier,
    String? shopPhone,
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
    _shopName = shopName;
    _shopAddress = shopAddress;
    _shopCourier = shopCourier;
    _shopPhone = shopPhone;
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
    _shopName = json['shop_name'];
    _shopAddress = json['shop_address'];
    _shopPhone = json['shop_phone'];
    _shopCourier = json['shop_courier'];
    _productName = json['product_name'];
    _path = json['path'] != null ? json['path'].cast<String>() : [];
    _count = json['count'];
    _price = json['price'];
    _optom = json['optom'];
    _status = json['status'];
    _address = json['address'];
    _shopSchedule = json['shop_schedule'];
  }
  int? _id;
  String? _shopName;
  String? _shopAddress;
  int? _shopCourier;
  String? _shopPhone;
  String? _productName;
  List<String>? _path;
  int? _count;
  int? _price;
  int? _optom;
  String? _status;
  String? _address;
  String? _shopSchedule;

  int? get id => _id;
  String? get shopName => _shopName;
  String? get shopAddress => _shopAddress;
  int? get shopCourier => _shopCourier;
  String? get shopPhone => _shopPhone;
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
    map['shop_name'] = _shopName;
    map['shop_address'] = _shopAddress;
    map['shop_phone'] = _shopPhone;
    map['shop_courier'] = _shopCourier;
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
    String? name,
    int? phone,
    String? avatar,
    String? city,
    String? street,
    String? home,
    String? porch,
    String? floor,
    String? room,
  }) {
    _id = id;
    _name = name;
    _phone = phone;
    _avatar = avatar;
    _city = city;
    _street = street;
    _home = home;
    _porch = porch;
    _floor = floor;
    _room = room;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _phone = json['phone'];
    _avatar = json['avatar'];
    _city = json['city'];
    _street = json['street'];
    _home = json['home'];
    _porch = json['porch'];
    _floor = json['floor'];
    _room = json['room'];
  }
  int? _id;
  String? _name;
  int? _phone;
  String? _avatar;
  String? _city;
  String? _street;
  String? _home;
  String? _porch;
  String? _floor;
  String? _room;

  int? get id => _id;
  String? get name => _name;
  int? get phone => _phone;
  String? get avatar => _avatar;
  String? get city => _city;
  String? get street => _street;
  String? get home => _home;
  String? get porch => _porch;
  String? get floor => _floor;
  String? get room => _room;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['phone'] = _phone;
    map['avatar'] = avatar;
    map['city'] = city;
    map['street'] = street;
    map['home'] = _home;
    map['porch'] = _porch;
    map['floor'] = _floor;
    map['room'] = _room;

    return map;
  }
}
