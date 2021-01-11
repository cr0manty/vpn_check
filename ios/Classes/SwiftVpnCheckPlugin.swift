import Flutter

extension String: Error {}


public class SwiftVpnCheckPlugin: NSObject, FlutterPlugin {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "vpn_check", binaryMessenger: registrar.messenger())
    let instance = SwiftVpnCheckPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

    private func notImplemented() throws {
        throw "Not implemented"
    }
    
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "vpn_active":
        result(VPNChecker.isVpnActive())
        break
    default:
        break
    }
  }
}
