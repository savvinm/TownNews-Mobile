//
//  MissingsListViewModel.swift
//  TownNews
//
//  Created by maksim on 18.01.2022.
//

import Foundation
import UIKit
class MissingsListViewModel: ObservableObject{
    @Published var missings: [Missing] = []
    
    func fetchMissings() {
        let apiService = APIService(urlString: "https://townnews.site/missinglist")
        apiService.getJSON {(result: Result<[Missing], APIError>) in
            switch result {
            case .success(let missings):
                DispatchQueue.main.async {
                    self.missings = missings
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchUserMissings() {
        let apiService = APIService(urlString: "https://townnews.site/usermissinglist/" + String(UIDevice.current.identifierForVendor!.uuidString))
        apiService.getJSON {(result: Result<[Missing], APIError>) in
            switch result {
            case .success(let missings):
                DispatchQueue.main.async {
                    self.missings = missings
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
