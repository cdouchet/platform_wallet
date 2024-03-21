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

       if !passLibrary.containsPass(pass) {
           passLibrary.addPasses([pass]) { (result) in
               if result == PKPassLibraryAddPassesStatus.didAddPasses {
               print("successfully added pass")
             } else {
               print("Error adding pass: \(result)")
             }
         }
        return "done"
       } else {
         return PlatformWalletException.alreadyInWallet().toJsonString()
       }
     } catch {
       return PlatformWalletException.new(error.localizedDescription).toJsonString()
     }
   }
 }
