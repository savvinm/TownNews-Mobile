//
//  ViewModelWithStatus.swift
//  TownNews
//
//  Created by Maksim Savvin on 18.09.2022.
//

import Foundation

enum ViewModelStatus {
    case loading
    case success
    case error(_ error: Error)
}

protocol ViewModelWithStatus {
    var status: ViewModelStatus { get }
}
