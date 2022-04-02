//
//  ContentView.swift
//  TownNews
//
//  Created by maksim on 15.01.2022.
//

import SwiftUI
import AVFoundation

struct NewsPageView: View {
    
    @ObservedObject var avm: ArticleViewModel
    @ObservedObject var tvm: TagViewModel
    var body: some View {
        NavigationView{
            List{
                MenuPicker(selection: avm.currentTag, tags: tvm.tags, avm: avm)
                    .listRowBackground(Color.clear)
                ForEach(avm.articles){ article in
                    ZStack{
                        NavigationLink(tag: article.id, selection: $avm.activeArticle){
                            ArticleView(article: article, avm: avm)
                        } label: {
                            EmptyView()
                        }
                        if let selection = avm.activeArticle{
                            if selection == article.id{
                                
                            }
                        } else {
                            ArticlePreview(article: article)
                        }
                    }
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
            }
            .refreshable {
                avm.fetchArticles(isRefresh: true)
                tvm.fetchTags()
            }
            .onOpenURL{ url in
                    if case .article(let id) = url.detailPage {
                        avm.change(id: id)
                    }
            }
            .onAppear(){
                tvm.fetchTags()
                if !avm.isDeeplinking{
                    avm.fetchArticles(isRefresh: true)
                }
            }
            .navigationTitle("Новости")
        }
    }
}

private struct MenuPicker: View{
    @State var selection: Int
    let tags: Array<Tag>
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
            ForEach(tags) { tag in
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
            if $0 > 0 && $0 <= tags.count{
                avm.currentTag = $0
                avm.fetchArticles(isRefresh: true)
            }
        }
        .pickerStyle(InlinePickerStyle())
    }
    
    private var pickerLabel: some View{
        HStack {
            if(tags.count > 0){
                Text(tags[selection-1].title)
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
        NewsPageView(avm: avm, tvm: tvm)
    }
}
