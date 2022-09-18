//
//  MissingsListViewModel.swift
//  TownNews
//
//  Created by maksim on 18.01.2022.
//

import SwiftUI

class MissingsViewModel: ViewModelWithStatus, ObservableObject {
    
    @Published private(set) var missings: [Missing] = []
    @Published private(set) var status = ViewModelStatus.success
    
    func fetchMissings(isForAuthor: Bool) {
        let urlString = isForAuthor ? "https://townnews.site/usermissinglist/" + String(UIDevice.current.identifierForVendor!.uuidString) : "https://townnews.site/missinglist"
        let apiService = APIService(urlString: urlString)
        apiService.getJSON { (result: Result<[Missing], APIError>) in
            switch result {
            case .success(let missings):
                DispatchQueue.main.async { [weak self] in
                    self?.missings = missings
                    self?.status = .success
                }
            case .failure(let error):
                print(error)
                self.status = .error(error)
            }
        }
    }
}
