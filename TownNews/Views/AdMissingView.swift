//
//  AdMissingView.swift
//  TownNews
//
//  Created by maksim on 17.01.2022.
//

import SwiftUI

struct AdMissingView: View {
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    @State private var firstName = ""
    @State private var secondName = ""
    @State private var sex = ""
    @State private var birthdate = Date()
    @State private var characteristics = ""
    @FocusState private var charIsFocused: Bool
    @State private var specCharacteristics = ""
    @FocusState private var specCharIsFocused: Bool
    @State private var lastLocation = ""
    @FocusState private var lastLocIsFocused: Bool
    @State private var clothes = ""
    @FocusState private var clothesIsFocused: Bool
    @State private var phoneNumber = "+"
    @FocusState private var phoneIsFocused: Bool
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var shAlert = false
    var body: some View {
        Form{
            ZStack{
                HStack{
                    Spacer()
                    Text("Выберите изображение")
                    Spacer()
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height:50)
                    Spacer()
                    
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                image?
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width-60, height: UIScreen.main.bounds.height/2)
                    .scaledToFill()
                    .clipped()
                    .cornerRadius(10)
                    .onTapGesture {showingImagePicker = true}
            }.onChange(of: inputImage){ _ in loadImage()}
            .sheet(isPresented: $showingImagePicker){ImagePicker(image: $inputImage)}
            Section(header: Text("")){
                TextField("Имя", text: $firstName)
                TextField("Фамилия", text: $secondName)
                Picker(selection: $sex, label: Text("Пол")) {
                    Text("Мужской").tag("Мужской")
                    Text("Женский").tag("Женский")
                    Text("Другой").tag("Другой")
                }
                DatePicker("Дата рождения", selection: $birthdate, displayedComponents: .date)
            }
            Section(header: Text("Приметы")){
                TextEditor(text: $characteristics)
                    .focused($charIsFocused)
                if(charIsFocused){
                    HStack{
                        Spacer()
                        Button("Далее"){
                            charIsFocused = false
                        }
                        Spacer()
                    }
                }
            }
            Section(header: Text("Особые приметы")){
                TextEditor(text: $specCharacteristics)
                    .focused($specCharIsFocused)
                if(specCharIsFocused){
                    HStack{
                        Spacer()
                        Button("Далее"){
                            specCharIsFocused = false
                        }
                        Spacer()
                    }
                }
            }
            Section(header: Text("Последняя информация о местонахождении")){
                TextEditor(text: $lastLocation)
                    .focused($lastLocIsFocused)
                if(lastLocIsFocused){
                    HStack{
                        Spacer()
                        Button("Далее"){
                            lastLocIsFocused = false
                        }
                        Spacer()
                    }
                }
            }
            Section(header: Text("Во что был одет")){
                TextEditor(text: $clothes)
                    .focused($clothesIsFocused)
                if(clothesIsFocused){
                    HStack{
                        Spacer()
                        Button("Далее"){
                            clothesIsFocused = false
                        }
                        Spacer()
                    }
                }
            }
            Section(header: Text("Телефон для связи")){
                TextField("+7", text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .focused($phoneIsFocused)
                if(phoneIsFocused){
                    HStack{
                        Spacer()
                        Button("Далее"){
                            phoneIsFocused = false
                        }
                        Spacer()
                    }
                }
            }
            if(phoneNumber.count == 12 && firstName != ""
               && secondName != "" && clothes != ""  && lastLocation != "" && characteristics != ""  && specCharacteristics != ""  && image != nil && sex != ""){
                HStack{
                    Spacer()
                    Button("Отправить на опубликацию"){
                        /*let api = SharedViewModel()
                        api.sendMissing(firstName: firstName, secondName: secondName, clothes: clothes, sex: sex, characteristics: characteristics, specCharacteristics: specCharacteristics, dateOfBirth: birthdate, image: inputImage!, lastLocation: lastLocation, phoneNumber: phoneNumber)
                        shAlert = true*/
                    }
                    .alert("Объявление отправлено на опубликацию", isPresented: $shAlert){
                        Button("OK", role: .cancel){
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                    Spacer()
                }
            }
        }
    }
    func loadImage(){
        guard let inputImage = inputImage else {return}
        image = Image(uiImage: inputImage)
    }
}

struct AdMissingView_Previews: PreviewProvider {
    static var previews: some View {
        AdMissingView()
    }
}
