import 'package:flutter/material.dart';
import 'package:haji_market/features/app/presentaion/base.dart';


class LauncherApp extends StatefulWidget {
  const LauncherApp({super.key});
  @override
  State<LauncherApp> createState() => _LauncherAppState();
}

class _LauncherAppState extends State<LauncherApp> {
  @override
  Widget build(BuildContext context) {
    return const Base();
  }
}
