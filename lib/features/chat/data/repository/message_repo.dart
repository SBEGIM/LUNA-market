import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/basket/data/models/basket_order_model.dart';
import 'package:haji_market/features/basket/data/models/basket_show_model.dart';
import 'package:haji_market/features/chat/data/model/chat_model.dart';
import 'package:http/http.dart' as http;

import '../DTO/DTO/messageDto.dart';

const baseUrl = 'http://185.116.193.73/api';
const _tag = 'messageRepository';

class MessageRepository {
  final Message _message = Message();

  Future<List<MessageDto>> messageList(int page, int chatId) =>
      _message.messageList(page, chatId);
  Future<String> imageStore(String avatar) => _message.imageStore(avatar);
}

class Message {
  final _box = GetStorage();

  Future<List<MessageDto>> messageList(int page, int chatId) async {
    try {
      final String? token = _box.read('token');

      final response = await http.get(
          Uri.parse("$baseUrl/chat/message?page=$page&chat_id=$chatId"),
          headers: {
            "Authorization":
                "Bearer 204|qjptPdGTnA87ADzbexEk0TTUzKYHzk8Yq8FrUcHC"
          });
      print('ok');

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      return (data['data'] as List)
          .map((e) => MessageDto.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('messageList::: $e', name: _tag);
      throw Exception(e);
    }
  }

  Future<String> imageStore(String avatar) async {
    try {
      final String? token = _box.read('token');

      final headers = {
        'Authorization': 'Bearer $token',
      };

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/chat/message/upload-file'),
      );

      if (avatar != '') {
        request.files.add(
          await http.MultipartFile.fromPath('file', avatar),
        );
      }
      request.headers.addAll(headers);

      final http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();

      final data = jsonDecode(respStr);

      return data.toString();
    } catch (e) {
      log('messageList::: $e', name: _tag);
      throw Exception(e);
    }
  }
}
