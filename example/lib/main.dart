import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:vpn_check/vpn_check.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<bool> _streamSubscription;
  final vpnChecker = VPNChecker();
  bool? _isVpnActive;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _streamSubscription = vpnChecker.vpnActivityStream.listen(
      (isActive) {
        _isVpnActive = isActive;

        if (mounted) ;
        setState(() {});
      },
      onError: (error, stack) {
        print(error);
      },
      cancelOnError: false,
    );
  }

  Future<void> initPlatformState() async {
    try {
      _isVpnActive = await vpnChecker.isVPNEnabled();
      if (!mounted) return;

      setState(() {});
    } on PlatformException {}
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    vpnChecker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('VPN Activity example app'),
        ),
        body: Center(
          child: Text('VPN active: $_isVpnActive\n'),
        ),
      ),
    );
  }
}
