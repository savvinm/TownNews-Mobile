//
//  ArticlesListViewModel.swift
//  TownNews
//
//  Created by maksim on 17.01.2022.
//

import Combine
import Foundation

class ArticleViewModel: ObservableObject {
    
    private let interactor = Interactor()
    private var cancellable: AnyCancellable?
    
    @Published private(set) var articles = [Article]()
    private(set) var currentTag = 1
    private(set) var isDeeplinking = false
    @Published private(set) var activeArticle: Int?
    
    func change(id: Int){
        let isLoad = getOnlyOne(id: id)
        if isLoad{
            activeArticle = id
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){ [weak self] in
                self?.isDeeplinking = false
            }
        } else{
            //fetchArticleBy(id)
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
    
    /*func fetchArticleBy(_ id: Int){
        let urlString = "https://townnews.site/getarticle/\(String(id))/\(String(UIDevice.current.identifierForVendor!.uuidString))"
        let apiService = APIService(urlString: urlString)
        apiService.getJSON {(result: Result<Article, APIError>) in
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
    }*/
    
    func fetchArticles() {
        let option: Interactor.ArticlesListOption = currentTag > 1 ? .forTag(filterTag: currentTag) : .all
        cancellable = interactor.fetchArticles(option: option)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completiton in
                guard case let .failure(error) = completiton else {
                    return
                }
                print(error)
            }, receiveValue: { [weak self] articles in
                self?.articles = articles
            })
    }
    
    func fetchFavorite() {
        cancellable = interactor.fetchArticles(option: .favorites)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completiton in
                guard case let .failure(error) = completiton else {
                    return
                }
                print(error)
            }, receiveValue: { [weak self] articles in
                self?.articles = articles
            })
    }
    
    func toggleFavorite(for article: Article){
        if let index = articles.firstIndex(where: { $0.id == article.id }) {
            interactor.toggleArticleFavorite(article)
            articles[index].isFavorite.toggle()
        }
    }
    
    func urlTo(_ article: Article) -> URL?{
        URL(string: "https://townnews.site/article/\(article.id)")
    }
}
