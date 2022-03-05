//
//  ArticlePreview.swift
//  TownNews
//
//  Created by Maksim Savvin on 05.03.2022.
//

import SwiftUI

struct ArticlePreview: View{
    let article: Article
    var body: some View{
        NavigationLink{
            ArticleView(article: article, isFavorite: article.isFavorite)
        } label: {
            VStack{
                AsyncImage(url: SharedViewModel.getFullURLToImage(url: article.imageUrl)){ image in
                    image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    //.scaledToFill()
                    .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.3)
                    .clipped()
                    .cornerRadius(10)
                }
                placeholder: {
                    ProgressView()
                }
                .frame(width: UIScreen.main.bounds.width - 150, height: UIScreen.main.bounds.height * 0.3)
                Spacer()
                Text(article.title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 3)
                Spacer()
                HStack{
                    Spacer()
                    Text("#" + article.tag).font(.footnote
                    )
                        .padding(.trailing, 5)
                        .padding(.bottom, 2)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.45)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .buttonStyle(PlainButtonStyle())
    }
}

