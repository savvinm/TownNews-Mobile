//
//  MenuPicker.swift
//  TownNews
//
//  Created by Maksim Savvin on 18.09.2022.
//

import SwiftUI

struct MenuPicker: View {
    @State var selection: Int
    @ObservedObject var tagsViewModel: TagsViewModel
    let articlesViewModel: ArticlesViewModel
    
    init(tagsViewModel: TagsViewModel, articlesViewModel: ArticlesViewModel) {
        self.tagsViewModel = tagsViewModel
        self.articlesViewModel = articlesViewModel
        self.selection = articlesViewModel.currentTag
    }
    
    var body: some View {
        GeometryReader { geometry in
            Menu {
                pickerBody
            } label: {
                pickerLabel
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .background(Color(.systemGray5))
                    .cornerRadius(15)
            }
        }
    }
    
    private var pickerBody: some View {
        Picker("Filter", selection: $selection) {
            ForEach(tagsViewModel.tags) { tag in
                HStack {
                    Text(tag.title)
                    if tag.important {
                        Image(systemName: "exclamationmark.circle.fill")
                    }
                }
                .tag(tag.id)
            }
        }
        .pickerStyle(InlinePickerStyle())
        .onChange(of: selection) {
            if $0 > 0 && $0 <= tagsViewModel.tags.count {
                articlesViewModel.currentTag = $0
                tagsViewModel.fetchTags()
                articlesViewModel.fetchArticles()
            }
        }
    }
    
    private var pickerLabel: some View {
        HStack {
            if tagsViewModel.tags.count > 0 {
                Text(tagsViewModel.tags[selection - 1].title)
            }
        }
    }
}
