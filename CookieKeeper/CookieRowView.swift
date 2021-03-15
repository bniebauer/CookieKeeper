//
//  CookieRowView.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 2/5/21.
//

import SwiftUI

struct CookieRowView: View {
    @State var numOfBoxes = 0
    @State var total: Int = 0
    let cookie: Cookie
    
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
                    
                    Text("($\(String(format: "%.2f", cookie.price)) per box)").font(.footnote)
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
        total = cookie.price * numOfBoxes
        // Increase selection
    }
    
    func onRemoveBoxes() {
        if numOfBoxes > 0 {
            numOfBoxes -= 1
            total = cookie.price * numOfBoxes
            // Decrease selection
        } else {
            numOfBoxes = 0
        }
    }
}

struct CookieRowView_Previews: PreviewProvider {
    static var previews: some View {
        CookieRowView(cookie: Cookie.cookieTest)
    }
}
