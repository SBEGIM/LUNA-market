import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../model/profile_month_admin_statics.dart';

const baseUrl = 'https://lunamarket.ru/api';

class ProfileMonthStaticsAdminRepository {
  final ProfileMonthStaticsAdminToApi _profileMonthStaticsBloggerToApinToApi =
      ProfileMonthStaticsAdminToApi();

  Future<dynamic> statics(int year, int month) =>
      _profileMonthStaticsBloggerToApinToApi.statics(year, month);
}

class ProfileMonthStaticsAdminToApi {
  final _box = GetStorage();

  Future<dynamic> statics(int year, int month) async {
    final seller_id = _box.read('seller_id');

    final response = await http.get(
      Uri.parse(
        '$baseUrl/seller/profile/month/statics/?seller_id=$seller_id&year=$year&month=$month',
      ),
    );

    final data = jsonDecode(response.body);

    return (data as List).map((e) => ProfileMonthStatics.fromJson(e)).toList();
  }
}
