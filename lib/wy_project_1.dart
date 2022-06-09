
import 'dart:async';

import 'package:flutter/services.dart';

class WyProject_1 {
  static const MethodChannel _channel = MethodChannel('wy_project_1');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
