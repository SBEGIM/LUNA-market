import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../model/TapeAdminModel.dart';

const baseUrl = 'https://lunamarket.ru/api';

class TapeAdminRepository {
  final TapeApi _tapeApi = TapeApi();

  Future<List<TapeAdminModel>> tapes(inSub, inFav, search) =>
      _tapeApi.tapes(inSub, inFav, search);
}

class TapeApi {
  final _box = GetStorage();

  Future<List<TapeAdminModel>> tapes(inSub, inFav, search) async {
    final token = _box.read('seller_token');
    final sellerId = _box.read('seller_id');

    // final queryParameters = {
    //   'subscribes': '$inSub',
    //   'favorite': '$inFav',
    //   'search': '$search',
    // };
    // final uri =
    //     Uri.https('80.87.202.73:8001', '/api/shop/tape', queryParameters);

    // final response =
    //     await http.get(uri, headers: {"Authorization": "Bearer $token"});

    final response = await http.get(
      Uri.parse(
          '$baseUrl/seller/tape?token=${token.toString()}&shop_id=${sellerId.toString()}&search=$search'),
    );

    final data = jsonDecode(response.body);

    return (data['data'] as List)
        .map((e) => TapeAdminModel.fromJson(e))
        .toList();
  }
}
