import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../model/profile_statics_blogger_model.dart';

const baseUrl = 'http://80.87.202.73:8001/api';

class ProfileStaticsBloggerRepository {
  ProfileStaticsBloggerToApi _profileStaticsBloggerToApinToApi =
      ProfileStaticsBloggerToApi();

  Future<dynamic> statics() => _profileStaticsBloggerToApinToApi.statics();
}

class ProfileStaticsBloggerToApi {
  final _box = GetStorage();

  Future<dynamic> statics() async {
    final response =
        await http.get(Uri.parse('$baseUrl/blogger/profile/statics'));

    return ProfileStaticsBloggerModel.fromJson(jsonDecode(response.body));
  }
}
