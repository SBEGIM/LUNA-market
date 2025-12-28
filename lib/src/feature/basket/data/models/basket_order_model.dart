class BasketOrderModel {
  BasketOrderModel({
    int? id,
    int? shopId,
    List<Product>? product,
    int? summa,
    int? chatId,
    String? status,
    int? deliveryDay,
    int? deliveryPrice,
    String? date,
    String? updatedAt,
    String? comment,
    String? returnDate,
    String? expectedDeliveryDate,
    int? currentStep,
    List<BasketStatusStep>? basketStatusTimeline,
  }) {
    _id = id;
    _shopId = shopId;
    _product = product;
    _summa = summa;
    _chatId = chatId;
    _status = status;
    _deliveryDay = deliveryDay;
    _deliveryPrice = deliveryPrice;
    _date = date;
    _updatedAt = updatedAt;
    _comment = comment;
    _returnDate = returnDate;
    _expectedDeliveryDate = expectedDeliveryDate;
    _currentStep = currentStep;
    _basketStatusTimeline = basketStatusTimeline;
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

    _summa = json['summa'];
    _status = json['status'];
    _chatId = json['chat_id'];
    _date = json['date'];
    _deliveryDay = json['delivery_day'];
    _deliveryPrice = json['delivery_price'];
    _updatedAt = json['updated_at'];
    _comment = json['comment'];
    _returnDate = json['return_date'];
    _expectedDeliveryDate = json['expected_delivery_date'];
    _currentStep = json['current_step'];
    if (json['basket_status_timeline'] != null) {
      _basketStatusTimeline = [];
      json['basket_status_timeline'].forEach((v) {
        _basketStatusTimeline?.add(BasketStatusStep.fromJson(v));
      });
    }
  }

  int? _id;
  int? _shopId;
  List<Product>? _product;
  int? _summa;
  int? _chatId;
  String? _status;
  String? _date;
  int? _deliveryDay;
  int? _deliveryPrice;
  String? _updatedAt;
  String? _comment;
  String? _returnDate;
  String? _expectedDeliveryDate;
  int? _currentStep;
  List<BasketStatusStep>? _basketStatusTimeline;

  int? get id => _id;
  int? get shopId => _shopId;
  List<Product>? get product => _product;
  int? get summa => _summa;
  String? get status => _status;
  int? get chatId => _chatId;
  String? get date => _date;
  int? get deliveryDay => _deliveryDay;
  int? get deliveryPrice => _deliveryPrice;
  String? get updated_at => _updatedAt;
  String? get comment => _comment;
  String? get returnDate => _returnDate;
  String? get expectedDeliveryDate => _expectedDeliveryDate;
  int? get currentStep => _currentStep;
  List<BasketStatusStep>? get basketStatusTimeline => _basketStatusTimeline;

  /// copyWith
  BasketOrderModel copyWith({
    int? id,
    int? shopId,
    List<Product>? product,
    int? summa,
    int? chatId,
    String? status,
    int? deliveryDay,
    int? deliveryPrice,
    String? date,
    String? updatedAt,
    String? comment,
    String? returnDate,
    String? expectedDeliveryDate,
    int? currentStep,
    List<BasketStatusStep>? basketStatusTimeline,
  }) {
    return BasketOrderModel(
      id: id ?? _id,
      shopId: shopId ?? _shopId,
      product: product ?? _product,
      summa: summa ?? _summa,
      chatId: chatId ?? _chatId,
      status: status ?? _status,
      deliveryDay: deliveryDay ?? _deliveryDay,
      deliveryPrice: deliveryPrice ?? _deliveryPrice,
      date: date ?? _date,
      updatedAt: updatedAt ?? _updatedAt,
      comment: comment ?? _comment,
      returnDate: returnDate ?? _returnDate,
      expectedDeliveryDate: expectedDeliveryDate ?? _expectedDeliveryDate,
      currentStep: currentStep ?? _currentStep,
      basketStatusTimeline: basketStatusTimeline ?? _basketStatusTimeline,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['shop_id'] = _shopId;

    if (_product != null) {
      map['product'] = _product?.map((v) => v.toJson()).toList();
    }

    map['summa'] = _summa;
    map['chat_id'] = _chatId;
    map['status'] = _status;
    map['date'] = _date;
    map['delivery_day'] = _deliveryDay;
    map['delivery_price'] = _deliveryPrice;
    map['updated_at'] = _updatedAt;
    map['comment'] = _comment;
    map['return_date'] = _returnDate;
    map['expected_delivery_date'] = _expectedDeliveryDate;
    map['current_step'] = _currentStep;
    if (_basketStatusTimeline != null) {
      map['basket_status_timeline'] = _basketStatusTimeline?.map((v) => v.toJson()).toList();
    }

    return map;
  }
}

/// Шаг таймлайна заказа
class BasketStatusStep {
  BasketStatusStep({String? key, int? step, String? title, String? date, bool? isDone}) {
    _key = key;
    _step = step;
    _title = title;
    _date = date;
    _isDone = isDone;
  }

  BasketStatusStep.fromJson(dynamic json) {
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

  BasketStatusStep copyWith({String? key, int? step, String? title, String? date, bool? isDone}) {
    return BasketStatusStep(
      key: key ?? _key,
      step: step ?? _step,
      title: title ?? _title,
      date: date ?? _date,
      isDone: isDone ?? _isDone,
    );
  }

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

  Product copyWith({
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
    return Product(
      id: id ?? _id,
      shopId: shopId ?? _shopId,
      shopName: shopName ?? _shopName,
      shopImage: shopImage ?? _shopImage,
      shopCourier: shopCourier ?? _shopCourier,
      shopCityName: shopCityName ?? _shopCityName,
      shopPhone: shopPhone ?? _shopPhone,
      productId: productId ?? _productId,
      productName: productName ?? _productName,
      path: path ?? _path,
      count: count ?? _count,
      price: price ?? _price,
      status: status ?? _status,
      address: address ?? _address,
      shopSchedule: shopSchedule ?? _shopSchedule,
    );
  }

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
