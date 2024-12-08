//
//  ReadFromKeyChain.swift
//  TweetTone
//
//  Created by Sampath Kumar Lam on 19/11/24.
//

import Foundation
import Security

func readFromKeychain(key: String) -> String? {
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: key,
        kSecReturnData as String: true, // Return the data
        kSecMatchLimit as String: kSecMatchLimitOne // Limit to one match
    ]
    
    var item: CFTypeRef?
    let status = SecItemCopyMatching(query as CFDictionary, &item)
    
    if status == errSecSuccess {
        if let data = item as? Data {
            return String(data: data, encoding: .utf8)
        }
    } else if status == errSecItemNotFound {
        print("Keychain item not found for key: \(key)")
    } else {
        print("Keychain read failed with error code: \(status)")
    }
    
    return nil
}
