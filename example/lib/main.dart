import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:platform_wallet/platform_wallet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SafeArea(
            child: FutureBuilder<bool>(
          future: PlatformWallet.instance.isWalletApiAvailable(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            final bool available = snapshot.data!;
            print("Flutter isAvailable: $available");
            if (available) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(hintText: "Pass URL"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (Platform.isAndroid) {
                        try {
                          final GooglePass pass =
                              GooglePass.fromUrl(Uri.parse(controller.text));
                          pass.save();
                        } on PlatformWalletException catch (e) {
                          print("Something went wrong saving google pass...");
                          print(e);
                        }
                      } else if (Platform.isIOS) {
                        try {
                          final PKPass pass =
                              await PKPass.fromUrl(Uri.parse(controller.text));
                          pass.save();
                        } on PlatformWalletException catch (e) {
                          print("Something went wrong saving pkpass...");
                          print(e);
                        }
                      } else {
                        print(
                            "This platform does not support the platform_wallet plugin");
                      }
                    },
                    child: const Text("Get Wallet"),
                  ),
                ],
              );
            }
            return const Center(
              child: Text("Wallet API is not available on this device"),
            );
          },
        )),
      ),
    );
  }
}
