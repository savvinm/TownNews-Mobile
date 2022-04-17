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
                HStack{
                    Text(article.title)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    //Spacer()
                }
                articleImage
                HStack{
                    Text("Фото: " + article.photoAuthor)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                //.padding(.top, -3)
                .padding(.horizontal, 10)
                articleBody
                    .padding(.horizontal, 10)
                    .padding(.top, 1)
            }
            .padding(.bottom)
        }
        .navigationBarItems(trailing: navigationButtons)
    }
    
    private var navigationButtons: some View{
        HStack{
            shareButton
            favoriteButton
        }
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
                .font(.system(size: 15, weight: .regular, design: .default))
                .padding(.bottom, 3)
            //.foregroundColor(Color(.systemGray))
            HStack{
                Text(article.creationTime)
                Spacer()
                Text("#" + article.tag)
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
    }
    
    private var articleImage: some View{
        AsyncImage(url: SharedViewModel.getFullURLToImage(url: article.imageUrl)){ image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.3)
                .clipped()
        } placeholder: {
            ProgressView().frame(width: 100, height: 100)
        }
        
    }
    
    private var shareButton: some View{
        Button(action: {
            guard let url = avm.urlTo(article) else {
                return
            }
            let shareSheet = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            UIApplication.shared.windows.first?.rootViewController?.present(shareSheet, animated: true, completion: nil)
        }, label: {
            Image(systemName: "square.and.arrow.up")
        })
    }
}

