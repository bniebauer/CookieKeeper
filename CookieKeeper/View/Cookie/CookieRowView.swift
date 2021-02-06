//
//  CookieRowView.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 2/5/21.
//

import SwiftUI

struct CookieRowView: View {
    @Binding var cookie: Cookie
    var body: some View {
        HStack {
            Text(cookie.name)
            Text("$\(String(format: "%.2f", cookie.price))")
        }
    }
}

struct CookieRowView_Previews: PreviewProvider {
    static var previews: some View {
        CookieRowView(cookie: .constant(Cookie.cookieTest))
    }
}
