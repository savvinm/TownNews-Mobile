//
//  ArticlePreview.swift
//  TownNews
//
//  Created by Maksim Savvin on 05.03.2022.
//

import SwiftUI

struct ArticlePreview: View {
    let article: Article
    var body: some View {
        VStack {
            previewImage
            Spacer()
            previewTitle
            Spacer()
            previewTag
        }
        .frame(height: UIScreen.main.bounds.height * 0.45)
        .background(Color(.systemGray5))
        .cornerRadius(10)
    }
    
    private var previewTag: some View {
        HStack {
            Spacer()
            Text("#" + article.tag)
                .font(.footnote)
                .padding(.trailing, 5)
                .padding(.bottom, 2)
        }
    }
    
    private var previewTitle: some View {
        Text(article.title)
            .font(.headline)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 3)
    }
    
    private var previewImage: some View {
        ResizableAsyncImage(stringURL: article.imageUrl)
            .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.3)
            .clipped()
    }
}
