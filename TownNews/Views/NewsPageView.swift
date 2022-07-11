//
//  ContentView.swift
//  TownNews
//
//  Created by maksim on 15.01.2022.
//

import SwiftUI

struct NewsPageView: View {
    @State var articleId: Int?
    @ObservedObject var articlesViewModel: ArticlesViewModel
    @ObservedObject var tagsViewModel: TagsViewModel
    var body: some View {
        NavigationView {
            List {
                MenuPicker(tagsViewModel: tagsViewModel, articlesViewModel: articlesViewModel)
                    .listRowBackground(Color.clear)
                articlesForEach
            }
            .navigationTitle("Новости")
            .refreshable {
                tagsViewModel.fetchTags()
                articlesViewModel.fetchArticles()
            }
            .onOpenURL { url in
                if case .article(let id) = url.detailPage {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: { articlesViewModel.change(id: id) })
                }
            }
            .onAppear {
                tagsViewModel.fetchTags()
                if let id = articleId {
                    articleId = nil
                    articlesViewModel.change(id: id)
                } else {
                    if !articlesViewModel.isDeeplinking {
                        articlesViewModel.fetchArticles()
                    }
                }
            }
        }
    }
    
    private var articlesForEach: some View {
        ForEach(articlesViewModel.articles) { article in
            ZStack {
                NavigationLink(tag: article.id, selection: $articlesViewModel.activeArticle, destination: {
                    ArticleView(article: article, articlesViewModel: articlesViewModel)
                }, label: {
                    EmptyView()
                })
                if !articlesViewModel.isDeeplinking {
                    ArticlePreview(article: article)
                }
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            .listRowSeparator(.hidden)
        }
    }
}


struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        let articlesViewModel = ArticlesViewModel()
        let tagsViewModel = TagsViewModel()
        NewsPageView(articleId: nil, articlesViewModel: articlesViewModel, tagsViewModel: tagsViewModel)
    }
}
