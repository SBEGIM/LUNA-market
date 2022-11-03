import 'dart:convert';
import 'package:haji_market/features/home/data/model/Cats.dart';
import 'package:http/http.dart' as http;



const   baseUrl = 'http://80.87.202.73:8001/api';

class BrandsRepository{
  BrandApi  _brandApi = BrandApi();

  Future<List<Cats>> brandApi() => _brandApi.brands();
}


class BrandApi {

  Future<List<Cats>> brands() async {
    final response = await http.get(Uri.parse('$baseUrl/list/brands'));

    final data = jsonDecode(response.body);

    return  (data as List).map((e) => Cats.fromJson(e)).toList();
  }


}