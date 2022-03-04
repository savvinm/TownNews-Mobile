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
            Text(article.title).font(.headline).multilineTextAlignment(.center)
            let url = URL(string: "https://townnews.site/getimage/" + article.imageUrl)
            AsyncImage(url: url){ image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.height/2)
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
        .navigationBarItems(trailing: Button(action: {
            isFavorite.toggle()
            let url = URL(string: "https://townnews.site/addfavorite/" + String(article.id) + "/" + String(UIDevice.current.identifierForVendor!.uuidString))
            let task = URLSession.shared.dataTask(with: url!)
            task.resume()
        }, label: {
            if(isFavorite){
                Image(systemName: "bookmark.fill")
            }
            else{
                Image(systemName: "bookmark")
            }
        }))        //.padding(.top, -20)
        .padding([.leading, .bottom, .trailing])
    }
}

