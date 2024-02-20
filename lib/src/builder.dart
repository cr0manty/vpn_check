import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:vpn_check/src/vpn_check.dart';

enum VPNStatus {
  active,
  disabled,
  unknown,
}

typedef WidgetBuilder = Widget Function(BuildContext context, VPNStatus value);

@immutable
class VPNStatusBuilder extends StatelessWidget {
  final VPNChecker? checker;
  final WidgetBuilder builder;

  const VPNStatusBuilder({
    required this.builder,
    this.checker,
    super.key,
  });

  @override
  Widget build(BuildContext context) => StreamBuilder<bool>(
        stream: checker?.vpnActivityStream ?? VPNChecker().vpnActivityStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return builder(context, VPNStatus.unknown);
          }

          return builder.call(
            context,
            (snapshot.data ?? false) ? VPNStatus.active : VPNStatus.disabled,
          );
        },
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) =>
      super.debugFillProperties(
        properties
          ..add(
            StringProperty(
              'description',
              'VPNStatusBuilder StatelessWidget',
            ),
          ),
      );
}
