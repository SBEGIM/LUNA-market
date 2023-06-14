import 'dart:convert';
import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../DTO/DTO/messageAdminDto.dart';

const baseUrl = 'http://185.116.193.73/api';
const _tag = 'messageRepository';

class MessageAdminRepository {
  final Message _message = Message();

  Future<List<MessageAdminDto>> messageList(int page, int chatId) =>
      _message.messageList(page, chatId);
}

class Message {
  final _box = GetStorage();

  Future<List<MessageAdminDto>> messageList(int page, int chatId) async {
    try {
      final String? token = _box.read('token');

      final response = await http.get(
          Uri.parse("$baseUrl/chat/message?page=$page&chat_id=$chatId"),
          headers: {"Authorization": "Bearer $token"});

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
