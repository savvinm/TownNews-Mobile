//
//  AccountView.swift
//  TownNews
//
//  Created by maksim on 26.01.2022.
//

import SwiftUI

struct AccountView: View {
    let avm = ArticlesListViewModel()
    let mvm = MissingsListViewModel()
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("")){
                    NavigationLink{
                        AdMissingView()
                    } label: {
                        Text("Создать объявление о пропаже")
                    }
                }
                Section(header: Text("Мое")){
                    NavigationLink{
                        FavoritesView(avm: avm)
                    } label: {
                        Text("Избранное")
                    }
                    NavigationLink{
                        CreatorMissingsView(mvm: mvm)
                    } label: {
                        Text("Мои объявления")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Аккаунт")
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
