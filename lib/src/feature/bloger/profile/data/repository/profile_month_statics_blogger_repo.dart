import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../model/profile_month_blogger_statics.dart';

const baseUrl = 'https://lunamarket.ru/api';

class ProfileMonthStaticsBloggerRepository {
  final ProfileMonthStaticsBloggerToApi _profileMonthStaticsBloggerToApinToApi =
      ProfileMonthStaticsBloggerToApi();

  Future<dynamic> statics(int month, int year) =>
      _profileMonthStaticsBloggerToApinToApi.statics(month, year);
}

class ProfileMonthStaticsBloggerToApi {
  final _box = GetStorage();

  Future<dynamic> statics(int month, int year) async {
    final bloggerId = _box.read('blogger_id');

    final response = await http.get(
      Uri.parse(
        '$baseUrl/blogger/profile/month/statics/?blogger_id=$bloggerId&month=$month&year=$year',
      ),
    );

    final data = jsonDecode(response.body);

    return (data as List).map((e) => ProfileMonthStatics.fromJson(e)).toList();
  }
}
