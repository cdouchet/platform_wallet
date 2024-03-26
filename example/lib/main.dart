import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
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
    try {
      // platformVersion = await PlatformWallet.instance.getPlatformVersion() ??
      'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    try {
      // final didi = await PlatformWallet.instance.myTest('Bingus');
      // print("Result of didi: $didi");
    } on PlatformException {
      print("Big error");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // setState(() {
    //   _platformVersion = platformVersion;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              // final pass = await PKPass.fromUrl(
              //   Uri.parse(
              //       "https://connect-api-rec.onepoint.cloud/wallet/qr/LMZGZmzAAWN?returnType=binary&is_google=false"),
              // );
              print("Is google wallet available: ${PlatformWallet.instance.isWalletApiAvailable()}");
              final pass = GooglePass.fromUrl(Uri.parse(
                  "https://pay.google.com/gp/v/save/eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJjb21wdGUtZGUtc2VydmljZS10ZXN0LWNvbm5lY3RAcHJpbWV2YWwtdm95YWdlLTQxNDkxNy5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsImlhdCI6MTcxMTQ2Njc3NCwiYXVkIjoiZ29vZ2xlIiwib3JpZ2lucyI6WyJ3d3cuZXhhbXBsZS5jb20iXSwidHlwIjoic2F2ZXRvd2FsbGV0IiwicGF5bG9hZCI6eyJnZW5lcmljT2JqZWN0cyI6W3siY2xhc3NJZCI6IjMzODgwMDAwMDAwMjIyNTI1NDkuMTk0IiwiZ2VuZXJpY1R5cGUiOiJnZW5lcmljVHlwZVVuc3BlY2lmaWVkIiwiaGFzVXNlcnMiOmZhbHNlLCJoZXhCYWNrZ3JvdW5kQ29sb3IiOiIjMzMzMzMzIiwiaWQiOiIzMzg4MDAwMDAwMDIyMjUyNTQ5LjE5NC0xNDMxIiwic21hcnRUYXBSZWRlbXB0aW9uVmFsdWUiOm51bGwsInN0YXRlIjoiYWN0aXZlIiwiY2FyZFRpdGxlIjp7ImtpbmQiOiJ3YWxsZXRvYmplY3RzI2xvY2FsaXplZFN0cmluZyIsImRlZmF1bHRWYWx1ZSI6eyJraW5kIjoid2FsbGV0b2JqZWN0cyN0cmFuc2xhdGVkU3RyaW5nIiwibGFuZ3VhZ2UiOiJlbi1VUyIsInZhbHVlIjoiVGVzdCBFdmVuZW1lbnQgd2FsbGV0IG5vIGltYWdlIn19LCJzdWJoZWFkZXIiOnsia2luZCI6IndhbGxldG9iamVjdHMjbG9jYWxpemVkU3RyaW5nIiwiZGVmYXVsdFZhbHVlIjp7ImtpbmQiOiJ3YWxsZXRvYmplY3RzI3RyYW5zbGF0ZWRTdHJpbmciLCJsYW5ndWFnZSI6ImVuLVVTIiwidmFsdWUiOiJMZSAyNS8zLzIwMjQgXHUwMGUwIDE2OjMxIGF1IDI5IFJ1ZSBkZXMgU2FibG9ucyBcdTAwZTAgUGFyaXMifX0sImhlYWRlciI6eyJraW5kIjoid2FsbGV0b2JqZWN0cyNsb2NhbGl6ZWRTdHJpbmciLCJkZWZhdWx0VmFsdWUiOnsia2luZCI6IndhbGxldG9iamVjdHMjdHJhbnNsYXRlZFN0cmluZyIsImxhbmd1YWdlIjoiZW4tVVMiLCJ2YWx1ZSI6IkN5cmlsIHVwZGF0aW5ubmdnZyBET1VDSEVUIn19LCJsb2dvIjp7ImtpbmQiOiJ3YWxsZXRvYmplY3RzI2ltYWdlIiwic291cmNlVXJpIjp7ImRlc2NyaXB0aW9uIjpudWxsLCJ1cmkiOiJodHRwczovL2Nvbm5lY3QtYXBpLm9uZXBvaW50LmNsb3VkL2Fzc2V0cy93YWxsZXQvbG9nbzJ4LnBuZyJ9LCJjb250ZW50RGVzY3JpcHRpb24iOnsia2luZCI6IndhbGxldG9iamVjdHMjbG9jYWxpemVkU3RyaW5nIiwiZGVmYXVsdFZhbHVlIjp7ImtpbmQiOiJ3YWxsZXRvYmplY3RzI3RyYW5zbGF0ZWRTdHJpbmciLCJsYW5ndWFnZSI6ImZyLUZSIiwidmFsdWUiOiJMT0dPX0lNQUdFX0RFU0NSSVBUSU9OIn19fSwiYmFyY29kZSI6eyJhbHRlcm5hdGVUZXh0IjoiIiwia2luZCI6IndhbGxldG9iamVjdHMjYmFyY29kZSIsInJlbmRlckVuY29kaW5nIjpudWxsLCJ0eXBlIjoicXJDb2RlIiwidmFsdWUiOiJMTVpHWm16QUFXTiJ9LCJ0ZXh0TW9kdWxlc0RhdGEiOlt7ImJvZHkiOiIyNS8zLzIwMjQiLCJoZWFkZXIiOiJEYXRlIiwiaWQiOiJzdGFydF9kYXRlIn0seyJib2R5IjoiMTY6MzEiLCJoZWFkZXIiOiJIZXVyZSIsImlkIjoic3RhcnRfdGltZSJ9XX1dfX0.W4RIyhsoE02PpFq1LGH5maj4bpfLsRl5_fkcL7IDk4uHDbpbGlNR6y_mtj3v3BjrjtbsuCzq02PUvun0_-eLSVju1lQVVg7qravpC3T8se-d2-HyWtkhznhxbhwDRfHEHciZuXy7k17OXAFOLTyHa40NGnj4n-h5xsdtWtCSzw7rzEZtibOZMvlyZc8e3IkGLnKYbXDD97ND04BLH4waznTBxW8d8HLLwPLFJFulgNIOYZ1mFXiKFFN8edZxOikZvR6TK0Q85HBrSs85Y2Dt4Z-wdGr5_qzPf-xUUxKx6fgLD5vQIffPJ5h3Vvl7GXhF34cU4Ho7uDbX9n-pblpOVQ"));
              pass.save();
            },
            child: Text("Save wallet"),
          ),
        ),
      ),
    );
  }
}
