//
//  PromoListViewModel.swift
//  TownNews
//
//  Created by maksim on 18.01.2022.
//

import Foundation

class PromosViewModel: ViewModelWithStatus, ObservableObject {
    
    @Published private(set) var promos: [Promo] = []
    @Published private(set) var status = ViewModelStatus.loading
    
    func fetchPromos() {
        let apiService = APIService(urlString: "https://townnews.site/promoslist")
        apiService.getJSON { (result: Result<[Promo], APIError>) in
            switch result {
            case .success(let promos):
                DispatchQueue.main.async { [weak self] in
                    self?.promos = promos
                    self?.status = .success
                }
            case .failure(let error):
                print(error)
                self.status = .error(error)
            }
        }
    }
}
