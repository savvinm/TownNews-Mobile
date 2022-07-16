//
//  MissingsListView.swift
//  TownNews
//
//  Created by maksim on 16.01.2022.
//

import SwiftUI

struct MissingsListView: View {
    @ObservedObject var missingsViewModel: MissingsViewModel
    var body: some View {
        NavigationView {
            VStack {
                switch missingsViewModel.status {
                case .loading:
                    ProgressView()
                case .success:
                    successBlock
                case .error(let error):
                    Text(error.localizedDescription)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Объявления о пропаже")
            .navigationBarItems(trailing: addButton)
            .onAppear { missingsViewModel.fetchMissings(isForAuthor: false) }
        }
    }
    
    private var successBlock: some View {
        VStack {
            if !missingsViewModel.missings.isEmpty {
                missingsScrollView
            } else {
                emptyMessage
            }
        }
    }
    
    private var emptyMessage: some View {
        InfoMultilineText(value: "На данный момент нет активных объявлений о пропаже людей")
    }
    
    private var missingsScrollView: some View {
        List {
            ForEach(missingsViewModel.missings) { missing in
                MissingPreview(missing: missing, missingsViewModel: missingsViewModel)
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .refreshable {
            missingsViewModel.fetchMissings(isForAuthor: false)
        }
    }
    
    private var addButton: some View {
        Button(action: {}, label: {
            NavigationLink(destination: AddMissingView()) {
                Image(systemName: "plus.circle.fill")
            }
        })
    }
}

struct FindPeopleView_Previews: PreviewProvider {
    static var previews: some View {
        let missingsViewModel = MissingsViewModel()
        MissingsListView(missingsViewModel: missingsViewModel)
    }
}
