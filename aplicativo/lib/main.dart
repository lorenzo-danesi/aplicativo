import 'dart:io';
import 'dart:convert';

import 'package:aplicativo/screens/android/principal.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Principal());
  // if(Platform.isAndroid) {
  //   debugPrint("app no android");
  //   runApp(const Principal());
  // }
  // if(Platform.isIOS) {
  //   debugPrint("app no IOS");
  // }
}