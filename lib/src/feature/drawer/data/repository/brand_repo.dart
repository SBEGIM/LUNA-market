import 'dart:convert';
import 'package:haji_market/src/feature/home/data/model/cat_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class BrandsRepository {
  final BrandApi _brandApi = BrandApi();

  Future<List<CatsModel>> brandApi({int? subCatId}) => _brandApi.brands(subCatId: subCatId);
}

class BrandApi {
  Future<List<CatsModel>> brands({int? subCatId}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/list/brands${subCatId != null ? '?sub_cat_id=$subCatId' : ''}'),
    );
    final data = jsonDecode(response.body);

    return (data as List).map((e) => CatsModel.fromJson(e)).toList();
  }
}
