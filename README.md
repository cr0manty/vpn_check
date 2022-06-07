# vpn_check

get vpn active status for Android, iOS

## Getting Started

a simple usage example:

```
import 'package:vpn_check/vpn_check.dart';

bool isVpnActive = false;

try {
    isVpnActive = await VPNCheck.isVpnActive;
} on VPNUnhandledException catch (e) {
    print(e)
}
```
## Support Platform

- [x] Android
- [x] IOS

