//
//  MissingsListViewModel.swift
//  TownNews
//
//  Created by maksim on 18.01.2022.
//

import Combine
import Foundation

class MissingsViewModel: ViewModelWithStatus, ObservableObject {
    
    @Published private(set) var missings = [Missing]()
    private var cancellable: AnyCancellable?
    private let interactor = Interactor()
    @Published private(set) var status = ViewModelStatus.success
    
    func fetchMissings(isForAuthor: Bool) {
        cancellable = interactor.fetchMissings(option: isForAuthor ? .createdByUser : .all)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completiton in
                guard case let .failure(error) = completiton else {
                    return
                }
                print(error)
                self?.status = .error(error)
            }, receiveValue: { [weak self] missings in
                self?.status = .success
                self?.missings = missings
            })
    }
    
    func delete(_ missing: Missing) {
        interactor.delete(missing)
    }
}
