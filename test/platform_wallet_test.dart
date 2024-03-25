import 'package:flutter_test/flutter_test.dart';
import 'package:platform_wallet/platform_wallet.dart';
import 'package:platform_wallet/platform_wallet_platform_interface.dart';
import 'package:platform_wallet/platform_wallet_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPlatformWalletPlatform
    with MockPlatformInterfaceMixin
    implements PlatformWalletPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String?> myTest(String input) => Future.value(input);
}

void main() {
  final PlatformWalletPlatform initialPlatform = PlatformWalletPlatform.instance;

  test('$MethodChannelPlatformWallet is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPlatformWallet>());
  });

  // test('getPlatformVersion', () async {
  //   MockPlatformWalletPlatform fakePlatform = MockPlatformWalletPlatform();
  //   PlatformWalletPlatform.instance = fakePlatform;

  //   expect(await PlatformWallet.instance.getPlatformVersion(), '42');
  // });
}
