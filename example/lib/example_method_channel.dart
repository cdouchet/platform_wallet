import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'example_platform_interface.dart';

/// An implementation of [ExamplePlatform] that uses method channels.
class MethodChannelExample extends ExamplePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('example');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
