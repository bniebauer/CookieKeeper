//
//  PDFView.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 4/7/21.
//

import SwiftUI
import PDFKit

struct PDFViewer: View {
    let order: Order
    var body: some View {
        PDFKitRepView(order: order)
    }
}

private struct PDFKitRepView: UIViewRepresentable {
    let order: Order
    let pdfCreator: PDFCreator
    
    init(order: Order) {
        self.order = order
        self.pdfCreator = PDFCreator(order: order)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(data: pdfCreator.createFlyer())
        return pdfView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("not sure")
    }
}

struct PDFView_Previews: PreviewProvider {
    static var order: Order {
        let o = Order.testOrder
        o.customer = Customer.testCustomer1
        return o
    }
    static var previews: some View {
        PDFViewer(order: order)
    }
}
