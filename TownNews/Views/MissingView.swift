//
//  MissingView.swift
//  TownNews
//
//  Created by maksim on 25.01.2022.
//

import SwiftUI

struct MissingView: View {
    let missing: Missing
    let title: String?
    var body: some View {
        ScrollView {
            VStack {
                Text(title ?? "Пропал человек").font(.headline)
                missingImage
                missingBody
            }
            .padding([.leading, .bottom, .trailing])
        }
        
    }
    
    private var missingBody: some View {
        VStack {
            MissingSection(label: "Имя", value: missing.name)
            
            MissingSection(label: "Возраст", value: missing.age)

            MissingSection(label: "Пол", value: missing.sex)

            MissingSection(label: "Приметы", value: missing.characteristics)
            
            MissingSection(label: "Особые приметы", value: missing.specCharacteristics)
            
            MissingSection(label: "Последнее местонахождение", value: missing.lastLocation)
            
            MissingSection(label: "Был одет", value: missing.clothes)

            MissingSection(label: "Телефон для связи", value: missing.telephone)
        }
        .font(.callout)
    }
    
    private var missingImage: some View {
        ResizableAsyncImage(stringURL: missing.imageUrl)
            .frame(width: UIScreen.main.bounds.width * 0.95)
    }
}

private struct MissingSection: View {
    let label: String
    let value: String
    var body: some View {
        VStack {
            HStack {
                Text(label + ":").font(.body.weight(.bold))
                Spacer()
            }
            HStack {
                Text(value)
                Spacer()
            }
        }
        .padding(.bottom)
    }
}
