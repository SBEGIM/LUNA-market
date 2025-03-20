import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/shop/profile_admin/data/model/profile_statics_admin_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class ProfileStaticsAdminRepository {
  final ProfileStaticsAdminToApi _profileStaticsBloggerToApinToApi =
      ProfileStaticsAdminToApi();

  Future<dynamic> statics() => _profileStaticsBloggerToApinToApi.statics();
}

class ProfileStaticsAdminToApi {
  final _box = GetStorage();

  Future<dynamic> statics() async {
    final sellerId = _box.read('seller_id');

    final response = await http
        .get(Uri.parse('$baseUrl/seller/profile/statics?seller_id=$sellerId'));

    return ProfileStaticsAdminModel.fromJson(jsonDecode(response.body));
  }
}
