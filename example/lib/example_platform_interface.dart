import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'example_method_channel.dart';

abstract class ExamplePlatform extends PlatformInterface {
  /// Constructs a ExamplePlatform.
  ExamplePlatform() : super(token: _token);

  static final Object _token = Object();

  static ExamplePlatform _instance = MethodChannelExample();

  /// The default instance of [ExamplePlatform] to use.
  ///
  /// Defaults to [MethodChannelExample].
  static ExamplePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ExamplePlatform] when
  /// they register themselves.
  static set instance(ExamplePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
