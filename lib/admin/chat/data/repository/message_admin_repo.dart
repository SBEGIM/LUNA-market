import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/basket/data/models/basket_order_model.dart';
import 'package:haji_market/features/basket/data/models/basket_show_model.dart';
import 'package:http/http.dart' as http;

import '../DTO/DTO/messageAdminDto.dart';
import '../model/chat_model.dart';

const baseUrl = 'http://185.116.193.73/api';
const _tag = 'messageRepository';

class MessageAdminRepository {
  final Message _message = Message();

  Future<List<MessageAdminDto>> messageList(int page) =>
      _message.messageList(page);
}

class Message {
  final _box = GetStorage();

  Future<List<MessageAdminDto>> messageList(int page) async {
    try {
      final String? token = _box.read('token');

      final response = await http.get(
          Uri.parse("$baseUrl/chat/message?page=$page&chat_id=1"),
          headers: {
            "Authorization":
                "Bearer 173|NhSdjW7Lu8DWqtSqGB4XAgwbnDXeXuhLYHdteW25"
          });

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      return (data['data'] as List)
          .map((e) => MessageAdminDto.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('messageList::: $e', name: _tag);
      throw Exception(e);
    }
  }
}
