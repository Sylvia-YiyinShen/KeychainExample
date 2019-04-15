//
//  KeychainManager.swift
//  KeychainExample
//
//  Created by Yiyin Shen on 15/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import Foundation

class KeychainManager: NSObject {

    class func createQuaryMutableDictionary(identifier: String) -> NSMutableDictionary {
        let keychainQuaryMutableDictionary = NSMutableDictionary.init(capacity: 0)
        keychainQuaryMutableDictionary.setValue(kSecClassGenericPassword, forKey: kSecClass as String)
        keychainQuaryMutableDictionary.setValue(identifier, forKey: kSecAttrService as String)
        keychainQuaryMutableDictionary.setValue(identifier, forKey: kSecAttrAccount as String)
        keychainQuaryMutableDictionary.setValue(kSecAttrAccessibleAfterFirstUnlock, forKey: kSecAttrAccessible as String)
        return keychainQuaryMutableDictionary
    }

    class func saveObject<T: Encodable>(object: T, withIdentifier identifier: String) -> Bool {
        if let data = try? JSONEncoder().encode(object) {
            return saveData(data: data, withIdentifier: identifier)
        } else {
            return false
        }
    }
    
    class func deleteData(for identifier: String) -> Bool {
        let keyChainSaveMutableDictionary = createQuaryMutableDictionary(identifier: identifier)
        let deleteState = SecItemDelete(keyChainSaveMutableDictionary)
        if deleteState == noErr {
            return true
        } else {
            return false
        }
    }

    class func saveData(data: Any ,withIdentifier identifier:String) -> Bool {
        let keyChainSaveMutableDictionary = createQuaryMutableDictionary(identifier: identifier)
        SecItemDelete(keyChainSaveMutableDictionary)
        do {
            let archivedData = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true)
            keyChainSaveMutableDictionary.setValue(archivedData, forKey: kSecValueData as String)
            let saveState = SecItemAdd(keyChainSaveMutableDictionary, nil)
            if saveState == noErr  {
                return true
            }
        } catch {
            return false
        }
        return false
    }

    class func readObject<T: Decodable>(identifier:String) -> T? {
        if let data = readData(identifier: identifier) as? Data {
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                return object
            } catch {
                let errorMessage = error.localizedDescription
                assertionFailure(errorMessage)
                return nil
            }
        } else {
            return nil
        }
    }

    class func readData(identifier: String)-> Any? {
        let keyChainReadmutableDictionary = self.createQuaryMutableDictionary(identifier: identifier)
        keyChainReadmutableDictionary.setValue(kCFBooleanTrue, forKey: kSecReturnData as String)
        keyChainReadmutableDictionary.setValue(kSecMatchLimitOne, forKey: kSecMatchLimit as String)
        var queryResult: AnyObject?
        let readStatus = withUnsafeMutablePointer(to: &queryResult) { SecItemCopyMatching(keyChainReadmutableDictionary, UnsafeMutablePointer($0))}

        if readStatus == errSecSuccess {
            if let data = queryResult as! Data? {
                do {
                    return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
                } catch {
                    return nil
                }
            }
        }
        return nil
    }
    
    class func updataData(data: Any ,withIdentifier identifier:String) -> Bool {
        let keyChainUpdataMutableDictionary = self.createQuaryMutableDictionary(identifier: identifier)
        let updataMutableDictionary = NSMutableDictionary.init(capacity: 0)
        do {
            let archivedData = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true)
            updataMutableDictionary.setValue(archivedData, forKey: kSecValueData as String)
            let updataStatus = SecItemUpdate(keyChainUpdataMutableDictionary, updataMutableDictionary)
            if updataStatus == noErr {
                return true
            }
        } catch {
            return false
        }
        
        return false
    }
}
