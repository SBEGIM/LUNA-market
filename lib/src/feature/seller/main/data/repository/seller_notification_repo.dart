import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/seller/main/data/model/notification_seller_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class SellerrNotificationRepository {
  final NotifactionToApi _notificationToApi = NotifactionToApi();

  Future<List<NotificationSellerModel>> notifications() => _notificationToApi.notifications();

  Future<int> read(int id) => _notificationToApi.read(id);
  Future<int> count() => _notificationToApi.count();
}

class NotifactionToApi {
  final _box = GetStorage();

  Future<List<NotificationSellerModel>> notifications() async {
    String token = _box.read('seller_token');
    final response = await http.get(
      Uri.parse('$baseUrl/list/notifications?notificationable=App/Models/Seller'),
      headers: {"Authorization": "Bearer $token"},
    );
    final data = jsonDecode(response.body);

    return (data as List).map((e) => NotificationSellerModel.fromJson(e)).toList();
  }

  Future<int> read(int id) async {
    String token = _box.read('seller_token');
    final response = await http.get(
      Uri.parse('$baseUrl/list/notifications/read?notificationable=App/Models/Seller&id=$id'),
      headers: {"Authorization": "Bearer $token"},
    );

    return response.statusCode;
  }

  Future<int> count() async {
    String token = _box.read('seller_token');
    final response = await http.get(
      Uri.parse('$baseUrl/list/notifications/count?notificationable=App/Models/Seller'),
      headers: {"Authorization": "Bearer $token"},
    );

    final data = jsonDecode(response.body);

    return data['count'];
  }
}
