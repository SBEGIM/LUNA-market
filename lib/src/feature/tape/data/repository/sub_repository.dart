import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class SubsRepository {
  final SubApi _subApi = SubApi();

  subs(bloggerId) => _subApi.sub(bloggerId);

  subSeller(shopId) => _subApi.subSeller(shopId);
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

  subSeller(shopId) async {
    final String? token = _box.read('token');

    final response = await http.post(Uri.parse('$baseUrl/user/subs'), headers: {
      "Authorization": "Bearer $token"
    }, body: {
      "seller_id": shopId.toString(),
    });

    return response.statusCode;
  }
}
