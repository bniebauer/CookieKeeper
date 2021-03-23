//
//  CookieListView.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 2/6/21.
//

import SwiftUI

struct CookieListView: View {
    @EnvironmentObject var dataController: DataController
    @Binding var CookieSelection: [String:Int]
    let cookies = Bundle.main.decode([Cookie].self, from: "cookies.json")
    @State var testNum = 0
    
    var body: some View {
        List {
            ForEach(cookies.indices) { index in
                CookieRowView(cookie: cookies[index], numOfBoxes: 0, updateTotal: updateTotal)
            }
        }
    }
    
    func updateTotal(numOfBoxes: Int, CookieID: String){
        CookieSelection[CookieID] = numOfBoxes
        print(CookieSelection)
    }
}

struct CookieListView_Previews: PreviewProvider {
    static var previews: some View {
        CookieListView(CookieSelection: .constant([String:Int]()))
            .environmentObject(DataController())
            
    }
}
