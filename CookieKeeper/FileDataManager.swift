//
//  FileDataManager.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/31/21.
//

import Foundation

protocol HandleFileData {
    static func SaveToFile(DataList: [Any])
    static func LoadFromFile() -> [Any]
}

class FileDataManager {
    
    static func GetArchiveURL(For fileName: String) -> URL {
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsDir.appendingPathComponent("\(fileName)").appendingPathExtension("plist")
        
        return archiveURL
    }
 
}

class CustomerDataManager: FileDataManager, HandleFileData {
    static let fileName = "customerData"
    
    static func SaveToFile(DataList: [Any]) {
        let propertyListEncoder = PropertyListEncoder()
        let customerList = DataList.map { $0 as! Customer }
        guard let encodedData = try? propertyListEncoder.encode(customerList) else { return }
        
        let archiveURL = GetArchiveURL(For: fileName)
        
        try? encodedData.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func LoadFromFile() -> [Any] {
        let propertyListDecoder = PropertyListDecoder()
        
        let archiveURL = GetArchiveURL(For: fileName)
        
        guard let retrievedData = try? Data(contentsOf: archiveURL),
              let decodedData = try? propertyListDecoder.decode(Array<Customer>.self, from: retrievedData) else { return [] }
        
        return decodedData
    }
}

class OrderDataManager: FileDataManager, HandleFileData {
    static let fileName = "orderData"
    
    static func SaveToFile(DataList: [Any]) {
        let propertyListEncoder = PropertyListEncoder()
        let orderList = DataList.map { $0 as! Order }
        guard let encodedData = try? propertyListEncoder.encode(orderList) else { return }
        
        let archiveURL = GetArchiveURL(For: fileName)
        
        try? encodedData.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func LoadFromFile() -> [Any] {
        let propertyListDecoder = PropertyListDecoder()
        
        let archiveURL = GetArchiveURL(For: fileName)
        
        guard let retrievedData = try? Data(contentsOf: archiveURL),
              let decodedData = try? propertyListDecoder.decode(Array<Order>.self, from: retrievedData) else { return [] }
        
        return decodedData
    }
    
    
}
