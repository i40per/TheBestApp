//
//  Items + Extension.swift
//  TheBestApp
//
//  Created by Evgenii Lukin on 03.12.2022.
//

import Foundation

extension Items {
    
    func getDateNonOptionalFromPublished() -> Date {
        
        guard let published = self.published else { return Date() }
        return published.convertToDate()
    }
}
