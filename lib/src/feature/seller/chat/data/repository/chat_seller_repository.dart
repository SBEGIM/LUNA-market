import 'dart:convert';
import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../model/chat_seller_model.dart';

const baseUrl = 'https://lunamarket.ru/api';
const _tag = 'ChatRepository';

class ChatSellerRepository {
  final Chat _chat = Chat();

  Future<List<ChatSellerModel>> chatList(int page) => _chat.chatList(page);
}

class Chat {
  final _box = GetStorage();

  Future<List<ChatSellerModel>> chatList(int page) async {
    try {
      final String? token = _box.read('seller_token');

      final response = await http.get(
        Uri.parse("$baseUrl/chat/shop?page=$page"),
        headers: {"Authorization": "Bearer $token"},
      );

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      return (data['data'] as List)
          .map((e) => ChatSellerModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('chatList::: $e', name: _tag);
      throw Exception(e);
    }
  }
}
