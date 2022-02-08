//
//  Tag.swift
//  TownNews
//
//  Created by maksim on 19.01.2022.
//

import Foundation
struct Tag: Codable, Identifiable, Hashable{
    let id: Int
    let title: String
    let important: Bool
}
