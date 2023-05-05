import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:haji_market/admin/profile_admin/data/model/profile_statics_admin_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://185.116.193.73/api';

class ProfileStaticsAdminRepository {
  final ProfileStaticsAdminToApi _profileStaticsBloggerToApinToApi =
      ProfileStaticsAdminToApi();

  Future<dynamic> statics() => _profileStaticsBloggerToApinToApi.statics();
}

class ProfileStaticsAdminToApi {
  final _box = GetStorage();

  Future<dynamic> statics() async {
    final response =
        await http.get(Uri.parse('$baseUrl/blogger/profile/statics'));

    return ProfileStaticsAdminModel.fromJson(jsonDecode(response.body));
  }
}
