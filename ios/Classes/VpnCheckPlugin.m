#import "VpnCheckPlugin.h"
#if __has_include(<vpn_check/vpn_check-Swift.h>)
#import <vpn_check/vpn_check-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "vpn_check-Swift.h"
#endif

@implementation VpnCheckPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftVpnCheckPlugin registerWithRegistrar:registrar];
}
@end
