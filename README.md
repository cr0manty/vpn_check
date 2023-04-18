# vpn_check

Get vpn active status for Android, iOS and MacOS

## Getting Started

A simple usage example:

```dart
import 'package:vpn_check/vpn_check.dart';

final vpnChecker = VPNCheck();
bool isVpnActive = false;

try {
    isVpnActive = await vpnChecker.isVPNEnabled();
} on VPNUnhandledException catch (e) {
    print(e);
}

vpnChecker.vpnActiveStream.listen((isActive) {
  isVpnActive = isActive;
  print('is vpn active: $isActive');
},
  cancelOnError: false,
);
```
## Support Platform

- [x] Android
- [x] iOS
- [x] MacOS

## Plans
- [ ] Linux
- [ ] Windows

