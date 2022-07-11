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
                if !missingsViewModel.missings.isEmpty {
                    missingsScrollView
                } else {
                    emptyMessage
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Объявления о пропаже")
            .navigationBarItems(trailing: addButton)
            .onAppear { missingsViewModel.fetchMissings() }
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
            missingsViewModel.fetchMissings()
        }
    }
    
    private var addButton: some View {
        Button(action: {}, label: {
            NavigationLink(destination: AdMissingView()) {
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
