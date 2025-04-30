//
//  UITextField+.swift
//  ATSOPT36_Assignment
//
//  Created by 권석기 on 4/23/25.
//

import UIKit

extension UITextField {
    func setPlaceholder(_ placeholder: String, _ placeholderColor: UIColor) {
           attributedPlaceholder = NSAttributedString(
               string: placeholder,
               attributes: [
                   .foregroundColor: placeholderColor,
                   .font: font
               ].compactMapValues { $0 }
           )
       }
}
