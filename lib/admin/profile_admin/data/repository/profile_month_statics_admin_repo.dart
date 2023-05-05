import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../model/profile_month_admin_statics.dart';

const baseUrl = 'http://185.116.193.73/api';

class ProfileMonthStaticsAdminRepository {
  final ProfileMonthStaticsAdminToApi _profileMonthStaticsBloggerToApinToApi =
      ProfileMonthStaticsAdminToApi();

  Future<dynamic> statics() => _profileMonthStaticsBloggerToApinToApi.statics();
}

class ProfileMonthStaticsAdminToApi {
  final _box = GetStorage();

  Future<dynamic> statics() async {
    final response =
        await http.get(Uri.parse('$baseUrl/blogger/profile/month/statics'));

    final data = jsonDecode(response.body);

    return (data as List).map((e) => ProfileMonthStatics.fromJson(e)).toList();
  }
}
