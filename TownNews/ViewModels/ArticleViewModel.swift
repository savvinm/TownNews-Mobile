//
//  ArticlesListViewModel.swift
//  TownNews
//
//  Created by maksim on 17.01.2022.
//

import Foundation
import UIKit
class ArticleViewModel: ObservableObject{
    
    @Published private(set) var articles: [Article] = []
    var currentTag = 1
    var isDeeplinking = false
    @Published var activeArticle: Int?
    
    func change(id: Int){
        let isLoad = getOnlyOne(id: id)
        if isLoad{
            activeArticle = id
            //fetchArticles(isRefresh: false)
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                self.isDeeplinking = false
            }
        } else{
            fetchArticleBy(id)
        }
    }

    func getOnlyOne(id: Int) -> Bool{
        if let index = articles.firstIndex(where: { $0.id == id }){
            var newList = [Article]()
            newList.append(articles[index])
            articles = newList
            return true
        }
        return false
    }
    
    func fetchArticleBy(_ id: Int){
        let urlString = "https://townnews.site/article/\(String(id))/\(String(UIDevice.current.identifierForVendor!.uuidString))"
        let apiService = APIService(urlString: urlString)
        apiService.getJSON {(result: Result<Article, APIError>) in
            switch result {
            case .success(let article):
                DispatchQueue.main.async {
                    self.articles = [Article]()
                    self.articles.append(article)
                    self.activeArticle = id
                    //self.isDeeplinking = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
                        self.isDeeplinking = false
                    }
                    //self.fetchArticles(isRefresh: false)
                }
            case .failure(let error):
                print(error)
                self.isDeeplinking = false
            }
        }
    }
    
    func fetchArticles() {
        var urlString = "https://townnews.site/articleslist/" + String(UIDevice.current.identifierForVendor!.uuidString)
        if(currentTag > 1){
            urlString = "https://townnews.site/articleslist/" + String(currentTag-1) + "/" + String(UIDevice.current.identifierForVendor!.uuidString)
        }
        let apiService = APIService(urlString: urlString)
        apiService.getJSON {(result: Result<[Article], APIError>) in
            switch result {
            case .success(let articles):
                DispatchQueue.main.async {
                    /*let isChanged = !(articles == self.articles)
                    if isChanged{
                        self.articles = articles
                        if isRefresh{
                            self.objectWillChange.send()
                        }
                    }*/
                    self.articles = articles
                }
            case .failure(let error):
                print(error)
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
    
    func toggleFavorite(for article: Article){
        if let index = articles.firstIndex(where: {$0.id == article.id}){
            let api = SharedViewModel()
            api.sendArticleIdForFavorite(article.id)
            articles[index].isFavorite.toggle()
        }
    }
}
