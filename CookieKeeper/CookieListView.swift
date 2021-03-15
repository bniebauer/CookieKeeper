//
//  CookieListView.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 2/6/21.
//

import SwiftUI

struct CookieListView: View {
    @EnvironmentObject var dataController: DataController
    @State var selection = [0:0]
    let cookies = Bundle.main.decode([Cookie].self, from: "cookies.json")
    
    var body: some View {
        List {
            ForEach(cookies) { cookie in
                CookieRowView(cookie: cookie)
            }
        }
    }
}

struct CookieListView_Previews: PreviewProvider {
    static var previews: some View {
        CookieListView()
            .environmentObject(DataController())
            
    }
}
