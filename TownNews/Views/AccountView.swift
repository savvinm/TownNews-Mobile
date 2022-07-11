//
//  AccountView.swift
//  TownNews
//
//  Created by maksim on 26.01.2022.
//

import SwiftUI

struct AccountView: View {
    let articlesViewModel = ArticlesViewModel()
    let missingsViewModel = MissingsViewModel()
    var body: some View {
        NavigationView {
            Form {
                accountIntents
                accountPages
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Аккаунт")
        }
    }
    
    private var accountPages: some View {
        Section(header: Text("Мое")) {
            NavigationLink {
                FavoritesView(articlesViewModel: articlesViewModel)
            } label: {
                Text("Избранное")
            }
            NavigationLink {
                CreatorMissingsView(missingsViewModel: missingsViewModel)
            } label: {
                Text("Мои объявления")
            }
            Link("Пользовательское соглашение", destination: URL(string: "https://www.example.com/TOS.html")!)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var accountIntents: some View {
        Section(header: Text("")) {
            NavigationLink {
                AdMissingView()
            } label: {
                Text("Создать объявление о пропаже")
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
