//
//  ECCEncryption.swift
//  Whisper
//
//  Created by Praveen Singh on 16/12/24.
//


import Foundation
import Security

class ECCEncryption {

    // Generate ECC Key Pair
    static func generateKeyPair() -> (privateKey: SecKey, publicKey: SecKey)? {
        let keyPairAttr: [NSString: Any] = [
            kSecAttrKeyType: kSecAttrKeyTypeEC,
            kSecAttrKeySizeInBits: 256
        ]
        
        var publicKey, privateKey: SecKey?
        let status = SecKeyGeneratePair(keyPairAttr as CFDictionary, &publicKey, &privateKey)
        
        if status == errSecSuccess, let privateKey = privateKey, let publicKey = publicKey {
            return (privateKey, publicKey)
        } else {
            print("Error generating key pair: \(status)")
            return nil
        }
    }
    
    // Encrypt Data with the recipient's public key
    static func encryptData(_ data: Data, with publicKey: SecKey) -> Data? {
        var error: Unmanaged<CFError>?
        
        if let encryptedData = SecKeyCreateEncryptedData(publicKey, .eciesEncryptionStandardX963SHA256AESGCM, data as CFData, &error) {
            return encryptedData as Data
        } else {
            print("Error encrypting data: \(error!.takeRetainedValue())")
            return nil
        }
    }
    
    // Decrypt Data with the recipient's private key
    static func decryptData(_ data: Data, with privateKey: SecKey) -> Data? {
        var error: Unmanaged<CFError>?
        
        if let decryptedData = SecKeyCreateDecryptedData(privateKey, .eciesEncryptionStandardX963SHA256AESGCM, data as CFData, &error) {
            return decryptedData as Data
        } else {
            print("Error decrypting data: \(error!.takeRetainedValue())")
            return nil
        }
    }
    
    // Export public key to Data
    static func exportPublicKey(_ publicKey: SecKey) -> Data? {
        var error: Unmanaged<CFError>?
        
        if let data = SecKeyCopyExternalRepresentation(publicKey, &error) {
            return data as Data
        } else {
            print("Error exporting public key: \(error!.takeRetainedValue())")
            return nil
        }
    }
    
    // Import public key from Data
    static func importPublicKey(from data: Data) -> SecKey? {
        let keyAttributes: [NSString: Any] = [
            kSecAttrKeyType: kSecAttrKeyTypeEC,
            kSecAttrKeyClass: kSecAttrKeyClassPublic
        ]
        
        var error: Unmanaged<CFError>?
        
        if let publicKey = SecKeyCreateWithData(data as CFData, keyAttributes as CFDictionary, &error) {
            return publicKey
        } else {
            print("Error importing public key: \(error!.takeRetainedValue())")
            return nil
        }
    }
}

