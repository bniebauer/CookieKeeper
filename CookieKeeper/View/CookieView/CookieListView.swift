//
//  CookieListView.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 2/6/21.
//

import SwiftUI

struct CookieListView: View {
    @Binding var CookieSelection: [String:Int]
    @Binding var PriceTotal: Int
    let cookies: [Cookie]
    var body: some View {
        List {
            ForEach(cookies.indices) { index in
                CookieRowView(cookie: cookies[index], numOfBoxes: getSelectedNumberOf(Cookie: cookies[index]), updateTotal: updateTotal)
            }
        }
    }
    
    func updateTotal(numOfBoxes: Int, CookieID: String){
        CookieSelection[CookieID] = numOfBoxes
        if let cookie = cookies.first(where: {$0.name == CookieID}) {
            PriceTotal += cookie.price * numOfBoxes
        }
    }
    
    func getSelectedNumberOf(Cookie: Cookie) -> Int {
        guard let numberOfBoxes = CookieSelection[Cookie.name] else { return 0 }
        return numberOfBoxes
    }
}

struct CookieListView_Previews: PreviewProvider {
    static var previews: some View {
        CookieListView(CookieSelection: .constant([String:Int]()), PriceTotal: .constant(0), cookies: [Cookie]())
            .environmentObject(DataController())
            
    }
}
