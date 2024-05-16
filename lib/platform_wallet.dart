// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.
library platform_wallet;

import 'package:platform_wallet/method_channel.dart';

export "models/exports.dart";

/// PlatformWallet is an utility singleton object.
///
/// To check whether the wallet api is available on the device, use:
///
/// ```dart
/// PlatformWallet.instance.isWalletApiAvailable()
/// ```
class PlatformWallet {
  static final PlatformWallet instance = PlatformWallet._internal();

  PlatformWallet._internal();

  Future<bool> isWalletApiAvailable() async {
    return (await methodChannel.invokeMethod<bool>("isWalletApiAvailable")) ??
        false;
  }
}
