import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../model/profile_statics_blogger_model.dart';

const baseUrl = 'https://lunamarket.ru/api';

class ProfileStaticsBloggerRepository {
  final ProfileStaticsBloggerToApi _profileStaticsBloggerToApinToApi =
      ProfileStaticsBloggerToApi();

  Future<dynamic> statics(bloggerId) =>
      _profileStaticsBloggerToApinToApi.statics(bloggerId);
}

class ProfileStaticsBloggerToApi {
  final _box = GetStorage();

  Future<dynamic> statics(bloggerId) async {
    if (bloggerId == 0) {
      final bloggerId = _box.read('blogger_id');
    }

    final response = await http.get(
        Uri.parse('$baseUrl/blogger/profile/statics?blogger_id=$bloggerId'));

    return ProfileStaticsBloggerModel.fromJson(jsonDecode(response.body));
  }
}
