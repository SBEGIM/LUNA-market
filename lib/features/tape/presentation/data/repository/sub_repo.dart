import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'http://185.116.193.73/api';

class SubsRepository {
  final SubApi _subApi = SubApi();

  subs(shopId) => _subApi.sub(shopId);
}

class SubApi {
  final _box = GetStorage();

  sub(bloggerID) async {
    final String? token = _box.read('token');

    final response = await http.post(Uri.parse('$baseUrl/user/subs'), headers: {
      "Authorization": "Bearer $token"
    }, body: {
      "blogger_id": bloggerID.toString(),
    });

    return response.statusCode;
  }
}
