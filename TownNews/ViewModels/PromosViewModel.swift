//
//  PromosViewModel.swift
//  TownNews
//
//  Created by maksim on 18.01.2022.
//

import Combine
import Foundation

class PromosViewModel: ViewModelWithStatus, ObservableObject {
    
    @Published private(set) var promos = [Promo]()
    private var cancellable: AnyCancellable?
    private let interactor = Interactor()
    @Published private(set) var status = ViewModelStatus.loading
    
    func fetchPromos() {
        cancellable = interactor.fetchPromos()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completiton in
                guard case let .failure(error) = completiton else {
                    return
                }
                print(error)
                self?.status = .error(error)
            }, receiveValue: { [weak self] promos in
                self?.promos = promos
                self?.status = .success
            })
    }
}
