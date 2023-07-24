import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../models/address_model.dart';

const baseUrl = 'http://185.116.193.73/api';

class AddressRepository {
  final AddressApi _addressApi = AddressApi();

  Future<List<AddressModel>> address() => _addressApi.address();
  Future<int> store(country, city, street, home, floor, porch, room) =>
      _addressApi.store(country, city, street, home, floor, porch, room);

  Future<int> update(id, country, city, street, home, floor, porch, room) =>
      _addressApi.update(id, country, city, street, home, floor, porch, room);

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

  Future<int> store(country, city, street, home, floor, porch, room) async {
    final String? token = _box.read('token');
    final response =
        await http.post(Uri.parse("$baseUrl/user/address/store"), headers: {
      "Authorization": "Bearer $token"
    }, body: {
      'city': city,
      'florr': floor,
      'room': room,
      'porch': porch,
      'street': street,
      'home': home,
      'country': country
    });

    return response.statusCode;
  }

  Future<int> update(
      id, country, city, street, home, floor, porch, room) async {
    final String? token = _box.read('token');
    final response =
        await http.post(Uri.parse("$baseUrl/user/address/update"), headers: {
      "Authorization": "Bearer $token"
    }, body: {
      'id': id.toString(),
      'city': city,
      'florr': floor,
      'room': room,
      'porch': porch,
      'street': street,
      'home': home,
      'country': country
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
