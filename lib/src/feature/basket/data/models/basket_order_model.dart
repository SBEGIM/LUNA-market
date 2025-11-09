class BasketOrderModel {
  BasketOrderModel({
    int? id,
    int? shopId,
    List<Product>? product,
    List<Product>? productFBS,
    List<Product>? productRealFBS,
    int? summa,
    int? priceFBS,
    int? priceRealFBS,
    int? chatId,
    String? status,
    String? statusFBS,
    String? statusRealFBS,
    int? deliveryDay,
    int? deliveryPrice,
    String? date,
    String? updated_at,
    String? comment,
    String? returnDate,
  }) {
    _id = id;
    _shopId = shopId;
    _product = product;
    _productFBS = productFBS;
    _productRealFBS = productRealFBS;
    _summa = summa;
    _priceFBS = priceFBS;
    _priceRealFBS = priceRealFBS;
    _chatId = chatId;
    _status = status;
    _statusFBS = statusFBS;
    _statusRealFBS = _statusRealFBS;
    _deliveryDay = deliveryDay;
    _deliveryPrice = deliveryPrice;
    _date = date;
    _updated_at = updated_at;
    _comment = comment;
    _returnDate = returnDate;
  }

  BasketOrderModel.fromJson(dynamic json) {
    _id = json['id'];
    _shopId = json['shop_id'];
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
    _summa = json['summa'];
    _priceFBS = json['price_fbs'];
    _priceRealFBS = json['price_realFBS'];
    _status = json['status'];
    _statusFBS = json['status_fbs'];
    _statusRealFBS = json['status_realFBS'];
    _chatId = json['chat_id'];
    _date = json['date'];
    _deliveryDay = json['delivery_day'];
    _deliveryPrice = json['delivery_price'];
    _updated_at = json['updated_at'];
    _comment = json['comment'];
    _returnDate = json['return_date'];
  }
  int? _id;
  int? _shopId;
  List<Product>? _product;
  List<Product>? _productFBS;
  List<Product>? _productRealFBS;
  int? _summa;
  int? _priceFBS;
  int? _priceRealFBS;
  int? _chatId;
  String? _status;
  String? _statusFBS;
  String? _statusRealFBS;
  String? _date;
  int? _deliveryDay;
  int? _deliveryPrice;
  String? _updated_at;
  String? _comment;
  String? _returnDate;

  int? get id => _id;
  int? get shopId => _shopId;
  List<Product>? get product => _product;
  List<Product>? get productFBS => _productFBS;
  List<Product>? get productRealFBS => _productRealFBS;
  int? get summa => _summa;
  int? get priceFBS => _priceFBS;
  int? get priceRealFBS => _priceRealFBS;
  String? get status => _status;
  String? get statusFBS => _statusFBS;
  String? get statusRealFBS => _statusRealFBS;
  int? get chatId => _chatId;
  String? get date => _date;
  int? get deliveryDay => _deliveryDay;
  int? get deliveryPrice => _deliveryPrice;
  String? get updated_at => _updated_at;
  String? get comment => _comment;
  String? get returnDate => _returnDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['shop_id'] = _shopId;
    if (_product != null) {
      map['product'] = _product?.map((v) => v.toJson()).toList();
    }
    if (_productFBS != null) {
      map['product_fbs'] = _productFBS?.map((v) => v.toJson()).toList();
    }
    if (_productRealFBS != null) {
      map['product_realFBS'] = _productRealFBS?.map((v) => v.toJson()).toList();
    }
    map['summa'] = _summa;
    map['price_FBS'] = _priceFBS;
    map['price_realFBS'] = _priceRealFBS;
    map['chatId'] = _chatId;
    map['status'] = _status;
    map['status_fbs'] = _statusFBS;
    map['status_realFBS'] = _statusRealFBS;
    map['date'] = _date;
    map['deliveryDay'] = _deliveryDay;
    map['deliveryPrice'] = _deliveryPrice;
    map['updated_at'] = _updated_at;
    map['comment'] = _comment;
    map['return_date'] = _returnDate;
    return map;
  }
}

class Product {
  Product({
    int? id,
    int? shopId,
    String? shopName,
    String? shopImage,
    int? shopCourier,
    String? shopCityName,
    String? shopPhone,
    int? productId,
    String? productName,
    List<String>? path,
    int? count,
    int? price,
    String? status,
    String? address,
    String? shopSchedule,
  }) {
    _id = id;
    _shopId = shopId;
    _shopName = shopName;
    _shopImage = shopImage;
    _shopCourier = shopCourier;
    _shopPhone = shopPhone;
    _shopCityName = shopCityName;
    _productId = productId;
    _productName = productName;
    _path = path;
    _count = count;
    _price = price;
    _status = status;
    _address = address;
    _shopSchedule = shopSchedule;
  }

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _shopId = json['shop_id'];
    _shopName = json['shop_name'];
    _shopImage = json['shop_image'];
    _shopPhone = json['shop_phone'];
    _shopCourier = json['shop_courier'];
    _productId = json['product_id'];
    _productName = json['product_name'];
    _shopCityName = json['shop_city_name'];
    _path = json['path'] != null ? json['path'].cast<String>() : [];
    _count = json['count'];
    _price = json['price'];
    _status = json['status'];
    _address = json['address'];
    _shopSchedule = json['shop_schedule'];
  }
  int? _id;
  int? _shopId;
  String? _shopName;
  String? _shopImage;
  int? _shopCourier;
  String? _shopCityName;
  String? _shopPhone;
  int? _productId;
  String? _productName;
  List<String>? _path;
  int? _count;
  int? _price;
  String? _status;
  String? _address;
  String? _shopSchedule;

  int? get id => _id;
  int? get shopId => _shopId;
  String? get shopName => _shopName;
  String? get shopImage => _shopImage;
  String? get shopCityName => _shopCityName;
  int? get shopCourier => _shopCourier;
  String? get shopPhone => _shopPhone;
  int? get productId => _productId;
  String? get productName => _productName;
  List<String>? get path => _path;
  int? get count => _count;
  int? get price => _price;
  String? get status => _status;
  String? get address => _address;
  String? get shopSchedule => _shopSchedule;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['shop_id'] = _shopId;
    map['shop_name'] = _shopName;
    map['shopImage'] = _shopImage;
    map['shopCityName'] = _shopCityName;
    map['shop_phone'] = _shopPhone;
    map['shop_courier'] = _shopCourier;
    map['product_id'] = _productId;
    map['product_name'] = _productName;
    map['path'] = _path;
    map['count'] = _count;
    map['price'] = _price;
    map['status'] = _status;
    map['address'] = _address;
    map['shop_schedule'] = _shopSchedule;
    return map;
  }
}
