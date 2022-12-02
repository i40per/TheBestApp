//
//  UILabel + Extensions.swift
//  TheBestApp
//
//  Created by Evgenii Lukin on 01.12.2022.
//

import UIKit

extension UILabel {
    convenience init(text: String = "", font: UIFont?, color: UIColor, line: Int) {
        self.init()
        
        self.numberOfLines = line
        self.text = text
        self.font = font
        self.textColor = color
        self.textAlignment = .left
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
