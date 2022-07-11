//
//  PromoPreview.swift
//  TownNews
//
//  Created by Maksim Savvin on 11.07.2022.
//

import SwiftUI

struct PromoPreview: View {
    let promo: Promo
    let curentId: Int
    var body: some View {
        VStack {
            Spacer()
            Text(promo.title).multilineTextAlignment(.center)
            Spacer()
            promoImage
            Spacer()
            promocodeField
        }
        .frame(height: UIScreen.main.bounds.height * 0.4)
        .background(Color(.systemGray5))
        .cornerRadius(10)
    }
    
    private var promocodeField: some View {
        ZStack {
            HStack {
                Text(promo.promocode)
                if curentId == promo.id {
                    Image(systemName: "doc.on.doc.fill")
                } else {
                    Image(systemName: "doc.on.doc")
                }
            }
            Rectangle()
            .frame(height: 40)
            .background(Color.secondary)
            .opacity(0.1)
        }
    }
    
    private var promoImage: some View {
        ResizableAsyncImage(stringURL: promo.imageUrl)
            .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.2)
            .cornerRadius(10)
    }
}
