//
//  PDFCreator.swift
//  CookieKeeper
//
//  Created by Brenton Niebauer on 4/7/21.
//

import UIKit

class PDFCreator: NSObject {
    let order: Order
    let customer: Customer
    
    init(order: Order) {
        self.order = order
        self.customer = order.customer
    }
    
    func createFlyer() -> Data {
        let pdfMetaData = [
            kCGPDFContextCreator: " My Company",
            kCGPDFContextAuthor: "niebauer.com"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        let pageWidth = 8.5 * 72.0
        let pageHeight = 11 * 72.0
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)
        
        let data = renderer.pdfData { (context) in
            context.beginPage()
            let nextY = addTitle(pageRect: pageRect)
            let _ = addCustomerData(pageRect: pageRect, headerTop: nextY+6.0)
            
        }
        return data
    }
    
    func addTitle(pageRect: CGRect) -> CGFloat {
        let titleFont = UIFont.systemFont(ofSize: 22.0, weight: .bold)
        let titleAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: titleFont]
        let attributedTitle = NSAttributedString(string: "Order: \(order.id.description)", attributes: titleAttributes)
        
        let titleStringSize = attributedTitle.size()
        
        let titleStringRect = CGRect(
            x: (pageRect.width - titleStringSize.width) / 2.0,
            y: 30,
            width: titleStringSize.width,
            height: titleStringSize.height
        )
        
        attributedTitle.draw(in: titleStringRect)
        
        return titleStringRect.origin.y + titleStringRect.size.height
    }
    
    func addCustomerData(pageRect: CGRect, headerTop: CGFloat) -> CGFloat {
        let xValue: CGFloat = 20.0
        let nameRect = addText(pageRect: pageRect, x: xValue, y: headerTop, text: customer.description)
        let phoneRect = addText(pageRect: pageRect, x: xValue, y: nameRect.origin.y+nameRect.size.height, text: customer.phoneNumber)
        let emailRect = addText(pageRect: pageRect, x: xValue, y: phoneRect.origin.y+phoneRect.size.height, text: customer.email)
        
        let columnOneHeight = nameRect.size.height + phoneRect.size.height + emailRect.size.height
        let columnOneWidth = [nameRect.size.width, phoneRect.size.width, emailRect.size.width].max()! + xValue + 15
        
        let streetRect = addText(pageRect: pageRect, x: columnOneWidth, y: headerTop, text: customer.street)
        let _ = addText(pageRect: pageRect, x: columnOneWidth, y: streetRect.origin.y+streetRect.size.height, text: "\(customer.city) \(customer.state) \(customer.zip)")
        
        return emailRect.origin.y+columnOneHeight
    }
    
    func addText(pageRect: CGRect,x: CGFloat, y: CGFloat, text: String) -> CGRect {
        let bodyFont = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        let textColor = UIColor(.orange)

        let textAttributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle,
                              NSAttributedString.Key.foregroundColor: textColor,
                              NSAttributedString.Key.font: bodyFont]
        let attributedText = NSAttributedString(string: text, attributes: textAttributes)
        
        let textStringSize = attributedText.size()
        
        let textRect = CGRect(
            x: x,
            y: y,
            width: textStringSize.width,
            height: textStringSize.height
        )
        
        attributedText.draw(in: textRect)
        
        return textRect
    }
}
