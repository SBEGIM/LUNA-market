import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:haji_market/bloger/my_products_admin/data/models/blogger_product_statistics_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class BloggerTapeUploadRepository {
  final UploadApi _uploadVideoApi = UploadApi();

  Future<void> uploadVideo(String product_id, video) =>
      _uploadVideoApi.uploadVideo(product_id, video);
}

class UploadApi {
  final _box = GetStorage();

  Future<void> uploadVideo(String product_id, video) async {
    String token = _box.read('blogger_token');

    final body = {"product_id": product_id, "access_token": token};
    final header = {"Authorization": "Bearer $token"};

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/blogger/upload/video'),
    );

    request.headers.addAll(header);

    request.files.add(
      await http.MultipartFile.fromPath('video', video),
    );

    request.fields.addAll(body);

    final http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();

    return;
  }
}
