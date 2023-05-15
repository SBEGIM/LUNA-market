import 'dart:convert';
import 'dart:math';

import 'package:get_storage/get_storage.dart';
import 'package:haji_market/admin/profile_admin/data/model/profile_statics_admin_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://185.116.193.73/api';

class ProfileEditAdminRepository {
  final ProfileEditAdminToApi _profileEditAdminToApi = ProfileEditAdminToApi();

  Future<void> edit(
    String? name,
    String? phone,
    String? logo,
    String? password_new,
    String? password_old,
    String? country,
    String? city,
    String? home,
    String? street,
    String? shopName,
    String? iin,
    String? check,
    String? email,
  ) =>
      _profileEditAdminToApi.edit(name, phone, logo, password_new, password_old,
          country, city, home, street, shopName, iin, check, email);
}

class ProfileEditAdminToApi {
  final _box = GetStorage();

  Future<void> edit(
    String? name,
    String? phone,
    String? logo,
    String? password_new,
    String? password_old,
    String? country,
    String? city,
    String? home,
    String? street,
    String? shopName,
    String? iin,
    String? check,
    String? email,
  ) async {
    // seller_name = _box.read('seller_name').toString();
    final token = _box.read('seller_token').toString();

    final body = {
      'token': token,
      'new_name': shopName ?? '',
      'user_name': name ?? '',
      'phone': phone ?? '',
      'email': email ?? '',
      'password_new': password_new ?? '',
      'password_old': password_old ?? '',
      'country': country ?? '',
      'city': city ?? '',
      'home': home ?? '',
      'street': street ?? '',
      'iin': iin ?? '',
      'check': check ?? ''
    };

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/seller/edit'),
    );

    if (logo != '') {
      request.files.add(
        await http.MultipartFile.fromPath('image', logo!),
      );
    }
    request.fields.addAll(body);

    final http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();

    final jsonResponse = jsonDecode(respStr);
    final data = jsonResponse;
    _box.write('seller_token', data['token'].toString());
    _box.write('seller_id', data['id'].toString());
    _box.write('seller_name', data['name'].toString());
    _box.write('seller_phone', data['phone'].toString());
    _box.write('seller_email', data['email'].toString());
    _box.write('seller_image', data['image'].toString());
    _box.write('seller_country', data['country'].toString());
    _box.write('seller_city', data['city'].toString());
    _box.write('seller_home', data['home'].toString());
    _box.write('seller_street', data['street'].toString());
    _box.write('seller_iin', data['iin'].toString());
    _box.write('seller_check', data['check'].toString());
    _box.write('seller_userName', data['user_name'].toString());
  }
}
