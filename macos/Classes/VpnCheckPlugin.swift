import Cocoa
import FlutterMacOS

public class VpnCheckPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "vpn_check", binaryMessenger: registrar.messenger)
    let instance = VpnCheckPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "vpn_active":
        let isActive = VPNChecker.isVpnActive()
        result(isActive)
        break
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
