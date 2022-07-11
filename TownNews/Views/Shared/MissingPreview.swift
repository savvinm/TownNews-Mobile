//
//  MissingPreview.swift
//  TownNews
//
//  Created by Maksim Savvin on 05.03.2022.
//

import SwiftUI

struct MissingPreview: View {
    let missing: Missing
    let missingsViewModel: MissingsViewModel
    var isCreator = false
    var body: some View {
        ZStack {
            NavigationLink {
                if !isCreator {
                    MissingView(missing: missing, title: nil)
                } else {
                    CreatorMissingView(missing: missing, missingsViewModel: missingsViewModel)
                }
            } label: {
                EmptyView()
            }
            previewLabel
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var previewLabel: some View {
        VStack {
            HStack {
                Text(missing.name + ",")
                Text(missing.age)
            }
            .padding(.top)
            Spacer()
            previewImage
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 50, height: 250)
        .background(Color(.systemGray5))
        .cornerRadius(10)
    }
    
    private var previewImage: some View {
        ResizableAsyncImage(stringURL: missing.imageUrl)
            .frame(width: UIScreen.main.bounds.width / 2.2, height: UIScreen.main.bounds.width / 2.2)
            .clipped()
    }
}


