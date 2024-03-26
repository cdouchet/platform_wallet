
import 'example_platform_interface.dart';

class Example {
  Future<String?> getPlatformVersion() {
    return ExamplePlatform.instance.getPlatformVersion();
  }
}
