import 'dart:convert';
import 'package:haji_market/src/feature/home/data/model/cats.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class SubCatsRepository {
  final SubCatApi _subCatsApi = SubCatApi();

  Future<List<CatsModel>> subCatApi(subCatId) => _subCatsApi.subCats(subCatId);
}

class SubCatApi {
  Future<List<CatsModel>> subCats(subCatId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/list/sub/cats?sub_cat_id=$subCatId'));

    final data = jsonDecode(response.body);

    return (data as List).map((e) => CatsModel.fromJson(e)).toList();
  }
}
