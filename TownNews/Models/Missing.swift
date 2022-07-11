//
//  Missing.swift
//  TownNews
//
//  Created by maksim on 18.01.2022.
//

import Foundation

struct Missing: Codable, Identifiable {
    let id: Int
    let name: String
    let clothes: String
    let specCharacteristics: String
    let characteristics: String
    let imageUrl: String
    let age: String
    let sex: String
    let lastLocation: String
    let telephone: String
    let status: String
}
