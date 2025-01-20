import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/home/data/model/PartnerModel.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class PartnerRepository {
  final PartnerApi _partnerApi = PartnerApi();

  Future<List<PartnerModel>> partner() => _partnerApi.partner();
}

class PartnerApi {
  final _box = GetStorage();

  Future<List<PartnerModel>> partner() async {
    final String? token = _box.read('token');

    final response = await http.get(Uri.parse('$baseUrl/list/for_partner'),
        headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    return (data as List).map((e) => PartnerModel.fromJson(e)).toList();
  }
}
