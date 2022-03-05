//
//  ContentView.swift
//  TownNews
//
//  Created by maksim on 15.01.2022.
//

import SwiftUI
import AVFoundation

struct NewsPageView: View {
    
    @ObservedObject var avm: ArticlesListViewModel
    @ObservedObject var tvm: TagsListViewModel
    
    var body: some View {
        NavigationView{
            ScrollView{
                MenuPicker(tags: tvm.tags, avm: avm)
                LazyVStack{
                    ForEach(avm.articles){ArticlePreview(article: $0)}
                    .padding(.top, 20)
                    .padding(.horizontal)
                }
            }
            .onAppear() {
                tvm.fetchTags()
            }
            .navigationTitle("Новости")
        }
    }
}





struct MenuPicker: View{
    @State var selection: Int = 1
    let tags: Array<Tag>
    let avm: ArticlesListViewModel
    var body: some View{
        VStack{
            Menu{
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
                .onChange(of: selection, perform: {avm.fetchArticles(tagId: $0)})
                .pickerStyle(InlinePickerStyle())
            } label: {
                HStack {
                    if(tags.count > 0){
                        Text(tags[selection-1].title)
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.75, height: 20)
                .font(.headline)
                .padding()
                .foregroundColor(.primary)
                .background(Color(.systemGray6))
                .cornerRadius(15)
            }
            .onAppear(){avm.fetchArticles(tagId: selection)}
        }
    }
}


struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        let avm = ArticlesListViewModel()
        let tvm = TagsListViewModel()
        NewsPageView(avm: avm, tvm: tvm)
    }
}