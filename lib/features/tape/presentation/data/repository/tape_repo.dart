import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/tape/presentation/data/models/TapeModel.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://185.116.193.73/api';

class TapeRepository {
  final TapeApi _tapeApi = TapeApi();

  Future<List<TapeModel>> tapes(inSub, inFav, search, bloggerId) =>
      _tapeApi.tapes(inSub, inFav, search, bloggerId);
}

class TapeApi {
  final _box = GetStorage();

  Future<List<TapeModel>> tapes(
      bool? inSub, bool? inFav, String? search, int? bloggerId) async {
    final String? token = _box.read('token');

    final response = await http.get(
        Uri.parse(
            '$baseUrl/shop/tape?subscribes=$inSub&favorite=$inFav&search=$search&blogger_id=$bloggerId'),
        headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    return (data['data'] as List).map((e) => TapeModel.fromJson(e)).toList();
  }
}
