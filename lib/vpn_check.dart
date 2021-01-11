import 'dart:async';

import 'package:flutter/services.dart';

class VPNCheck {
  static const MethodChannel _channel = const MethodChannel('vpn_check');

  static Future<bool> get isVpnActive async {
    return await _channel.invokeMethod('vpn_active');
  }
}
