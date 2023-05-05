import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/basket/data/DTO/cdek_office_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://185.116.193.73/api';

class CdekOfficeRepository {
  final CdekOfficeApi _cdekOfficeApi = CdekOfficeApi();

  Future<List<CdekOfficeModel>> cdekOffice() => _cdekOfficeApi.cdekOffice();
}

class CdekOfficeApi {
  final _box = GetStorage();

  Future<List<CdekOfficeModel>> cdekOffice() async {
    final String? token = _box.read('token');

    final response = await http.get(Uri.parse('$baseUrl/basket/cdek/office'),
        headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    return (data['data'] as List)
        .map((e) => CdekOfficeModel.fromJson(e))
        .toList();
  }
}
