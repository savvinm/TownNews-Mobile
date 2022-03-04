//
//  ArticlesListViewModel.swift
//  TownNews
//
//  Created by maksim on 17.01.2022.
//

import Foundation
import UIKit
class ArticlesListViewModel: ObservableObject{
    @Published var articles: [Article] = []
    
    func fetchArticles() {
        let apiService = APIService(urlString: "https://townnews.site/articleslist/" + String(UIDevice.current.identifierForVendor!.uuidString))
        apiService.getJSON {(result: Result<[Article], APIError>) in
            switch result {
            case .success(let articles):
                DispatchQueue.main.async {
                    self.articles = articles
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func fetchArticles(id: Int) {
        if(id <= 1){
            fetchArticles()
        }
        else{
            let url = "https://townnews.site/articleslist/" + String(id-1) + "/" + String(UIDevice.current.identifierForVendor!.uuidString)
            let apiService = APIService(urlString: url)
            apiService.getJSON {(result: Result<[Article], APIError>) in
                switch result {
                case .success(let articles):
                    DispatchQueue.main.async {
                        self.articles = articles
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    func fetchFavorite(){
        let apiService = APIService(urlString: "https://townnews.site/favoriteslist/" + String(UIDevice.current.identifierForVendor!.uuidString))
        apiService.getJSON {(result: Result<[Article], APIError>) in
            switch result {
            case .success(let articles):
                DispatchQueue.main.async {
                    self.articles = articles
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
