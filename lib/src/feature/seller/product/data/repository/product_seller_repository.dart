import 'dart:convert';
import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/seller/product/data/DTO/optom_price_seller_dto.dart';
import 'package:haji_market/src/feature/seller/product/data/models/ad_seller_model.dart';
import 'package:http/http.dart' as http;
import '../DTO/size_count_seller_dto.dart';
import '../models/product_seller_model.dart';

const baseUrl = 'https://lunamarket.ru/api';

class ProductSellerRepository {
  final ProductToApi _productToApi = ProductToApi();

  Future<dynamic> store(
          String price,
          String count,
          String compound,
          String catId,
          String? subCatId,
          String? brandId,
          String colorId,
          String description,
          String name,
          String height,
          String width,
          String massa,
          String point,
          String pointBlogger,
          String articul,
          String currency,
          bool isSwitchedBs,
          String deep,
          List<dynamic>? image,
          List<OptomPriceSellerDto> optom,
          List<SizeCountSellerDto> size,
          fulfillment,
          List<int>? subIds,
          String? video) =>
      _productToApi.store(
          price,
          count,
          compound,
          catId,
          subCatId,
          brandId,
          colorId,
          description,
          name,
          height,
          width,
          massa,
          point,
          pointBlogger,
          articul,
          currency,
          isSwitchedBs,
          deep,
          image,
          optom,
          size,
          fulfillment,
          subIds,
          video);

  Future<dynamic> update(
    String price,
    String count,
    String compound,
    String catId,
    String subCatId,
    String brandId,
    String colorId,
    String description,
    String name,
    String height,
    String width,
    String massa,
    String productId,
    String articul,
    String currency,
    bool isSwitchedBs,
    String deep,
    List<dynamic>? image,
    List<OptomPriceSellerDto> optom,
    List<SizeCountSellerDto> size,
    fulfillment,
    String? video,
    String point,
    String pointBlogger,
    List<int>? subIds,
  ) =>
      _productToApi.update(
          price,
          count,
          compound,
          catId,
          subCatId,
          brandId,
          colorId,
          description,
          name,
          height,
          width,
          massa,
          productId,
          articul,
          currency,
          isSwitchedBs,
          deep,
          image,
          optom,
          size,
          fulfillment,
          video,
          point,
          pointBlogger,
          subIds);

  Future<dynamic> delete(String productId) => _productToApi.delete(productId);

  Future<String?> ad(int productId, int price) =>
      _productToApi.ad(productId, price);

  Future<List<ProductSellerModel>> products(String? name, int page) =>
      _productToApi.products(name, page);

  Future<dynamic> deleteImage({
    required int productId,
    required String imagePath,
  }) =>
      _productToApi.deleteImage(productId: productId, imagePath: imagePath);

  Future<int> getLastArticul() => _productToApi.getLastArticul();

  Future<List<AdSellerDto>> getAdsList() => _productToApi.getAdsList();
}

class ProductToApi {
  final _box = GetStorage();

