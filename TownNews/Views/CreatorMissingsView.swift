//
//  UserMissingView.swift
//  TownNews
//
//  Created by maksim on 26.01.2022.
//

import SwiftUI

struct CreatorMissingsView: View {
    @ObservedObject var missingsViewModel: MissingsViewModel
    var body: some View {
        VStack {
            if missingsViewModel.missings.isEmpty {
                emptyMessage
            } else {
                missingsScrollView
            }
        }
        .navigationTitle("Мои объявления")
        .onAppear { missingsViewModel.fetchUserMissings() }
    }
    
    private var missingsScrollView: some View {
        List {
            ForEach(missingsViewModel.missings) { missing in
                MissingPreview(missing: missing, missingsViewModel: missingsViewModel, isCreator: true)
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .refreshable {
            missingsViewModel.fetchUserMissings()
        }
    }
    
    private var emptyMessage: some View {
        InfoMultilineText(value: "Не найдено созданных вами объявлений")
    }
}
