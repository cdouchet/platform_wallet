package com.example.platform_wallet

class PlatformWalletException private constructor(val error: String, val description: String) {
    companion object {
        fun unknown(): PlatformWalletException {
            return PlatformWalletException(
                    error = "unknown",
                    description = "An unknown error occurred"
            )
        }

        fun alreadyInWallet(): PlatformWalletException {
            return PlatformWalletException(
                    error = "already_in_wallet",
                    description = "Pass is already in wallet"
            )
        }
    }
}