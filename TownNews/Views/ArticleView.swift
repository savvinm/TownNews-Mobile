//
//  ArticleView.swift
//  TownNews
//
//  Created by maksim on 17.01.2022.
//

import SwiftUI

struct ArticleView: View {
    let article: Article
    let avm: ArticleViewModel
    var body: some View {
        ScrollView{
            VStack{
                Text(article.title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                articleImage
                articleBody
            }
            .padding([.leading, .trailing, .bottom])
        }
        .navigationBarItems(trailing: favoriteButton)
    }
    
    private var favoriteButton: some View{
        Button(action: {
            avm.toggleFavorite(for: article)
        }, label: {
            if(article.isFavorite){
                Image(systemName: "bookmark.fill")
            }
            else{
                Image(systemName: "bookmark")
            }
        })
    }
    
    private var articleBody: some View{
        VStack{
            Text(article.content)
                .padding(.bottom)
                .font(.callout)
            HStack{
                Text(article.creationTime).font(.caption)
                Spacer()
                Text("#" + article.tag).font(.caption)
            }
        }
    }
    
    private var articleImage: some View{
        AsyncImage(url: SharedViewModel.getFullURLToImage(url: article.imageUrl)){ image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.95)
        } placeholder: {
                ProgressView().frame(width: 100, height: 100)
            
        }
    }
}

