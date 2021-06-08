//
//  Cookie.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 1/29/21.
//

import SwiftUI

struct Cookie: Codable, Identifiable, Hashable {
    var id: UUID
    var name: String
    var description: String
    var price: Int
    
    var imageName: String {
        name.replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "'", with: "")
            .lowercased()
    }
    
    #if DEBUG
    static let cookieTest = Cookie(id: UUID(), name: "dosidos", description: "Test cookie, doesn't taste good.", price: 6)
    #endif
}

