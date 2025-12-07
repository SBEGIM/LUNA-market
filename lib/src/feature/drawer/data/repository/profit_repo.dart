// import 'dart:convert';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;

// const baseUrl = 'https://lunamarket.ru/api';

// class ProfitRepository {
//   final ProfitApi _profitApi = ProfitApi();

//   Future<String> profitApi(id) => _profitApi.profit(id);
// }

// class ProfitApi {
//   final _box = GetStorage();

//   Future<String> profit(String id) async {
//     final String? token = _box.read('token');

//     final response = await http.get(
//       Uri.parse('$baseUrl/list/profitable?id=$id'),
//       headers: {"Authorization": "Bearer $token"},
//     );

//     final data = jsonDecode(response.body);

//     return data['path'];
//   }
// }
