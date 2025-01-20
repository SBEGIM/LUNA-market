import 'dart:convert';
import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../DTO/DTO/messageDto.dart';

const baseUrl = 'https://lunamarket.ru/api';
const _tag = 'messageRepository';

class MessageRepository {
  final Message _message = Message();

  Future<List<MessageDto>> messageList(int page, int chatId, int userId) =>
      _message.messageList(page, chatId, userId);
  Future<String> imageStore(String avatar) => _message.imageStore(avatar);
}

class Message {
  final _box = GetStorage();

  Future<List<MessageDto>> messageList(int page, int chatId, int userId) async {
    try {
      final String? token = _box.read('token');

      final response = await http.get(
        Uri.parse(
            "$baseUrl/chat/message?page=$page& ${chatId == 0 ? 'user_id=$userId' : 'chat_id=$chatId'} "),
        headers: {"Authorization": "Bearer $token"},
      );
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
