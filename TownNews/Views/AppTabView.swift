//
//  ContentView.swift
//  TownNews
//
//  Created by maksim on 16.01.2022.
//

import SwiftUI

struct AppTabView: View {
    @State var activeTab = TabIdentifier.news
    let articleId: Int?
    let articlesViewModel = ArticlesViewModel()
    let promosViewModel = PromosViewModel()
    let missingsViewModel = MissingsViewModel()
    let tagsViewModel = TagsViewModel()
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
        .onOpenURL { url in
            if articleId == nil {
                onURL(url: url)
            }
        }
    }
    
    
    private func onURL(url: URL) {
        guard let tab = url.tabIdentifier else {
            return
        }
        if tab == .news {
            if case .article(_) = url.detailPage {
                articlesViewModel.isDeeplinking = true
            }
        }
        activeTab = tab
    }
    
    
    private var missingTab: some View {
        MissingsListView(missingsViewModel: missingsViewModel).tabItem() {
            tabLabel(text: "Объявления", imageName: "person.fill.questionmark")
        }
    }
    
    private var accountTab: some View{
        AccountView().tabItem() {
            tabLabel(text: "Аккаунт", imageName: "list.bullet")
        }
    }
    
    private var promoTab: some View {
        PromoView(promosViewModel: promosViewModel).tabItem() {
            tabLabel(text: "Промокоды", imageName: "giftcard.fill")
        }
    }
    
    private var newsTab: some View {
        NewsPageView(articleId: articleId, articlesViewModel: articlesViewModel, tagsViewModel: tagsViewModel).tabItem() {
            tabLabel(text: "Новости", imageName: "house.fill")
        }
    }
    
    private func tabLabel(text: String, imageName: String) -> some View {
        VStack {
            Image(systemName: imageName)
            Text(text)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView(articleId: nil)
    }
}
