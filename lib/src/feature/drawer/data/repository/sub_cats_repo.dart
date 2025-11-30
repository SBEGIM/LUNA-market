import 'dart:convert';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class SubCatsRepository {
  final SubCatApi _subCatsApi = SubCatApi();

  Future<List<CatsModel>> subCatApi(subCatId) => _subCatsApi.subCats(subCatId);
  Future<List<CatsModel>> subCatBrandApi(subCatId, int? brandId, int? optionId) =>
      _subCatsApi.subCatBrans(subCatId, brandId, optionId);
}

class SubCatApi {
  Future<List<CatsModel>> subCats(subCatId) async {
    final response = await http.get(Uri.parse('$baseUrl/list/sub/cats?sub_cat_id=$subCatId'));

    final data = jsonDecode(response.body);

    return (data as List).map((e) => CatsModel.fromJson(e)).toList();
  }

  Future<List<CatsModel>> subCatBrans(subCatId, int? brandId, int? optionId) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/list/sub/cats?sub_cat_id=$subCatId&brand_id=$brandId&option_id=$optionId',
      ),
    );

    final data = jsonDecode(response.body);

    return (data as List).map((e) => CatsModel.fromJson(e)).toList();
  }
}
