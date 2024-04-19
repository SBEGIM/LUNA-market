import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/home/data/model/MetaModel.dart';
import 'package:haji_market/features/home/data/model/PartnerModel.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://185.116.193.73/api';

class MetaRepository {
  final MetaApi _metaApi = MetaApi();

  Future<MetaModel> metas() => _metaApi.metas();
}

class MetaApi {
  final _box = GetStorage();

  Future<MetaModel> metas() async {
    final String? token = _box.read('token');

    final response = await http.get(Uri.parse('$baseUrl/list/metas'), headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    return MetaModel.fromJson(data);
  }
}
