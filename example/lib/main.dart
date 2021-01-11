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
  bool _isVpnActive;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      _isVpnActive = await VPNCheck.isVpnActive;
      if (!mounted) return;

      setState(() {});
    } on PlatformException {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('is Active vpn example app'),
        ),
        body: Center(
          child: Text('VPN active: $_isVpnActive\n'),
        ),
      ),
    );
  }
}
