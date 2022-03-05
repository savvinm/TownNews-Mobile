//
//  ContentView.swift
//  TownNews
//
//  Created by maksim on 16.01.2022.
//

import SwiftUI

struct AppTabView: View {
    let avm = ArticlesListViewModel()
    let pvm = PromosListViewModel()
    let mvm = MissingsListViewModel()
    let tvm = TagsListViewModel()
    var body: some View {
        TabView {
            NewsPageView(avm: avm, tvm: tvm).tabItem(){
                VStack{
                    Image(systemName: "house.fill")
                    Text("Новости")
                }
            }
            FindPeopleView(mvm:mvm).tabItem(){
                VStack{
                    Image(systemName: "person.fill.questionmark")
                    Text("Объявления")
                }
            }
            PromoView(pvm:pvm).tabItem(){
                VStack{
                    Image(systemName: "giftcard.fill")
                    Text("Промокоды")
                }
            }
            AccountView().tabItem(){
                VStack{
                    Image(systemName: "list.bullet")
                    Text("Аккаунт")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