  Future<dynamic> store(
      String price,
      String count,
      String compound,
      String catId,
      String? subCatId,
      String? brandId,
      String colorId,
      String description,
      String name,
      String height,
      String width,
      String massa,
      String point,
      String pointBlogger,
      String articul,
      String currency,
      bool isSwitchedBs,
      String deep,
      List<dynamic>? image,
      List<OptomPriceSellerDto> optom,
      List<SizeCountSellerDto> size,
      String fulfillment,
      List<int>? subIds,
      String? video) async {
    try {
      final sellerId = _box.read('seller_id');
      final token = _box.read('seller_token');
      String? preOrder;

      isSwitchedBs == true ? preOrder = '1' : preOrder = '0';

      final bodys = {
        'shop_id': sellerId.toString(),
        'name': name,
        'price': price,
        'count': count,
        'compound': compound,
        'cat_id': catId,
        if (subCatId != null) 'sub_cat_id': subCatId,
        'color_id': colorId,
        if (brandId != null) 'brand_id': brandId,
        'description': description,
        'height': height,
        'width': width,
        'massa': massa,
        'pre_order': preOrder,
        'point': point,
        'point_blogger': pointBlogger,
        'articul': articul,
        'deep': deep,
        'currency': currency,
        'fulfillment': fulfillment
      };

      Map<String, dynamic> queryParams = {};
      Map<String, dynamic> blocc = {};
      Map<String, dynamic> sizes = {};
      Map<String, dynamic> subCharacteristicIds = {};

      List<Map<String, dynamic>> blocMapList = [];

      for (var i = 0; i < optom.length; i++) {
        blocc['bloc[$i][count]'] = optom[i].count;
        blocc['bloc[$i][price]'] = optom[i].price;
      }
      for (var i = 0; i < size.length; i++) {
        sizes['size[$i][id]'] = size[i].id;
        sizes['size[$i][count]'] = size[i].count;
      }
      if (subIds?.isNotEmpty ?? false) {
        for (var i = 0; i < subIds!.length; i++) {
          subCharacteristicIds['sub_characteristic_ids[]'] =
              subIds[i].toString();
        }
      }

      queryParams.addAll(blocc);
      queryParams.addAll(sizes);
      queryParams.addAll(subCharacteristicIds);

      final request = http.MultipartRequest(
          'POST',
          Uri.parse(
            '$baseUrl/seller/product/store',
          ).replace(queryParameters: queryParams));

      final headers = {
        'Authorization': 'Bearer $token',
      };

      request.headers.addAll(headers);
      request.fields.addAll(bodys);

      if (video != null) {
        request.files.add(
          await http.MultipartFile.fromPath('video', video),
        );
      }

      image!.forEach((element) async {
        request.files.add(
          await http.MultipartFile.fromPath('images[]', element!.path),
        );
      });

      final http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();

      return response.statusCode;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> update(
      String price,
      String count,
      String compound,
      String catId,
      String subCatId,
      String brandId,
      String colorId,
      String description,
      String name,
      String height,
      String width,
      String massa,
      String productId,
      String articul,
      String currency,
      bool isSwitchedBs,
      String deep,
      List<dynamic>? image,
      List<OptomPriceSellerDto> optom,
      List<SizeCountSellerDto> size,
      String fulfillment,
      String? video,
      String point,
      String pointBlogger,
      List<int>? subIds) async {
    final sellerId = _box.read('seller_id');
    final token = _box.read('seller_token');
    String? preOrder;

    isSwitchedBs == true ? preOrder = '1' : preOrder = '0';

    final body = {
      'shop_id': sellerId.toString(),
      'token': token.toString(),
      'product_id': productId,
      'name': name,
      'price': price,
      'count': count,
      'compound': compound,
      'cat_id': catId,
      'sub_cat_id': subCatId,
      'brand_id': brandId,
      'color_id': colorId,
      'description': description,
      'height': height,
      'width': width,
      'massa': massa,
      'articul': articul,
      'deep': deep,
      'currency': currency,
      'pre_order': preOrder,
      'fulfillment': fulfillment,
      'point': point,
      'point_blogger': pointBlogger,
    };

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/seller/product/update'),
    );
    Map<String, String> tokenSeller = {"Authorization": "Bearer $token"};

    request.headers.addAll(tokenSeller);

    if (image != null) {
      image.forEach((element) async {
        request.files.add(
          await http.MultipartFile.fromPath('images[]', element!.path),
        );
      });
    }

    if (video != null) {
      request.files.add(
        await http.MultipartFile.fromPath('video', video),
      );
    }
    request.fields.addAll(body);
    Map<String, String> blocc = {};
    Map<String, String> sizes = {};
    Map<String, String> subCharacteristicIds = {};

    for (var i = 0; i < optom.length; i++) {
      blocc['bloc[$i][count]'] = optom[i].count;
      blocc['bloc[$i][price]'] = optom[i].price;
    }
    if (subIds?.isNotEmpty ?? false) {
      print('subIDs');
      for (var i = 0; i < subIds!.length; i++) {
        subCharacteristicIds['sub_characteristic_ids[]'] = subIds[i].toString();
      }
    }

    for (var i = 0; i < size.length; i++) {
      sizes['size[$i][id]'] = size[i].id;
      sizes['size[$i][count]'] = size[i].count;
    }

    request.fields.addAll(blocc);
    request.fields.addAll(sizes);
    request.fields.addAll(subCharacteristicIds);

    final http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    log('${response.statusCode}we');
    return response.statusCode;
  }

  Future<dynamic> delete(String productId) async {
    final token = _box.read('seller_token');
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final response = await http.post(
        Uri.parse('$baseUrl/seller/product/delete'),
        headers: headers,
        body: {
          'shop_id': _box.read('seller_id'),
          'token': _box.read('seller_token'),
          'product_id': productId,
        });

    return response.statusCode;
  }

  Future<List<ProductSellerModel>> products(String? name, int page) async {
    try {
      final sellerId = _box.read('seller_id');
      final String? token = _box.read('token');

      final response = await http.get(
          Uri.parse(
              '$baseUrl/seller/products?shop_id=$sellerId&name=$name&page=$page'),
          headers: {"Authorization": "Bearer $token"});

      final data = jsonDecode(response.body);

      return (data['data'] as List)
          .map((e) => ProductSellerModel.fromJson(e as Map<String, Object?>))
          .toList();
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<String?> ad(int productId, int price) async {
    try {
      final sellerId = _box.read('seller_id');
      final String? token = _box.read('token');
      int view = 300;

      final response = await http.get(
          Uri.parse(
              '$baseUrl/seller/ad/payment/?product_id=$productId&price=$price&view=$view'),
          headers: {"Authorization": "Bearer $token"});

      final data = jsonDecode(response.body);

      return data['data_tinkoff']['PaymentURL'];
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<dynamic> deleteImage({
    required int productId,
    required String imagePath,
  }) async {
    try {
      final response = await http
          .post(Uri.parse('$baseUrl/seller/product/delete/image'), body: {
        'product_id': productId.toString(),
        'path': imagePath,
      });

      return response.statusCode;
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<int> getLastArticul() async {
    try {
      // final sellerId = _box.read('seller_id');
      final String? token = _box.read('token');
      // int view = 300;

      final response = await http.get(Uri.parse('$baseUrl/seller/last/articul'),
          headers: {"Authorization": "Bearer $token"});

      final data = jsonDecode(response.body);

      return data['last_articul'];
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<List<AdSellerDto>> getAdsList() async {
    try {
      // final sellerId = _box.read('seller_id');
      final String? token = _box.read('token');
      // int view = 300;

      final response = await http.get(Uri.parse('$baseUrl/list/ads'),
          headers: {"Authorization": "Bearer $token"});

      final data = jsonDecode(response.body);

      return ((data as List?) ?? [])
          .map((e) => AdSellerDto.fromJson(e as Map<String, Object?>))
          .toList();
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
