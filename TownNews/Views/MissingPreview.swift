//
//  MissingPreview.swift
//  TownNews
//
//  Created by Maksim Savvin on 05.03.2022.
//

import SwiftUI

struct MissingPreview: View {
    let missing: Missing
    var isCreator = false
    var body: some View {
        NavigationLink{
            if(!isCreator){
                MissingView(missing: missing, title: nil)
            }
            else{
                CreatorMissingView(missing: missing)
            }
        } label: {
            previewLabel
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var previewLabel: some View{
        VStack{
            HStack{
                Text(missing.name + ",")
                Text(missing.age)
            }
            Spacer()
            previewImage
            Spacer()
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 50, height: 250).background(Color(.systemGray6))
        .cornerRadius(10)
    }
    
    private var previewImage: some View{
        AsyncImage(url: SharedViewModel.getFullURLToImage(url: missing.imageUrl)){ image in
            image
                .resizable()
                .scaledToFill()
                .cornerRadius(20)
                .frame(width: UIScreen.main.bounds.width/2.2, height: UIScreen.main.bounds.width/2.2)
                .clipped()
                .padding(.bottom, 0.0)
        } placeholder: {
            ProgressView()
        }.frame(width: 100, height: 110)
    }
}


