# platform_wallet

Save your wallet passes on both iOS & Android.

## Why this plugin ?

The plugin add_to_wallet, used to save passes on iOS, blocks builds on Android. Since I needed to build on both platforms, I made this simple plugin to allow both platforms to use passes and allow builds.

## Installation

Install this plugin by running
```
flutter pub add platform_wallet
```

## Usage

You can check if the Wallet API is available on the device :
```dart
PlatformWallet.instance.isWalletApiAvailable();
```

### iOS
```dart
final Uri uri = Uri.parse("https://example.com/pass.pkpass");
try {
	final PKPass pass = await PKPass.fromUrl(
		uri,
		headers: {"Authorization": "Bearer ..."},
	);
	pass.save();
} on PlatformWalletException catch (e) {
	print("Something went wrong...");
	print(e);
}
```

### Android
```dart
final Uri uri = Uri.parse("https://pay.google.com/gp/v/save/ey...");  
try {
	final GooglePass pass = GooglePass.fromUrl(uri);
	pass.save();
} on PlatformWalletException catch (e) {
	print("Something went wrong...");
	print(e);
}
```