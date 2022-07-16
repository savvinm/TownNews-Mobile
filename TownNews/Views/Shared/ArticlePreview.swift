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
        GeometryReader { geometry in
            VStack {
                previewImage(in: geometry)
                Spacer()
                previewTitle
                Spacer()
                previewTag
            }
        }
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
    
    private func previewImage(in geometry: GeometryProxy) -> some View {
        ResizableAsyncImage(stringURL: article.imageUrl)
            .frame(width: geometry.size.width, height: geometry.size.height * 0.65)
            .clipped()
    }
}

