//
//  DBController.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/31/21.
//

import Foundation
import SQLite3

class DbController {
    let dbPath = "CookieKeeper.sqlite"
    var db: OpaquePointer?
    
    init() {
        db = openConnection()
    }
    
    private func openConnection() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening database")
            return nil
        } else {
            print("Successfully open connection to database at \(dbPath)")
            return db
        }
    }
}
