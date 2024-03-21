import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'platform_wallet_method_channel.dart';

abstract class PlatformWalletPlatform extends PlatformInterface {
  /// Constructs a PlatformWalletPlatform.
  PlatformWalletPlatform() : super(token: _token);

  static final Object _token = Object();

  static PlatformWalletPlatform _instance = MethodChannelPlatformWallet();

  /// The default instance of [PlatformWalletPlatform] to use.
  ///
  /// Defaults to [MethodChannelPlatformWallet].
  static PlatformWalletPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PlatformWalletPlatform] when
  /// they register themselves.
  static set instance(PlatformWalletPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> myTest(String input) {
    throw UnimplementedError('myTest() has not been implemented');
  }
}
