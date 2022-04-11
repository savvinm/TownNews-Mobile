//
//  ContentView.swift
//  TownNews
//
//  Created by maksim on 15.01.2022.
//

import SwiftUI
import AVFoundation

struct NewsPageView: View {
    @State var articleId: Int?
    @ObservedObject var avm: ArticleViewModel
    @ObservedObject var tvm: TagViewModel
    var body: some View {
        NavigationView{
            List{
                MenuPicker(selection: avm.currentTag, tvm: tvm, avm: avm)
                    .listRowBackground(Color.clear)
                articlesForEach
            }
            .refreshable{
                tvm.fetchTags()
                avm.fetchArticles()
            }
            .onOpenURL{ url in
                if case .article(let id) = url.detailPage {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: { avm.change(id: id) })
                }
            }
            .onAppear(){
                tvm.fetchTags()
                if let id = articleId{
                    articleId = nil
                    avm.change(id: id)
                } else {
                    if !avm.isDeeplinking{
                        avm.fetchArticles()
                    }
                }
            }
            .navigationTitle("Новости")
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
                if !avm.isDeeplinking{
                    ArticlePreview(article: article)
                }
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            .listRowSeparator(.hidden)
        }
    }
}

private struct MenuPicker: View{
    @State var selection: Int
    @ObservedObject var tvm: TagViewModel
    let avm: ArticleViewModel
    var body: some View{
        VStack{
            Menu{
                pickerBody
            } label: {
                pickerLabel
            }
        }
    }
    
    private var pickerBody: some View{
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
        .onChange(of: selection){
            if $0 > 0 && $0 <= tvm.tags.count{
                avm.currentTag = $0
                tvm.fetchTags()
                avm.fetchArticles()
            }
        }
        .pickerStyle(InlinePickerStyle())
    }
    
    private var pickerLabel: some View{
        HStack {
            if(tvm.tags.count > 0){
                Text(tvm.tags[selection-1].title)
            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.75, height: 20)
        .font(.headline)
        .padding()
        .foregroundColor(.primary)
        .background(Color(.systemGray5))
        .cornerRadius(15)
    }
}


struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        let avm = ArticleViewModel()
        let tvm = TagViewModel()
        NewsPageView(articleId: nil, avm: avm, tvm: tvm)
    }
}
