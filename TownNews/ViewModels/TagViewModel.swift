//
//  TagsViewModel.swift
//  TownNews
//
//  Created by maksim on 19.01.2022.
//

import Combine
import Foundation

class TagViewModel: ObservableObject {
    
    @Published private(set) var tags = [Tag]()
    private var cancellable: AnyCancellable?
    private let interactor = Interactor()
    
    func fetchTags() {
        cancellable = interactor.fetchTags()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completiton in
                guard case let .failure(error) = completiton else {
                    return
                }
                print(error)
            }, receiveValue: { [weak self] tags in
                self?.tags = tags
            })
    }
}
