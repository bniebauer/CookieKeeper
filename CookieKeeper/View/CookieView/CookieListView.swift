//
//  CookieListView.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 2/6/21.
//

import SwiftUI

struct CookieListView: View {
    let cookies: [Cookie]
    @Binding var CookieSelection: [String:Int]
    
    var body: some View {
        List {
            ForEach(cookies.indices, id: \.self) { index in
                let cookie = cookies[index]
                let numOfBoxes = Binding(get: {
                    return CookieSelection[cookie.name] ?? 0
                }, set: {
                    CookieSelection[cookie.name] = $0
                })
                CookieRowView(cookie: cookie, numOfBoxes: numOfBoxes)
            }
        }
    }
}

struct CookieListView_Previews: PreviewProvider {
    static var previews: some View {
        let cookieArray = [Cookie.cookieTest.name: 2]
        CookieListView(cookies: [Cookie.cookieTest, Cookie.cookieTest], CookieSelection: .constant(cookieArray))
            .environmentObject(DataController())
            
    }
}
