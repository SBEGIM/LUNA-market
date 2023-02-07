import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../model/profile_month_blogger_statics.dart';

const baseUrl = 'http://80.87.202.73:8001/api';

class ProfileMonthStaticsBloggerRepository {
  ProfileMonthStaticsBloggerToApi _profileMonthStaticsBloggerToApinToApi =
      ProfileMonthStaticsBloggerToApi();

  Future<dynamic> statics() => _profileMonthStaticsBloggerToApinToApi.statics();
}

class ProfileMonthStaticsBloggerToApi {
  final _box = GetStorage();

  Future<dynamic> statics() async {
    final response =
        await http.get(Uri.parse('$baseUrl/blogger/profile/month/statics'));

    final data = jsonDecode(response.body);

    return (data as List).map((e) => ProfileMonthStatics.fromJson(e)).toList();
  }
}
