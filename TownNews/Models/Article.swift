//
//  Article.swift
//  TownNews
//
//  Created by maksim on 17.01.2022.
//

import Foundation
struct Article: Codable, Identifiable{
    let id: Int
    let title: String
    let city: String
    let content: String
    let imageUrl: String
    let tag: String
    var isFavorite: Bool
    let creationTime: String
}
