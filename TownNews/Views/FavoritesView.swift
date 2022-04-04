//
//  FavoritesView.swift
//  TownNews
//
//  Created by maksim on 26.01.2022.
//

import SwiftUI
struct FavoritesView: View {
    @ObservedObject var avm: ArticleViewModel
    var body: some View {
        VStack{
            if(avm.articles.isEmpty){
                emptyMessage
            } else{
                favoriteScrollView
            }
        }
        .navigationTitle("Избранное")
        .onAppear(){ avm.fetchFavorite() }
    }
    
    
    private var favoriteScrollView: some View{
        List{
            articlesForEach
        }
        .refreshable{
            avm.fetchFavorite()
        }
    }
    
    private var articlesForEach: some View{
        ForEach(avm.articles){ article in
            ZStack{
                NavigationLink(tag: article.id, selection: $avm.activeArticle){
                    ArticleView(article: article, avm: avm)
                } label: {
                    EmptyView()
                }
                ArticlePreview(article: article)
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            .listRowSeparator(.hidden)
        }
    }
    
    private var emptyMessage: some View{
        VStack{
            Spacer()
            Text("Вы еще не добавили ничего в избранное.").multilineTextAlignment(.center)
            Text("Добавьте понравившиеся вам статьи, чтобы вернуться к ним позже.").multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
        .foregroundColor(.secondary)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        let avm = ArticleViewModel()
        FavoritesView(avm: avm)
    }
}
