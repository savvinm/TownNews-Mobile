//
//  ContentView.swift
//  TownNews
//
//  Created by maksim on 16.01.2022.
//

import SwiftUI

struct AppTabView: View {
    @State var activeTab = TabIdentifier.news
    let avm = ArticleViewModel()
    let pvm = PromoViewModel()
    let mvm = MissingViewModel()
    let tvm = TagViewModel()
    var body: some View {
        TabView(selection: $activeTab) {
            newsTab
                .tag(TabIdentifier.news)
            missingTab
                .tag(TabIdentifier.find)
            promoTab
                .tag(TabIdentifier.promo)
            accountTab
                .tag(TabIdentifier.account)
        }
        .onOpenURL{ url in
            guard let tab = url.tabIdentifier else { return }
            if tab == .news{
                if case .article(_) = url.detailPage{
                    avm.isDeeplinking = true
                }
            }
            activeTab = tab
        }
    }
    
    private var missingTab: some View{
        MissingsListView(mvm:mvm).tabItem(){
            VStack{
                Image(systemName: "person.fill.questionmark")
                Text("Объявления")
            }
        }
    }
    
    private var accountTab: some View{
        AccountView().tabItem(){
            VStack{
                Image(systemName: "list.bullet")
                Text("Аккаунт")
            }
        }
    }
    
    private var promoTab: some View{
        PromoView(pvm:pvm).tabItem(){
            VStack{
                Image(systemName: "giftcard.fill")
                Text("Промокоды")
            }
        }
    }
    
    private var newsTab: some View{
        NewsPageView(avm: avm, tvm: tvm).tabItem(){
            VStack{
                Image(systemName: "house.fill")
                Text("Новости")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView(activeTab: TabIdentifier.news)
    }
}
