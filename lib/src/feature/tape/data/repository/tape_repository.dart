import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/tape/data/models/tape_model.dart';
import 'package:haji_market/src/feature/tape/data/models/tape_check_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class TapeRepository {
  final TapeApi _tapeApi = TapeApi();

  Future<List<TapeModel>> tapes(inSub, inFav, search, bloggerId, page) =>
      _tapeApi.tapes(inSub, inFav, search, bloggerId, page);

  report(id, report) => _tapeApi.report(id, report);
  view(id) => _tapeApi.view(id);
  like(id) => _tapeApi.like(id);
  share(id) => _tapeApi.share(id);

  Future<TapeCheckModel> tapeCheck({required int tapeId}) => _tapeApi.tapeCheck(tapeId: tapeId);
}

class TapeApi {
  final _box = GetStorage();

  Future<List<TapeModel>> tapes(
    bool? inSub,
    bool? inFav,
    String? search,
    int? bloggerId,
    page,
  ) async {
    final String? token = _box.read('token');

    final response = await http.get(
      Uri.parse(
        '$baseUrl/shop/tape?subscribes=$inSub&favorite=$inFav&search=$search&blogger_id=$bloggerId&page=$page',
      ),
      headers: {"Authorization": "Bearer $token"},
    );

    final data = jsonDecode(response.body);

    return (data['data'] as List).map((e) => TapeModel.fromJson(e)).toList();
  }

  Future<TapeCheckModel> tapeCheck({required int tapeId}) async {
    try {
      final String? token = _box.read('token');

      final response = await http.get(
        Uri.parse('$baseUrl/shop/tape/check?tape_id=$tapeId'),
        headers: {"Authorization": "Bearer $token"},
      );

      final data = jsonDecode(response.body);

      return TapeCheckModel.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }

  report(int id, String report) async {
    final String? token = _box.read('token');

    final response = await http.post(
      Uri.parse('$baseUrl/shop/tape/report'),
      body: {'tape_id': id.toString(), 'report': report},
      headers: {"Authorization": "Bearer $token"},
    );

    return response.statusCode;
  }

  view(int id) async {
    final String? token = _box.read('token');

    final response = await http.post(
      Uri.parse('$baseUrl/shop/tape/view'),
      body: {'tape_id': id.toString()},
      headers: {"Authorization": "Bearer $token"},
    );

    return response.statusCode;
  }

  like(int id) async {
    final String? token = _box.read('token');

    final response = await http.post(
      Uri.parse('$baseUrl/shop/tape/like'),
      body: {'tape_id': id.toString()},
      headers: {"Authorization": "Bearer $token"},
    );

    return response.statusCode;
  }

  share(int id) async {
    final String? token = _box.read('token');

    final response = await http.post(
      Uri.parse('$baseUrl/shop/tape/share'),
      body: {'tape_id': id.toString()},
      headers: {"Authorization": "Bearer $token"},
    );

    return response.statusCode;
  }
}
