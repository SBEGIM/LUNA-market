class BasketShowModel {
  BasketShowModel({
    Product? product,
    List<String>? image,
    int? priceCourier,
    int? price,
    int? optom,
    int? userBonus,
    int? basketId,
    int? chatId,
    int? basketCount,
    int? deliveryDay,
    int? deliveryPrice,
    String? fulfillment,
    String? basketColor,
    String? basketSize,
    String? shopName,
    List<String>? address,
  }) {
    _product = product;
    _image = image;
    _priceCourier = priceCourier;
    _price = price;
    _optom = optom;
    _userBonus = userBonus;
    _basketId = basketId;
    _chatId = chatId;
    _basketCount = basketCount;
    _deliveryDay = deliveryDay;
    _deliveryPrice = deliveryPrice;
    _fulfillment = fulfillment;
    _basketColor = basketColor;
    _basketSize = basketSize;
    _shopName = shopName;
    _address = address;
  }

  BasketShowModel.fromJson(dynamic json) {
    _product = json['product'] != null ? Product.fromJson(json['product']) : null;
    _image = json['image'] != null ? json['image'].cast<String>() : [];
    _priceCourier = json['price_courier'];
    _price = json['price'];
    _optom = json['optom'];
    _userBonus = json['user_bonus'];
    _basketId = json['basket_id'];
    _chatId = json['chat_id'];
    _basketCount = json['basket_count'];
    _basketColor = json['basket_color'];
    _basketSize = json['basket_size'];
    _deliveryDay = json['delivery_day'];
    _deliveryPrice = json['delivery_price'];
    _fulfillment = json['fulfillment'];
    _shopName = json['shop_name'];
    if (json['address'] != null) {
      _address = [];
      json['address'].forEach((v) {
        _address!.add(v.toString());
      });
    }
  }
  Product? _product;
  List<String>? _image;
  int? _priceCourier;
  int? _price;
  int? _optom;
  int? _userBonus;
  int? _basketId;
  int? _chatId;
  int? _basketCount;
  String? _basketColor;
  String? _basketSize;
  int? _deliveryDay;
  int? _deliveryPrice;
  String? _fulfillment;
  String? _shopName;
  List<String>? _address;

  Product? get product => _product;
  List<String>? get image => _image;
  int? get priceCourier => _priceCourier;
  int? get price => _price;
  int? get optom => _optom;
  int? get userBonus => _userBonus;
  int? get basketId => _basketId;
  int? get chatId => _chatId;
  int? get basketCount => _basketCount;
  String? get basketColor => _basketColor;
  String? get basketSize => _basketSize;
  int? get deliveryDay => _deliveryDay;
  int? get deliveryPrice => _deliveryPrice;
  String? get fulfillment => _fulfillment;
  String? get shopName => _shopName;
  List<String>? get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_product != null) {
      map['product'] = _product!.toJson();
    }
    map['image'] = _image;
    map['price_courier'] = _priceCourier;
    map['price'] = _price;
    map['optom'] = _optom;
    map['userBonus'] = _userBonus;
    map['basket_id'] = _basketId;
    map['chatId'] = _chatId;
    map['basket_count'] = _basketCount;
    map['basket_color'] = _basketColor;
    map['basket_size'] = _basketSize;
    map['delivery_day'] = _deliveryDay;
    map['delivery_price'] = _deliveryPrice;
    map['fulfillment'] = _fulfillment;
    map['shop_name'] = _shopName;
    if (_address != null) {
      map['address'] = _address!.map((v) => v.toString()).toList();
    }
    return map;
  }
}

class Product {
  Product({
    int? id,
    int? shopId,
    String? name,
    int? price,
    int? count,
    int? preOrder,
    int? compound,
    String? fulfillment,
    int? courierPrice,
  }) {
    _id = id;
    _shopId = shopId;
    _name = name;
    _price = price;
    _count = count;
    _preOrder = preOrder;
    _compound = compound;
    _fulfillment = fulfillment;
    _courierPrice = courierPrice;
  }

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _shopId = json['shop_id'];
    _name = json['name'];
    _price = json['price'];
    _count = json['count'];
    _preOrder = json['pre_order'];
    _compound = json['compound'];
    _fulfillment = json['fulfillment'];
    _courierPrice = json['courier_price'];
  }
  int? _id;
  int? _shopId;
  String? _name;
  int? _price;
  int? _count;
  int? _preOrder;
  int? _compound;
  String? _fulfillment;
  int? _courierPrice;

  int? get id => _id;
  int? get shopId => _shopId;
  String? get name => _name;
  int? get price => _price;
  int? get count => _count;
  int? get preOrder => _preOrder;
  int? get compound => _compound;
  String? get fulfillment => _fulfillment;
  int? get courierPrice => _courierPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['shop_id'] = _shopId;
    map['name'] = _name;
    map['price'] = _price;
    map['count'] = _count;
    map['pre_order'] = _preOrder;
    map['compound'] = _compound;
    map['fulfillment'] = _fulfillment;
    map['courier_price'] = _courierPrice;
    return map;
  }
}
