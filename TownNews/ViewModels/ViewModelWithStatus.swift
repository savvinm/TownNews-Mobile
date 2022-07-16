//
//  ViewModelWithStatus.swift
//  TownNews
//
//  Created by Maksim Savvin on 16.07.2022.
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
