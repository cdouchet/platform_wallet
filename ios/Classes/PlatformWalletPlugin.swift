import Flutter
import UIKit
import PassKit

public class PlatformWalletPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "platform_wallet", binaryMessenger: registrar.messenger())
    let instance = PlatformWalletPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
     case "addPkPass":
       result(addPkPass(call.arguments as! FlutterStandardTypedData))
    case "myTest":
      result(myTest(call.arguments as! String))
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func myTest(_ didi: String) -> String {
    print("myTest from swift: " + didi)
    return didi
  }

   private func addPkPass(_ bytes: FlutterStandardTypedData) -> String {
     do {
       let passData = Data(bytes.data)
       let pass = try PKPass(data: passData)

       let passLibrary = PKPassLibrary()
       guard let pkvc = PKAddPassesViewController(pass: pass) else {
           return PlatformWalletException.unknow().toJsonString()
       }
       guard let rvc = UIApplication.shared.keyWindow?.rootViewController else {
           return PlatformWalletException.unknow().toJsonString()
       }
       rvc.present(pkvc, animated: true)
        return "done"
     } catch {
       return PlatformWalletException.new(error.localizedDescription).toJsonString()
     }
   }
 }
