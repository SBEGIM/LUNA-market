class BasketOrderModel {
  BasketOrderModel({
      int? id, 
      List<Product>? product, 
      int? summa, 
      String? status, 
      String? date, 
      String? returnDate,}){
    _id = id;
    _product = product;
    _summa = summa;
    _status = status;
    _date = date;
    _returnDate = returnDate;
}

  BasketOrderModel.fromJson(dynamic json) {
    _id = json['id'];
    if (json['product'] != null) {
      _product = [];
      json['product'].forEach((v) {
        _product?.add(Product.fromJson(v));
      });
    }
    _summa = json['summa'];
    _status = json['status'];
    _date = json['date'];
    _returnDate = json['return_date'];
  }
  int? _id;
  List<Product>? _product;
  int? _summa;
  String? _status;
  String? _date;
  String? _returnDate;

  int? get id => _id;
  List<Product>? get product => _product;
  int? get summa => _summa;
  String? get status => _status;
  String? get date => _date;
  String? get returnDate => _returnDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_product != null) {
      map['product'] = _product?.map((v) => v.toJson()).toList();
    }
    map['summa'] = _summa;
    map['status'] = _status;
    map['date'] = _date;
    map['return_date'] = _returnDate;
    return map;
  }

}

class Product {
  Product({
      int? id, 
      String? shopName, 
      String? productName, 
      List<String>? path, 
      int? count, 
      int? price, 
      dynamic status, 
      dynamic address, 
      String? shopSchedule,}){
    _id = id;
    _shopName = shopName;
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
    _shopName = json['shop_name'];
    _productName = json['product_name'];
    _path = json['path'] != null ? json['path'].cast<String>() : [];
    _count = json['count'];
    _price = json['price'];
    _status = json['status'];
    _address = json['address'];
    _shopSchedule = json['shop_schedule'];
  }
  int? _id;
  String? _shopName;
  String? _productName;
  List<String>? _path;
  int? _count;
  int? _price;
  dynamic _status;
  dynamic _address;
  String? _shopSchedule;

  int? get id => _id;
  String? get shopName => _shopName;
  String? get productName => _productName;
  List<String>? get path => _path;
  int? get count => _count;
  int? get price => _price;
  dynamic get status => _status;
  dynamic get address => _address;
  String? get shopSchedule => _shopSchedule;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['shop_name'] = _shopName;
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