import 'package:platform_wallet/platform_wallet.dart';

class PlatformWalletException implements Exception {
  final PlatformWalletExceptionKind kind;
  final String error;
  final String? description;

  PlatformWalletException({
    required this.kind,
    required this.error,
    required this.description,
  });

  factory PlatformWalletException.fromJson(Map<String, dynamic> json) =>
      PlatformWalletException(
        kind: PlatformWalletExceptionKind.fromString(json["error"]),
        error: json["error"],
        description: json["description"],
      );

  factory PlatformWalletException.invalidUrl(String description) =>
      PlatformWalletException(
        kind: PlatformWalletExceptionKind.invalidUrl,
        error: "Invalid Url",
        description: description,
      );

  factory PlatformWalletException.notAvailable() => PlatformWalletException(
        kind: PlatformWalletExceptionKind.notAvailable,
        error: "Wallet API is not available on this device",
        description: null,
      );

  factory PlatformWalletException.unknown() => PlatformWalletException(
      kind: PlatformWalletExceptionKind.unknown,
      error: "Unknown",
      description: null);

  @override
  String toString() =>
      "PlatformWalletException of kind $kind:\n $error.\n Details: $description";
}
