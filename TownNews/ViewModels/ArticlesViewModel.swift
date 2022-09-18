//
//  ArticlesListViewModel.swift
//  TownNews
//
//  Created by maksim on 17.01.2022.
//

import SwiftUI

class ArticlesViewModel: ViewModelWithStatus, ObservableObject {
    
    @Published private(set) var articles: [Article] = []
    var currentTag = 1
    var isDeeplinking = false
    @Published var activeArticle: Int?
    @Published private(set) var status = ViewModelStatus.loading
    
    func change(id: Int) {
        let isLoad = getOnlyOne(id: id)
        if isLoad {
            activeArticle = id
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
                self?.isDeeplinking = false
            }
        } else {
            fetchArticleBy(id)
        }
    }

    func getOnlyOne(id: Int) -> Bool {
        if let index = articles.firstIndex(where: { $0.id == id }) {
            var newList = [Article]()
            newList.append(articles[index])
            articles = newList
            return true
        }
        return false
    }
    
    func fetchArticleBy(_ id: Int) {
        let urlString = "https://townnews.site/getarticle/\(String(id))/\(String(UIDevice.current.identifierForVendor!.uuidString))"
        let apiService = APIService(urlString: urlString)
        apiService.getJSON { (result: Result<Article, APIError>) in
            switch result {
            case .success(let article):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {
                        return
                    }
                    self.articles = [Article]()
                    self.articles.append(article)
                    self.activeArticle = id
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                        self.isDeeplinking = false
                    }
                }
            case .failure(let error):
                print(error)
                self.isDeeplinking = false
            }
        }
    }
    
    func fetchArticles() {
        var urlString = "https://townnews.site/articleslist/" + String(UIDevice.current.identifierForVendor!.uuidString)
        if currentTag > 1 {
            urlString = "https://townnews.site/articleslist/" + String(currentTag-1) + "/" + String(UIDevice.current.identifierForVendor!.uuidString)
        }
        let apiService = APIService(urlString: urlString)
        apiService.getJSON { (result: Result<[Article], APIError>) in
            switch result {
            case .success(let articles):
                DispatchQueue.main.async { [weak self] in
                    self?.articles = articles
                    self?.status = .success
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func fetchFavorite() {
        let apiService = APIService(urlString: "https://townnews.site/favoriteslist/" + String(UIDevice.current.identifierForVendor!.uuidString))
        apiService.getJSON { (result: Result<[Article], APIError>) in
            switch result {
            case .success(let articles):
                DispatchQueue.main.async { [weak self] in
                    self?.articles = articles
                    self?.status = .success
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func toggleFavorite(for article: Article) {
        if let index = articles.firstIndex(where: {$0.id == article.id}) {
            let api = SharedViewModel()
            api.sendArticleIdForFavorite(article.id)
            articles[index].isFavorite.toggle()
        }
    }
    
    func urlTo(_ article: Article) -> URL? {
        URL(string: "https://townnews.site/article/\(article.id)")
    }
}
