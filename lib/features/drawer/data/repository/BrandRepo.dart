import 'dart:convert';
import 'package:haji_market/features/home/data/model/Cats.dart';
import 'package:http/http.dart' as http;



const   baseUrl = 'http://80.87.202.73:8001/api';

class SubCatsRepository{
  SubCatApi  _subCatsApi = SubCatApi();

  Future<List<Cats>> subCatApi(sub_cat_id) => _subCatsApi.subCats(sub_cat_id);
}


class SubCatApi {

  Future<List<Cats>> subCats(sub_cat_id) async {
    final response = await http.get(Uri.parse('$baseUrl/list/sub/cats?sub_cat_id=$sub_cat_id'));

    final data = jsonDecode(response.body);

    return  (data as List).map((e) => Cats.fromJson(e)).toList();
  }


}