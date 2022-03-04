//
//  Promo.swift
//  TownNews
//
//  Created by maksim on 18.01.2022.
//

import Foundation
struct Promo: Codable, Identifiable{
    let id: Int
    let title: String
    let promocode: String
    let imageUrl: String
}
