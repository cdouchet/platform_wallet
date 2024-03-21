//
//  PlatformWalletException.swift
//  platform_wallet
//
//  Created by Cyril DOUCHET on 20/03/2024.
//


 struct PlatformWalletException: Codable {
     var error: String
     var description: String

     private init(error: String, description: String) {
         self.error = error
         self.description = description
     }
     
     static func new(_ description: String) -> Self {
         return Self(
            error: "PlatformWalletException",
            description: description
         )
     }

     static func unknow() -> Self {
         return Self(error: "unknown", description: "An unknown error occured")
     }

     static func alreadyInWallet() -> Self {
         return Self(error: "already_in_wallet", description: "Pass is already in wallet")
     }

     func toJsonString() -> String {
         let jsonEncoder = JSONEncoder()
         jsonEncoder.outputFormatting = .prettyPrinted

         let encodeEx = try! jsonEncoder.encode(self)
         let encodeStringEx = String(data: encodeEx, encoding: .utf8)!
         return encodeStringEx
     }
 }
