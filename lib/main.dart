import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haji_market/features/app/presentaion/my_app.dart';

void main() async {
  await GetStorage.init();
  runApp( MyApp());
}



