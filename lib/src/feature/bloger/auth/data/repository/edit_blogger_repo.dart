import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/src/feature/bloger/auth/data/DTO/blogger_dto.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class EditBloggerRepository {
  final EditToApi _editToApi = EditToApi();

  Future<dynamic> edit(BloggerDTO dto) => _editToApi.edit(dto);
}

class EditToApi {
  final _box = GetStorage();

  Future<dynamic> edit(BloggerDTO dto) async {
    String result = '';
    if (dto.phone != null) {
      result = dto.phone!.substring(1);
      dto = dto.copyWith(phone: result.replaceAll(RegExp('[^0-9]'), ''));
    }

    final body = {
      'phone': dto.phone ?? '',
      'password': dto.password ?? '',
      'iin': dto.iin ?? '',
      'first_name': dto.firstName ?? '',
      'last_name': dto.lastName ?? '',
      'sur_name': dto.surName ?? '',
      'nick_name': dto.nick ?? '',
      'invoice': dto.check ?? '',
      'card': dto.card ?? '',
      'email': dto.email ?? '',
      'legal_status': dto.legalStatus ?? '',
      'social_network': dto.socialNetwork ?? '',
      'bank_name': dto.bankName ?? '',
      'bank_bik': dto.bankBik ?? '',
    };

    final header = {"Authorization": "Bearer ${_box.read('blogger_token').toString()}"};

    final request = http.MultipartRequest('POST', Uri.parse('$baseUrl/blogger/edit'));

    if (dto.avatar != '' && dto.avatar != null) {
      request.files.add(await http.MultipartFile.fromPath('avatar', dto.avatar));
    }
    request.fields.addAll(body);
    request.headers.addAll(header);

    final http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final data = jsonDecode(respStr);
      // final data = jsonDecode(jsonResponse.body);

      _box.write('blogger_token', data['access_token'].toString());
      _box.write('blogger_id', data['id'].toString());
      _box.write('blogger_first_name', data['first_name'].toString());
      _box.write('blogger_last_name', data['last_name'].toString());
      _box.write('blogger_sur_name', data['sur_name'].toString());

      _box.write('blogger_phone', data['phone'].toString());
      _box.write('blogger_iin', data['iin'].toString());
      _box.write('blogger_nick_name', data['nick_name'].toString());
      _box.write('blogger_avatar', data['avatar'].toString());
      _box.write('blogger_invoice', data['invoice'].toString());
      _box.write('blogger_card', data['card'].toString());
      _box.write('blogger_social_network', data['social_network'].toString());
      _box.write('blogger_email', data['email'].toString());
      _box.write('blogger_legal_status', data['legal_status'].toString());
      _box.write('blogger_bank_name', data['bank_name'].toString());
      _box.write('blogger_bank_bik', data['bank_bik'].toString());
    }
    return response.statusCode;
  }
}
