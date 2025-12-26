import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class FilterProvider extends ChangeNotifier {
  final _box = GetStorage();

  // текущее состояние фильтров
  bool rating = false;
  int catId = 0;
  String? search;

  double? minPrice;
  double? maxPrice;

  int priceAsc = 0;
  int priceDesc = 0;
  int orderByNew = 0;
  int orderByPopular = 0;

  List<int> brandIds = [];
  List<int> shopIds = [];
  List<int> subCatIds = [];

  List<int> characteristicIds = [];

  String? delivery; // "one_day", "two_day", "three_day", "seven_day"

  FilterProvider() {
    _loadFromStorage();
  }

  // ---------- публичные сеттеры фильтров (UI будет вызывать их) ----------

  void setDelivery(String code) {
    delivery = code;
    _box.write('dellivery', code);
    notifyListeners();
  }

  void setSort(String sortKey) {
    // сброс
    priceAsc = 0;
    priceDesc = 0;
    orderByNew = 0;
    orderByPopular = 0;
    rating = false;

    switch (sortKey) {
      case 'priceAsc':
        priceAsc = 1;
        break;
      case 'priceDesc':
        priceDesc = 1;
        break;
      case 'orderByNew':
        orderByNew = 1;
        break;
      case 'orderByPopular':
        orderByPopular = 1;
        break;
      case 'rating':
        rating = true;
        break;
    }

    _box.write('sortFilter', sortKey);
    _box.write('ratingFilter', rating);
    notifyListeners();
  }

  void setCategory(int id) {
    catId = id;
    _box.write('CatId', id);
    notifyListeners();
  }

  void setSearch(String? text) {
    search = (text == null || text.isEmpty) ? null : text;
    _box.write('search', search ?? '');
    notifyListeners();
  }

  void setPriceRange(RangeValues range) {
    minPrice = range.start;
    maxPrice = range.end;

    _box.write('priceFilter', {'start': range.start, 'end': range.end});

    notifyListeners();
  }

  void setBrands(List<int> ids) {
    brandIds = ids;
    _box.write('brandFilterId', jsonEncode(ids));
    notifyListeners();
  }

  void setChar(List<int> ids) {
    characteristicIds = ids;
    _box.write('charFilterId', jsonEncode(ids));
    notifyListeners();
  }

  void setShops(List<int> ids) {
    shopIds = ids;
    _box.write('shopFilterId', jsonEncode(ids));
    notifyListeners();
  }

  void setSubCats(List<int> ids) {
    subCatIds = ids;
    _box.write('subCatFilterId', jsonEncode(ids));
    notifyListeners();
  }

  void resetSubCats() {
    subCatIds.clear();
    _box.remove('subCatFilterId');
    notifyListeners();
  }

  void resetBrands() {
    brandIds.clear();
    _box.remove('brandFilterId');
    notifyListeners();
  }

  void resetChar() {
    characteristicIds.clear();
    _box.remove('charFilterId');
    notifyListeners();
  }

  void resetAll({bool notify = true}) {
    rating = false;
    catId = 0;
    search = null;

    minPrice = null;
    maxPrice = null;

    priceAsc = 0;
    priceDesc = 0;
    orderByNew = 0;
    orderByPopular = 0;

    brandIds.clear();
    shopIds.clear();
    subCatIds.clear();

    delivery = null;

    _box.remove('priceFilter');
    _box.remove('search');
    _box.remove('brandFilterId');
    _box.remove('shopFilterId');
    _box.remove('subCatFilterId');
    _box.remove('charFilterId');
    _box.remove('CatId');
    _box.remove('sortFilter');
    _box.remove('ratingFilter');
    _box.remove('dellivery');

    notifyListeners();

    if (notify) notifyListeners();
  }

  // ---------- билдим queryParams для API ----------

  Map<String, dynamic> toQueryParams({required int page}) {
    final params = <String, dynamic>{};

    // массивы превращаем в brand_id[0], brand_id[1], ...
    for (var i = 0; i < shopIds.length; i++) {
      if (shopIds[i] != 0) {
        params['shop_id[$i]'] = shopIds[i].toString();
      } else {
        shopIds.remove(shopIds[i]);
      }
    }
    for (var i = 0; i < brandIds.length; i++) {
      if (brandIds[i] != 0) {
        params['brand_id[$i]'] = brandIds[i].toString();
      } else {
        brandIds.remove(brandIds[i]);
      }
    }
    for (var i = 0; i < subCatIds.length; i++) {
      if (subCatIds[i] != 1) {
        if (subCatIds[i] != 0) {
          params['sub_cat_id[$i]'] = subCatIds[i].toString();
        } else {
          subCatIds.remove(subCatIds[i]);
        }
      }
    }

    for (var i = 0; i < characteristicIds.length; i++) {
      if (characteristicIds[i] != 0) {
        params['characteristic_id[$i]'] = characteristicIds[i].toString();
      } else {
        characteristicIds.remove(characteristicIds[i]);
      }
    }

    params.addAll({
      "rating": rating.toString(), // "true"/"false"
      "cat_id": catId.toString(),
      "search": search, // может быть null
      "min_price": minPrice?.toString() ?? "null",
      "max_price": maxPrice?.toString() ?? "null",
      "price_asc": priceAsc.toString(),
      "price_desc": priceDesc.toString(),
      "order_by_new": orderByNew.toString(),
      "order_by_popular": orderByPopular.toString(),
      "dellivery": delivery, // может быть null
      "page": page.toString(),
    });

    return params;
  }

  // ---------- приватное восстановление из GetStorage ----------

  void _loadFromStorage() {
    // priceFilter
    if (_box.hasData('priceFilter')) {
      final pf = _box.read('priceFilter');

      if (pf is Map) {
        // новый корректный формат
        final start = pf['start'];
        final end = pf['end'];
        if (start is num) minPrice = start.toDouble();
        if (end is num) maxPrice = end.toDouble();
      } else if (pf is RangeValues) {
        // СТАРЫЙ формат (прямо RangeValues в боксе). Надо мигрировать.
        minPrice = pf.start;
        maxPrice = pf.end;

        _box.write('priceFilter', {'start': pf.start, 'end': pf.end});
      } else {
        // мусор — просто не используем
      }
    }

    // search
    if (_box.hasData('search')) {
      final s = _box.read('search');
      if (s is String && s.isNotEmpty) {
        search = s;
      }
    }

    // brandIds
    if (_box.hasData('brandFilterId')) {
      final raw = _box.read('brandFilterId');
      try {
        brandIds = (json.decode(raw) as List).cast<int>();
      } catch (_) {}
    }

    // subCatIds
    if (_box.hasData('subCatFilterId')) {
      final raw = _box.read('subCatFilterId');
      try {
        subCatIds = (json.decode(raw) as List).cast<int>();
      } catch (_) {}
    }

    // shopIds
    if (_box.hasData('shopFilterId')) {
      final raw = _box.read('shopFilterId');
      try {
        shopIds = (json.decode(raw) as List).cast<int>();
      } catch (_) {}
    }

    // cat id
    if (_box.hasData('CatId')) {
      final cid = _box.read('CatId');
      if (cid is int) {
        catId = cid;
      }
    }

    // rating / sort
    if (_box.hasData('ratingFilter')) {
      rating = _box.read('ratingFilter') == true;
    }

    if (_box.hasData('sortFilter')) {
      // setSort() делает notifyListeners,
      // а нам в конструкторе notifyListeners не критичен, но допустим.
      final sortKey = _box.read('sortFilter');
      if (sortKey is String) {
        setSort(sortKey);
      }
    }

    // delivery
    if (_box.hasData('dellivery')) {
      delivery = _box.read('dellivery')?.toString();
    }
  }
}
