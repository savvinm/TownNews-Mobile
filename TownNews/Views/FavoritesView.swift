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
        if(avm.articles.isEmpty){
            emptyMessage
        }
        favoriteScrollView
    }
    
    
    private var favoriteScrollView: some View{
        ScrollView{
            LazyVStack{
                ForEach(avm.articles){ArticlePreview(article: $0, avm: avm)}
                    .padding(.top, 20)
                    .padding(.horizontal)
                }
            }
        .onAppear(){ avm.fetchFavorite() }
        .navigationTitle("Избранное")
    }
    
    private var emptyMessage: some View{
        VStack{
            Spacer()
            Text("Вы еще не добавили ничего в избранное.").multilineTextAlignment(.center)
            Text("Добавьте понравившиеся вам статьи, чтобы вернуться к ним позже.").multilineTextAlignment(.center)
            Spacer()
        }
        .foregroundColor(.secondary)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        let avm = ArticleViewModel()
        FavoritesView(avm: avm)
    }
}
