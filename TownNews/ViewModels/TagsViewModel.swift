//
//  TagsViewModel.swift
//  TownNews
//
//  Created by maksim on 19.01.2022.
//

import Foundation

class TagsViewModel: ObservableObject{
    
    @Published private(set) var tags: [Tag] = []
    
    func fetchTags() {
        let apiService = APIService(urlString: "https://townnews.site/tagslist")
        apiService.getJSON { (result: Result<[Tag], APIError>) in
            switch result {
            case .success(let tags):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {
                        return
                    }
                    self.tags = [Tag(id: 1, title: "Все новости", important: false)]
                    self.tags.append(contentsOf: tags)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
