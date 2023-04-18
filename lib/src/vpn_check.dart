import 'dart:async';

import 'package:flutter/services.dart';
import 'package:vpn_check/src/exception/vpn_exception.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class VPNChecker {
  final _channel = const MethodChannel('vpn_check');

  final _vpnChangeController = StreamController<bool>.broadcast();
  late final StreamSubscription<ConnectivityResult> _onConnectionChanged;

  VPNChecker() {
    final connectivity = Connectivity();
    _onConnectionChanged = connectivity.onConnectivityChanged.listen(
      _connectionHandler,
    );
  }

  /// Stream based on network activity to detect VPN activity
  /// VPN check may fail and throw and error, but you can continue listening
  /// events by specify [cancelOnError] as false
  Stream<bool> get vpnActivityStream => _vpnChangeController.stream;

  Future<void> _connectionHandler(ConnectivityResult result) async {
    if (result == ConnectivityResult.bluetooth) {
      return;
    }

    if (result == ConnectivityResult.none) {
      _vpnChangeController.sink.add(false);
    } else {
      try {
        final isEnabled = await isVPNEnabled();

        _vpnChangeController.sink.add(isEnabled);
      } on Object {
        _vpnChangeController.addError(
          'Connection changed, but vpn check failed',
        );
      }
    }
  }

  /// check VPN active status
  /// can throw [VPNUnhandledException]
  Future<bool> isVPNEnabled() async {
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

  /// Must be disposed to cancel subscriptions and stream
  Future<void> dispose() async {
    _onConnectionChanged.cancel();
    _vpnChangeController.close();
  }
}

@Deprecated(
  "Deprecated, will be remove in next version, "
  "use [VPNChecker] class instead",
)
class VPNCheck extends VPNChecker {
  @Deprecated(
    "Deprecated, will be remove in next version, "
    "use [VPNChecker().isVPNEnabled()] instead",
  )
  static Future<bool> get isVpnActive async {
    final instance = VPNChecker();

    return instance.isVPNEnabled();
  }
}
