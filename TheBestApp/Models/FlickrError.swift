//
//  FlickrModel.swift
//  TheBestApp
//
//  Created by Evgenii Lukin on 01.12.2022.
//

import Foundation

enum NetworkError: String, Error {
    
    case badUrl = "Check URL"
    case wrongJsonFormat = "Check JSON"
    case dataIsNil = "Data == nil"
    case itemsIsNil = "Array of items from flickr is nil"
}
