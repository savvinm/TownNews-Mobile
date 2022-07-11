//
//  Interactor.swift
//  TownNews
//
//  Created by Maksim Savvin on 11.07.2022.
//

import Combine
import SwiftUI

final class Interactor {
    enum ArticlesListOption {
        case all
        case forTag(filterTag: Int)
        case favorites
    }
    enum MissingsListOption {
        case all
        case createdByUser
    }
    
    private let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    private let apiService = APIService()
    
    private func defaultPublisher<T: Decodable>(endpoint: APIService.Endpoint) -> AnyPublisher<T, Error> {
        return apiService.getData(endpoint: endpoint)
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
    
    func fetchArticles(option: ArticlesListOption) -> AnyPublisher<[Article], Error> {
        let endpoint: APIService.Endpoint
        switch option {
        case .all:
            endpoint = .articlesList(uuid: uuid)
        case .forTag(let filterTag):
            endpoint = .articlesListWithFilter(uuid: uuid, filterTag: filterTag)
        case .favorites:
            endpoint = .favorites(uuid: uuid)
        }
        return defaultPublisher(endpoint: endpoint)
    }
    
    func fetchMissings(option: MissingsListOption) -> AnyPublisher<[Missing], Error> {
        let endpoint: APIService.Endpoint
        switch option {
        case .all:
            endpoint = .missingsList
        case .createdByUser:
            endpoint = .userMissingList(uuid: uuid)
        }
        return defaultPublisher(endpoint: endpoint)
    }
    
    func fetchPromos() -> AnyPublisher<[Promo], Error> {
        defaultPublisher(endpoint: .promosList)
    }
    
    func fetchTags() -> AnyPublisher<[Tag], Error> {
        defaultPublisher(endpoint: .tagsList)
    }
    
    func toggleArticleFavorite(_ article: Article) {
        
    }
    
    func delete(_ missing: Missing) {
        
    }
}
