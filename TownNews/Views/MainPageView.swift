//
//  ContentView.swift
//  TownNews
//
//  Created by maksim on 15.01.2022.
//

import SwiftUI
import AVFoundation

struct MainPageView: View {
    @ObservedObject var avm: ArticlesListViewModel
    @ObservedObject var tvm: TagsListViewModel
    @State var selection: Int = 1
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    Menu {
                            Picker("Filter", selection: $selection) {
                                ForEach(tvm.tags) { tag in
                                    HStack {
                                        Text(tag.title)
                                        if(tag.important){
                                            Image(systemName: "exclamationmark.circle.fill")
                                        }
                                    }
                                    .tag(tag.id)
                                }
                            }
                            .onChange(of: selection, perform: { value in
                                if(value <= 1){
                                    avm.fetchArticles()
                                }
                                else{
                                    avm.fetchArticles(id: selection)
                                }
                            })
                            .pickerStyle(InlinePickerStyle())
                        } label: {
                            HStack {
                                if(tvm.tags.count > 0){
                                    Text(tvm.tags[selection-1].title)
                                }
                            }
                            .frame(width: UIScreen.main.bounds.width-150, height: 20)
                            .font(.headline)
                            .padding()
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                            .background(Color(.systemGray6))
                            .cornerRadius(20)
                        }
                }
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
                                    .multilineTextAlignment(.center)
                                Spacer()
                                HStack{
                                    Spacer()
                                    Text("#" + article.tag).font(.footnote
                                    )
                                        .padding(.bottom, -5)
                                }
                            }
                        }
                        .padding().frame(width: UIScreen.main.bounds.width - 30, height: 310).background(Color(.systemGray6))
                        .cornerRadius(10)
                        .buttonStyle(PlainButtonStyle())
                        .padding([.top, .leading, .trailing])
                    }
                }
            }
            .onAppear() {
                tvm.fetchTags()
                if(selection <= 1){
                    avm.fetchArticles()
                }
                else{
                    avm.fetchArticles(id: selection)
                }
            }
            .navigationTitle("Новости")
        }
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        let avm = ArticlesListViewModel()
        let tvm = TagsListViewModel()
        MainPageView(avm: avm, tvm: tvm)
            .previewDevice("iPhone 11")
.previewInterfaceOrientation(.portrait)
    }
}
