//
//  FlickrSerchResults.swift
//  TheBestApp
//
//  Created by Evgenii Lukin on 01.12.2022.
//

import Foundation

struct FlickrSearch: Codable {
    let items: [Items]?
}

struct Items: Codable {
    
    let title: String?
    let media: Media?
    let published: String?
    let tags: String?
}

struct Media: Codable {
    let m: String?
}
