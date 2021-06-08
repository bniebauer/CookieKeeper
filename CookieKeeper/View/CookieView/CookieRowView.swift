//
//  CookieRowView.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 2/5/21.
//

import SwiftUI

struct CookieRowView: View {
    let cookie: Cookie
    @Binding var numOfBoxes: Int
    var total: Int {
        return numOfBoxes * cookie.price
    }
    
    var body: some View {
        HStack {
            Image(cookie.imageName)
                .resizable()
                .clipShape(Circle())
                .frame(width: 100, height: 100, alignment: .center)
            VStack(alignment: .leading) {
                HStack{
                    Text(cookie.name)
                        .font(.title)
                    
                    Text("($\(cookie.price) per box)").font(.footnote)
                }
                    Text(cookie.description)
                        .font(.subheadline)
                HStack {
                    Text("$\(total).00")
                    Stepper(
                        onIncrement: onAddBoxes,
                        onDecrement: onRemoveBoxes) {
                        Text("\(numOfBoxes) Boxes")
                    }
                }
            }
        }
    }
    
    func onAddBoxes() {
        numOfBoxes += 1
        //updateTotal(numOfBoxes, cookie.name)
        // Increase selection
    }
    
    func onRemoveBoxes() {
        if numOfBoxes > 0 {
            numOfBoxes -= 1
        }
    }
        
}

struct CookieRowView_Previews: PreviewProvider {
    static var previews: some View {
        CookieRowView(cookie: Cookie.cookieTest, numOfBoxes: .constant(0))
    }
}
