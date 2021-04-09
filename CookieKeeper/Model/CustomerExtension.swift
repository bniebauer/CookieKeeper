//
//  CustomerExtension.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/31/21.
//

import Foundation
import SQLite3

extension Customer {
    func Save() -> Bool {
        var saveResult = false
        if self.id > 0 {
            let original = Get(ByID: self.id)
            if self != original {
                let insertStatementString =
                    """
                    INSERT INTO customer VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?);
                    """
                var insertStatement: OpaquePointer? = nil
                
                if sqlite3_prepare_v2(Customer.dbController.db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                    sqlite3_bind_int(insertStatement, 1, Int32(self.id))
                    sqlite3_bind_text(insertStatement, 2, (self.firstName as NSString).utf8String, -1, nil)
                    sqlite3_bind_text(insertStatement, 3, (self.lastName as NSString).utf8String, -1, nil)
                    sqlite3_bind_text(insertStatement, 4, (self.street as NSString).utf8String, -1, nil)
                    sqlite3_bind_text(insertStatement, 5, (self.city as NSString).utf8String, -1, nil)
                    sqlite3_bind_text(insertStatement, 6, (self.state as NSString).utf8String, -1, nil)
                    sqlite3_bind_text(insertStatement, 7, (self.zip as NSString).utf8String, -1, nil)
                    sqlite3_bind_text(insertStatement, 8, (self.phoneNumber as NSString).utf8String, -1, nil)
                    sqlite3_bind_text(insertStatement, 9, (self.email as NSString).utf8String, -1, nil)
                    
                    if sqlite3_step(insertStatement) == SQLITE_DONE {
                        print("Successfully inserted row.")
                        saveResult = true
                    } else {
                        print("Could not insert row")
                    }
                } else {
                    print("INSERT statement could not be prepared.")
                }
                sqlite3_finalize(insertStatement)
            } else {
                print("There is nothing new to save")
            }
        }
        
        return saveResult
    }
    
    func Get(ByID id: Int) -> Customer {
        let getStatementString = "SELECT * FROM customer WHERE id = ?;"
        var getStatement: OpaquePointer? = nil
        var foundCustomer = Customer()
        
        if sqlite3_prepare_v2(Customer.dbController.db, getStatementString, -1, &getStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(getStatement, 1, Int32(self.id))
            while sqlite3_step(getStatement) == SQLITE_ROW {
                let firstName = String(describing: String(cString: sqlite3_column_text(getStatement, 1)))
                let lastName = String(describing: String(cString: sqlite3_column_text(getStatement, 2)))
                let street = String(describing: String(cString: sqlite3_column_text(getStatement, 3)))
                let city = String(describing: String(cString: sqlite3_column_text(getStatement, 4)))
                let state = String(describing: String(cString: sqlite3_column_text(getStatement, 5)))
                let zip = String(describing: String(cString: sqlite3_column_text(getStatement, 6)))
                let phoneNumber = String(describing: String(cString: sqlite3_column_text(getStatement, 7)))
                let email = String(describing: String(cString: sqlite3_column_text(getStatement, 8)))
                
                foundCustomer = Customer(id: id, firstName: firstName, lastName: lastName, street: street, city: city, state: state, zip: zip, phoneNumber: phoneNumber, email: email)
                print("Query Results found")
            }
        } else {
            print("SELECT statement from customer could not be prepared.")
        }
        sqlite3_finalize(getStatement)
        
        return foundCustomer
    }
    
    static func GetAllCustomers() -> [Customer] {
        let queryStatementString = "SELECT * FROM customer;"
        var queryStatement: OpaquePointer? = nil
        var customers : [Customer] = []
        if sqlite3_prepare_v2(Customer.dbController.db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            print("Reading from database...")
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let firstName = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let lastName = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let street = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let city = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let state = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let zip = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let phoneNumber = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
                let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 8)))
                
                customers.append(Customer(id: Int(id), firstName: firstName, lastName: lastName, street: street, city: city, state: state, zip: zip, phoneNumber: phoneNumber, email: email))
            }
        } else {
            print("SELECT statement from table: customer could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return customers
    }
}
