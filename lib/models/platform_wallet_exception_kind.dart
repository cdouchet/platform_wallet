enum PlatformWalletExceptionKind {
  alreadyInWallet,
  unknown;

  static PlatformWalletExceptionKind fromString(String input) {
    switch (input) {
      case "already_in_wallet":
        return PlatformWalletExceptionKind.alreadyInWallet;
      default:
        return PlatformWalletExceptionKind.unknown;
    }
  }
}
