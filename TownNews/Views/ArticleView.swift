//
//  ArticleView.swift
//  TownNews
//
//  Created by maksim on 17.01.2022.
//

import SwiftUI

struct ArticleView: View {
    let article: Article
    @State var isFavorite: Bool
    var body: some View {
        ScrollView{
            VStack{
                Text(article.title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                AsyncImage(url: SharedViewModel.getFullURLToImage(url: article.imageUrl)){ image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.95)
                } placeholder: {
                        ProgressView().frame(width: 100, height: 100)
                    
                }
                Text(article.content)
                    .padding(.bottom)
                    .font(.callout)
                HStack{
                    Text(article.creationTime).font(.caption)
                    Spacer()
                    Text("#" + article.tag).font(.caption)
                }
            }
            .padding([.leading, .trailing, .bottom])
        }
        .navigationBarItems(trailing: Button(action: {
            isFavorite.toggle()
            let api = SharedViewModel()
            api.sendArticleIdForFavorite(article.id)
        }, label: {
            if(isFavorite){
                Image(systemName: "bookmark.fill")
            }
            else{
                Image(systemName: "bookmark")
            }
        }))
    }
}

