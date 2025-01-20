import 'dart:convert';
import 'package:haji_market/features/home/data/model/Cats.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class SubCatsRepository {
  final SubCatApi _subCatsApi = SubCatApi();

  Future<List<Cats>> subCatApi(subCatId) => _subCatsApi.subCats(subCatId);
}

class SubCatApi {
  Future<List<Cats>> subCats(subCatId) async {
    final response = await http
        .get(Uri.parse('$baseUrl/list/sub/cats?sub_cat_id=$subCatId'));

    final data = jsonDecode(response.body);

    return (data as List).map((e) => Cats.fromJson(e)).toList();
  }
}
