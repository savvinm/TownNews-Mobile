//
//  AdMissingView.swift
//  TownNews
//
//  Created by maksim on 17.01.2022.
//

import SwiftUI

import SwiftUI

struct AddMissingView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var addViewModel = AddMissingViewModel()

    @FocusState private var charIsFocused: Bool
    @FocusState private var specCharIsFocused: Bool
    @FocusState private var lastLocIsFocused: Bool
    @FocusState private var clothesIsFocused: Bool
    @FocusState private var phoneIsFocused: Bool
    @State private var showingImagePicker = false
    @State private var shAlert = false
    var body: some View {
        Form {
            imageBlock
            personalDataBlock
            TextEditorSection(header: "Приметы", text: $addViewModel.characteristics, focused: $charIsFocused)
            TextEditorSection(header: "Особые приметы", text: $addViewModel.specCharacteristics, focused: $specCharIsFocused)
            TextEditorSection(header: "Последняя информация о местонахождении", text: $addViewModel.lastLocation, focused: $lastLocIsFocused)
            TextEditorSection(header: "Во что был одет", text: $addViewModel.clothes, focused: $clothesIsFocused)
            phoneNumberBlock
            if addViewModel.isAllFilled {
                saveButton
            }
        }
    }

    private var phoneNumberBlock: some View {
        Section(header: Text("Телефон для связи")) {
            TextField("+7", text: $addViewModel.phoneNumber)
                .keyboardType(.phonePad)
                .focused($phoneIsFocused)
            if phoneIsFocused {
                HStack {
                    Spacer()
                    Button("Далее") {
                        phoneIsFocused = false
                    }
                    Spacer()
                }
            }
        }
    }
    
    private var personalDataBlock: some View {
        Section(header: Text("")) {
            TextField("Имя", text: $addViewModel.firstName)
            TextField("Фамилия", text: $addViewModel.secondName)
            Picker(selection: $addViewModel.sex, label: Text("Пол")) {
                Text("Мужской").tag("Мужской")
                Text("Женский").tag("Женский")
                Text("Другой").tag("Другой")
            }
            DatePicker("Дата рождения", selection: $addViewModel.birthdate, displayedComponents: .date)
        }
    }
    
    private var saveButton: some View {
        HStack {
            Spacer()
            Button("Отправить на опубликацию") {
                do {
                    try addViewModel.sendMissing()
                    presentationMode.wrappedValue.dismiss()
                } catch {
                    print(error)
                }
            }
            .alert("Объявление отправлено на опубликацию", isPresented: $shAlert) {
                Button("OK", role: .cancel) { self.presentationMode.wrappedValue.dismiss() }
            }
            Spacer()
        }
    }
    
    private var imageBlock: some View {
        ZStack {
            HStack {
                Spacer()
                Text("Выберите изображение")
                Spacer()
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height:50)
                Spacer()
                
            }
            if let image = addViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.5)
                    .scaledToFill()
                    .clipped()
                    .cornerRadius(10)
            }
        }
        .onTapGesture { showingImagePicker.toggle() }
        .sheet(isPresented: $showingImagePicker) { ImagePicker(image: $addViewModel.image) }
    }
    
    private struct TextEditorSection: View {
        let header: String
        @Binding var text: String
        var focused: FocusState<Bool>.Binding
        
        var body: some View {
            Section(header: Text(header)) {
                TextEditor(text: $text)
                    .focused(focused)
                if focused.wrappedValue {
                    HStack {
                        Spacer()
                        Button("Далее") {
                            focused.wrappedValue = false
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct AdMissingView_Previews: PreviewProvider {
    static var previews: some View {
        AddMissingView()
    }
}
