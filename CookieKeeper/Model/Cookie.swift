//
//  Cookie.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/29/21.
//

import Foundation

struct Cookie: Codable {
    var id: Int
    var name: String
    var description: String
    var price: Double
}

extension Cookie {
    static var cookieTest: Cookie = Cookie(id: 1, name: "Thin Mints", description: "Delicious mint and chocolate", price: 5.0)
    static var cookieCollectionTest: [Cookie] = [
        Cookie(id: 1, name: "Thin Mints", description: "Delicious mint and chocolate", price: 5.0),
        Cookie(id: 2, name: "Trefoils", description: "Great sugar cookies", price: 5.0),
        Cookie(id: 3, name: "Tagalong", description: "Peanut-butter and chocolate", price: 5.0)
    ]
}
