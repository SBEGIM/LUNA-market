import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://lunamarket.ru/api';

class ProfileEditAdminRepository {
  final ProfileEditAdminToApi _profileEditAdminToApi = ProfileEditAdminToApi();

  Future<void> edit(
    String? name,
    String? phone,
    String? logo,
    String? password_new,
    String? password_old,
    String? country,
    String? city,
    String? home,
    String? street,
    String? shopName,
    String? iin,
    String? check,
    String? email,
    String? card,
    bool? typeOrganization,
    String? address,
    String? kpp,
    String? ogrn,
    String? okved,
    String? tax_authority,
    String? date_register,
    String? legal_address,
    String? founder,
    String? date_of_birth,
    String? citizenship,
    String? CEO,
    String? organization_fr,
    String? bank,
    String? company_name,
  ) =>
      _profileEditAdminToApi.edit(
          name,
          phone,
          logo,
          password_new,
          password_old,
          country,
          city,
          home,
          street,
          shopName,
          iin,
          check,
          email,
          card,
          typeOrganization,
          address,
          kpp,
          ogrn,
          okved,
          tax_authority,
          date_register,
          founder,
          date_of_birth,
          citizenship,
          CEO,
          organization_fr,
          bank,
          company_name,
          legal_address);

  Future<void> code(int? code) => _profileEditAdminToApi.code(code);
}

class ProfileEditAdminToApi {
  final _box = GetStorage();

  Future<void> edit(
      String? name,
      String? phone,
      String? logo,
      String? password_new,
      String? password_old,
      String? country,
      String? city,
      String? home,
      String? street,
      String? shopName,
      String? iin,
      String? check,
      String? email,
      String? card,
      bool? typeOrganization,
      String? address,
      String? kpp,
      String? ogrn,
      String? okved,
      String? tax_authority,
      String? date_register,
      String? founder,
      String? date_of_birth,
      String? citizenship,
      String? CEO,
      String? organization_fr,
      String? bank,
      String? company_name,
      String? legal_address) async {
    // seller_name = _box.read('seller_name').toString();
    final token = _box.read('seller_token').toString();

    print('token ${token}');

    final body = {
      'token': token,
      'new_name': shopName ?? '',
      'user_name': name ?? '',
      'phone': phone ?? '',
      'email': email ?? '',
      'password_new': password_new ?? '',
      'password_old': password_old ?? '',
      'country': country ?? '',
      'city': city ?? '',
      'home': home ?? '',
      'address': address ?? '',
      'street': street ?? '',
      'iin': iin ?? '',
      'check': check ?? '',
      'card': card ?? '',
      'type_organization': typeOrganization != null
          ? (typeOrganization == true ? 'ТОО' : 'ИП')
          : '',
      'kpp': kpp ?? '',
      'ogrn': ogrn ?? '',
      'okved': okved ?? '',
      'tax_authority': tax_authority ?? '',
      'date_register': date_register ?? '',
      'legal_address': legal_address ?? '',
      'founder': founder ?? '',
      'date_of_birth': date_of_birth ?? '',
      'citizenship': citizenship ?? '',
      'CEO': CEO ?? '',
      'organization_fr': organization_fr ?? '',
      'bank': bank ?? '',
      'company_name': company_name ?? '',
    };

    final header = {"Authorization": "Bearer $token"};

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/seller/edit'),
    );

    if (logo != '') {
      request.files.add(
        await http.MultipartFile.fromPath('image', logo!),
      );
    }
    request.fields.addAll(body);
    request.headers.addAll(header);

    final http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    if (response.statusCode == 400) {
      Get.snackbar('Ошибка запроса!', 'Неверный телефон или пароль',
          backgroundColor: Colors.redAccent);
      // Get.snackbar('title', 'message', backgroundColor: Colors.redAccent);
      return;
    }
    final jsonResponse = jsonDecode(respStr);
    final data = jsonResponse;
    _box.write('seller_token', data['token'].toString());
    _box.write('seller_id', data['id'].toString());
    _box.write('seller_name', data['name'].toString());
    _box.write('seller_phone', data['phone'].toString());
    _box.write('seller_email', data['email'].toString());
    _box.write('seller_image', data['image'].toString());
    _box.write('seller_country', data['country'].toString());
    _box.write('seller_city', data['city'].toString());
    _box.write('seller_home', data['home'].toString());
    _box.write('seller_address', data['seller_address'].toString());
    _box.write('seller_street', data['street'].toString());
    _box.write('seller_iin', data['iin'].toString());
    _box.write('seller_check', data['check'].toString());
    _box.write('seller_card', data['card'].toString());
    _box.write('seller_userName', data['user_name'].toString());
    _box.write(
        'seller_type_organization', data['type_organization'].toString());

    _box.write('seller_kpp', data['kpp'].toString());
    _box.write('seller_ogrn', data['ogrn'].toString());
    _box.write('seller_okved', data['okved'].toString());
    _box.write('seller_tax_authority', data['tax_authority'].toString());
    _box.write('seller_date_register', data['date_register'].toString());
    _box.write('seller_founder', data['founder'].toString());
    _box.write('seller_date_of_birth', data['date_of_birth'].toString());
    _box.write('seller_citizenship', data['citizenship'].toString());
    _box.write('seller_CEO', data['CEO'].toString());
    _box.write('seller_organization_fr', data['organization_fr'].toString());
    _box.write('seller_bank', data['bank'].toString());
    _box.write('seller_company_name', data['company_name'].toString());
    _box.write('seller_legal_address', data['legal_address'].toString());
  }

  Future<void> code(int? code) async {
    final token = _box.read('seller_token').toString();

    final response = await http.post(Uri.parse('$baseUrl/seller/edit'),
        headers: {"Authorization": "Bearer $token"},
        body: {'code': code.toString()});
    if (response.statusCode == 200) {
      _box.write('shop_location_code', code.toString());
    }
  }
}
