//
//  Int+Extensions.swift
//  ProductList
//
//  Created by u2233825 on 05/04/24.
//

import Foundation
import UIKit

extension Int {
    var stringValue:String {
        return "\(self)"
    }
}

extension Double {
    var stringValue:String {
        return "\(self)"
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        0 <= index && index < count ? self[index] : nil
    }
}

extension UIViewController {
    public func showAlertMessage(title: String, message: String){
        let alertMessagePopUpBox = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alertMessagePopUpBox.addAction(okButton)
        self.present(alertMessagePopUpBox, animated: true)
    }
}
