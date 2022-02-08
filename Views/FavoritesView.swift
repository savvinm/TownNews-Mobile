//
//  FavoritesView.swift
//  TownNews
//
//  Created by maksim on 26.01.2022.
//

import SwiftUI
struct FavoritesView: View {
    @StateObject var avm = ArticlesListViewModel()
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
                    ForEach(avm.articles){ article in
                        NavigationLink{
                            ArticleView(article: article, isFavorite: article.isFavorite)
                        } label: {
                            VStack{
                                let url = URL(string: "https://townnews.site/getimage/" + article.imageUrl)
                                AsyncImage(url: url){ image in
                                    image.resizable()
                                        .scaledToFill()
                                        .cornerRadius(10)
                                        .frame(width: UIScreen.main.bounds.width - 30, height: 200)
                                        .clipped()
                                        .padding(.top, -10.0)
                                } placeholder: {
                                    ProgressView()
                                }.frame(width: UIScreen.main.bounds.width - 150, height: 180)
                                Spacer()
                                Text(article.title)
                                    .font(.headline)
                                    //.foregroundColor(.black)
                                    .multilineTextAlignment(.center)
                                Spacer()
                                HStack{
                                    Spacer()
                                    Text("#" + article.tag).font(.footnote
                                    )
                                        //.foregroundColor(.black)
                                        .padding(.bottom, -5)
                                }
                            }.padding().frame(width: UIScreen.main.bounds.width - 30, height: 310).background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding([.top, .leading, .trailing])
                    }
                }
            }
            .onAppear() {
                avm.fetchFavorite()
            }
        }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
