enum PlatformWalletExceptionKind {
  alreadyInWallet,
  invalidUrl,
  notAvailable,
  unknown;

  static PlatformWalletExceptionKind fromString(String input) {
    switch (input) {
      case "already_in_wallet":
        return PlatformWalletExceptionKind.alreadyInWallet;
      case "invalid_url":
        return PlatformWalletExceptionKind.invalidUrl;
      case "not_available":
        return PlatformWalletExceptionKind.notAvailable;
      default:
        return PlatformWalletExceptionKind.unknown;
    }
  }
}
