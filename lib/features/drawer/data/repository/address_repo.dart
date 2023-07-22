import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../models/address_model.dart';

const baseUrl = 'http://185.116.193.73/api';

class AddressRepository {
  final AddressApi _addressApi = AddressApi();

  Future<List<AddressModel>> address() => _addressApi.address();
}

class AddressApi {
  final _box = GetStorage();

  Future<List<AddressModel>> address() async {
    final String? token = _box.read('token');

    final response = await http.get(Uri.parse("$baseUrl/user/address"),
        headers: {"Authorization": "Bearer $token"});

    final data = jsonDecode(response.body);

    return (data as List).map((e) => AddressModel.fromJson(e)).toList();
  }
}
