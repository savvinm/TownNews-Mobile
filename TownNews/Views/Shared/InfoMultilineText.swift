//
//  InfoMultilineText.swift
//  TownNews
//
//  Created by Maksim Savvin on 11.07.2022.
//

import SwiftUI

struct InfoMultilineText: View {
    let value: String
    var body: some View {
        VStack{
            Spacer()
            Text(value).multilineTextAlignment(.center)
            Spacer()
        }
        .padding()
        .foregroundColor(.secondary)
    }
}
