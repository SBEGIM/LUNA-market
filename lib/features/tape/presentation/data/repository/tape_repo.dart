import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/tape/presentation/data/models/TapeModel.dart';
import 'package:haji_market/features/tape/presentation/data/models/tape_check_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://185.116.193.73/api';

class TapeRepository {
  final TapeApi _tapeApi = TapeApi();

  Future<List<TapeModel>> tapes(inSub, inFav, search, bloggerId, page) =>
      _tapeApi.tapes(inSub, inFav, search, bloggerId, page);

  view(id) => _tapeApi.view(id);

  Future<TapeCheckModel> tapeCheck({
    required int tapeId
  }) => _tapeApi.tapeCheck(tapeId: tapeId);
}

class TapeApi {
  final _box = GetStorage();

  Future<List<TapeModel>> tapes(bool? inSub, bool? inFav, String? search, int? bloggerId, page) async {
    final String? token = _box.read('token');

    final response = await http.get(
        Uri.parse(
            '$baseUrl/shop/tape?subscribes=$inSub&favorite=$inFav&search=$search&blogger_id=$bloggerId&page=$page'),
        headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    return (data['data'] as List).map((e) => TapeModel.fromJson(e)).toList();
  }

  Future<TapeCheckModel> tapeCheck({
    required int tapeId,
  }) async {
    try {
      final String? token = _box.read('token');

      final response =
          await http.get(Uri.parse('$baseUrl/shop/tape/check?tape_id=$tapeId'), headers: {"Authorization": "Bearer $token"});

      final data = jsonDecode(response.body);

      return TapeCheckModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }

  view(int id) async {
    final String? token = _box.read('token');

    final response = await http.post(Uri.parse('$baseUrl/shop/tape/view'),
        body: {'tape_id': id.toString()}, headers: {"Authorization": "Bearer $token"});

    return response.statusCode;
  }
}
