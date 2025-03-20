import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../home/data/model/cats.dart';

const baseUrl = 'https://lunamarket.ru/api';

class ColorAdminRepository {
  final ColorToApi _colorToApi = ColorToApi();

  Future<List<Cats>> get() => _colorToApi.get();
}

class ColorToApi {
  Future<List<Cats>> get() async {
    final response = await http.get(Uri.parse('$baseUrl/list/colors'));
    final data = jsonDecode(response.body);

    return (data as List).map((e) => Cats.fromJson(e)).toList();
  }
}
