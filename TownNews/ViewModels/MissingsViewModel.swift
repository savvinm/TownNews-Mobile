//
//  MissingsListViewModel.swift
//  TownNews
//
//  Created by maksim on 18.01.2022.
//

import Combine
import Foundation

class MissingsViewModel: ObservableObject {
    
    @Published private(set) var missings = [Missing]()
    private var cancellable: AnyCancellable?
    private let interactor = Interactor()
    
    func fetchMissings() {
        cancellable = interactor.fetchMissings(option: .all)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completiton in
                guard case let .failure(error) = completiton else {
                    return
                }
                print(error)
            }, receiveValue: { [weak self] missings in
                self?.missings = missings
            })
    }
    
    func fetchUserMissings() {
        cancellable = interactor.fetchMissings(option: .createdByUser)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completiton in
                guard case let .failure(error) = completiton else {
                    return
                }
                print(error)
            }, receiveValue: { [weak self] missings in
                self?.missings = missings
            })
    }
    
    func delete(_ missing: Missing) {
        interactor.delete(missing)
    }
}
