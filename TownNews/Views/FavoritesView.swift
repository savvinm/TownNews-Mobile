//
//  FavoritesView.swift
//  TownNews
//
//  Created by maksim on 26.01.2022.
//

import SwiftUI
struct FavoritesView: View {
    @ObservedObject var avm: ArticlesListViewModel
    var body: some View {
        if(avm.articles.count == 0){
            VStack{
                Spacer()
                Text("Вы еще не добавили ничего в избранное.").multilineTextAlignment(.center)
                Text("Добавьте понравившиеся вам статьи, чтобы вернуться к ним позже.").multilineTextAlignment(.center)
                Spacer()
            }
            .foregroundColor(.secondary)
        }
        ScrollView{
            LazyVStack{
                    ForEach(avm.articles){ArticlePreview(article: $0)}
                }
            }
        .onAppear(){ avm.fetchFavorite() }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        let avm = ArticlesListViewModel()
        FavoritesView(avm: avm)
    }
}
