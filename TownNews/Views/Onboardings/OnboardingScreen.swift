//
//  OnboardingScreen.swift
//  TownNews
//
//  Created by Maksim Savvin on 21.09.2022.
//

import SwiftUI

struct OnboardingScreen: View {
    let imageName: String
    let description: String
    let imageSize: CGFloat
    var body: some View {
        VStack {
            Spacer()
            logoImage
                .padding()
            descriptionBlock
                .padding()
            Spacer()
        }
    }
    
    private var logoImage: some View {
        Image(uiImage: UIImage(named: imageName)!)
            .resizable()
            .scaledToFit()
            .frame(width: UIScreen.main.bounds.width * imageSize, height: UIScreen.main.bounds.width * imageSize)
            .cornerRadius(15)
    }
    
    private var descriptionBlock: some View {
        Text(description)
            .fontWeight(.semibold)
            .font(.system(size: 20))
            .multilineTextAlignment(.center)
    }
}
