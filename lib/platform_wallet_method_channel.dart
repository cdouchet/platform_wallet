import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'platform_wallet_platform_interface.dart';

/// An implementation of [PlatformWalletPlatform] that uses method channels.
class MethodChannelPlatformWallet extends PlatformWalletPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('platform_wallet');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> myTest(String input) async {
    final didi = await methodChannel.invokeMethod<String>('myTest', input);
    return didi;
  }
}
