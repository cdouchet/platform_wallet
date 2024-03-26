enum PlatformWalletExceptionKind {
  alreadyInWallet,
  invalidUrl,
  unknown;

  static PlatformWalletExceptionKind fromString(String input) {
    switch (input) {
      case "already_in_wallet":
        return PlatformWalletExceptionKind.alreadyInWallet;
      case "invalid_url":
        return PlatformWalletExceptionKind.invalidUrl;
      default:
        return PlatformWalletExceptionKind.unknown;
    }
  }
}
