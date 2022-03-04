//
//  TagsViewModel.swift
//  TownNews
//
//  Created by maksim on 19.01.2022.
//

import Foundation
import SwiftUI
class TagsListViewModel: ObservableObject{
    @Published var tags: [Tag] = []
    
    func fetchTags() {
        let apiService = APIService(urlString: "https://townnews.site/tagslist")
        apiService.getJSON {(result: Result<[Tag], APIError>) in
            switch result {
            case .success(let tags):
                DispatchQueue.main.async {
                    self.tags = [Tag(id: 1, title: "Все новости", important: false)]
                    self.tags.append(contentsOf: tags)
                    //self.tags = tags
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func getTags() -> [Tag]{
        fetchTags()
        var res = [Tag(id: 1, title: "Все новости", important: false)]
        res.append(contentsOf: self.tags)
        return res
    }
}
