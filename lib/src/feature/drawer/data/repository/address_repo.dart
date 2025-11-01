import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../models/address_model.dart';

const baseUrl = 'https://lunamarket.ru/api';

class AddressRepository {
  final AddressApi _addressApi = AddressApi();

  Future<List<AddressModel>> address() => _addressApi.address();
  Future<int> store(country, city, street, entrance, floor, apartament,
          intercom, comment, phone) =>
      _addressApi.store(country, city, street, entrance, floor, apartament,
          intercom, comment, phone);

  Future<int> update(id, country, city, street, entrance, floor, apartament,
          intercom, comment, phone) =>
      _addressApi.update(id, country, city, street, entrance, floor, apartament,
          intercom, comment, phone);

  Future<int> delete(id) => _addressApi.delete(id);
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

  Future<int> store(country, city, street, entrance, floor, apartament,
      intercom, comment, phone) async {
    final String? token = _box.read('token');

    final rawDigits = phone.replaceAll(RegExp(r'[^0-9]'), '');

    final response =
        await http.post(Uri.parse("$baseUrl/user/address/store"), headers: {
      "Authorization": "Bearer $token"
    }, body: {
      'country': country,
      'city': city,
      'street': street,
      'entrance': entrance,
      'floor': floor,
      'apartament': apartament,
      'intercom': intercom,
      'comment': comment,
      'phone': rawDigits,
    });

    return response.statusCode;
  }

  Future<int> update(id, country, city, street, entrance, floor, apartament,
      intercom, comment, phone) async {
    final String? token = _box.read('token');
    final response =
        await http.post(Uri.parse("$baseUrl/user/address/update"), headers: {
      "Authorization": "Bearer $token"
    }, body: {
      'id': id.toString(),
      'country': country,
      'city': city,
      'street': street,
      'entrance': entrance,
      'floor': floor,
      'apartament': apartament,
      'intercom': intercom,
      'comment': comment,
      'phone': phone,
    });

    return response.statusCode;
  }

  Future<int> delete(id) async {
    final String? token = _box.read('token');
    final response = await http.post(Uri.parse("$baseUrl/user/address/destroy"),
        headers: {"Authorization": "Bearer $token"},
        body: {'id': id.toString()});

    return response.statusCode;
  }
}
