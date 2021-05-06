//
//  UIExtension.swift
//  CarTrack
//
//  Created by SCTT CDMS on 6/5/21.
//

import Foundation
import UIKit

extension UITextField {
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.orange.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
        
    }
}

extension UIViewController{
    func displayAlert(alertMessage: String) {
        let alert = UIAlertController(title: "ALERT", message:alertMessage , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
