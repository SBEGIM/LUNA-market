import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/basket/data/models/cdek_office_old_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class CdekOfficeRepository {
  final CdekOfficeApi _cdekOfficeApi = CdekOfficeApi();

  Future<List<CdekOfficeOldModel>> cdekOffice(int cc) =>
      _cdekOfficeApi.cdekOffice(cc);
}

class CdekOfficeApi {
  final _box = GetStorage();

  Future<List<CdekOfficeOldModel>> cdekOffice(int cc) async {
    final String? token = _box.read('token');

    final response = await http.get(
        Uri.parse('$baseUrl/basket/cdek/office?cc=$cc'),
        headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    return (data['data'] as List)
        .map((e) => CdekOfficeOldModel.fromJson(e))
        .toList();
  }
}
