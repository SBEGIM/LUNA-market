import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/bloger/shop/data/models/blogger_notification_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class BloggerNotificationRepository {
  final NotifactionToApi _notificationToApi = NotifactionToApi();

  Future<List<BloggerNotificationModel>> notifications() =>
      _notificationToApi.notifications();
}

class NotifactionToApi {
  final _box = GetStorage();

  Future<List<BloggerNotificationModel>> notifications() async {
    String token = _box.read('blogger_token');

    print(_box.read('blogger_token'));

    final response = await http.get(
      Uri.parse(
          '$baseUrl/list/notifications?notificationable=App/Models/Blogger'),
      headers: {"Authorization": "Bearer $token"},
    );
    final data = jsonDecode(response.body);

    return (data as List)
        .map((e) => BloggerNotificationModel.fromJson(e))
        .toList();
  }
}
