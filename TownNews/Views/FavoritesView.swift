//
//  FavoritesView.swift
//  TownNews
//
//  Created by maksim on 26.01.2022.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var articlesViewModel: ArticlesViewModel
    var body: some View {
        VStack {
            switch articlesViewModel.status {
            case .loading:
                ProgressView()
            case .success:
                successBlock
            case .error(let error):
                Text(error.localizedDescription)
            }
        }
        .navigationTitle("Избранное")
        .onAppear { articlesViewModel.fetchFavorite() }
    }
    
    private var successBlock: some View {
        VStack {
            if articlesViewModel.articles.isEmpty {
                emptyMessage
            } else {
                favoriteScrollView
            }
        }
    }
    
    private var favoriteScrollView: some View {
        List {
            ForEach(articlesViewModel.articles) { article in
                link(for: article)
            }
        }
        .refreshable { articlesViewModel.fetchFavorite() }
    }
    
    private func link(for article: Article) -> some View {
        ZStack {
            NavigationLink(destination: ArticleView(article: article, articlesViewModel: articlesViewModel), label: { EmptyView() })
            ArticlePreview(article: article)
        }
        .frame(height: UIScreen.main.bounds.width * 0.8)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        .listRowSeparator(.hidden)
    }
    
    private var emptyMessage: some View {
        InfoMultilineText(value: "Вы еще не добавили ничего в избранное.\nДобавьте понравившиеся вам статьи, чтобы вернуться к ним позже.")
    }
}
