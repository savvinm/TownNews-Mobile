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
            ScrollView{
                MenuPicker(tags: tvm.tags, avm: avm)
                LazyVStack{
                    ForEach(avm.articles){ ArticlePreview(article: $0, avm: avm) }
                    .padding(.top, 20)
                    .padding(.horizontal)
                }
            }
            .onAppear(){ tvm.fetchTags() }
            .navigationTitle("Новости")
        }
    }
}

private struct MenuPicker: View{
    @State var selection: Int = 1
    let tags: Array<Tag>
    let avm: ArticleViewModel
    var body: some View{
        VStack{
            Menu{
                picker
            } label: {
                pickerLabel
            }
            .onAppear(){ avm.fetchArticles(tagId: selection) }
        }
    }
    
    private var picker: some View{
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
        .onChange(of: selection){ avm.fetchArticles(tagId: $0) }
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
        .background(Color(.systemGray6))
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
