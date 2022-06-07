import 'dart:async';

import 'package:flutter/services.dart';
import 'package:vpn_check/src/exception/vpn_exception.dart';

class VPNCheck {
  static const MethodChannel _channel = const MethodChannel('vpn_check');

  static Future<bool> get isVpnActive async {
    try {
      final isActive = await _channel.invokeMethod<bool>('vpn_active');

      if (isActive == null) {
        throw VPNUnhandledException();
      }

      return isActive;
    } on PlatformException catch (e, stack) {
      throw Error.throwWithStackTrace(
        VPNUnhandledException(),
        stack,
      );
    }
  }
}
