//
//  PromoListViewModel.swift
//  TownNews
//
//  Created by maksim on 18.01.2022.
//

import Foundation
class PromosListViewModel: ObservableObject{
    @Published var promos: [Promo] = []
    
    func fetchPromos() {
        let apiService = APIService(urlString: "https://townnews.site/promoslist")
        apiService.getJSON {(result: Result<[Promo], APIError>) in
            switch result {
            case .success(let promos):
                DispatchQueue.main.async {
                    self.promos = promos
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
