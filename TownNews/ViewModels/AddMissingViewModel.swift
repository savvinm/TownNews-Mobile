//
//  AddMissingViewModel.swift
//  TownNews
//
//  Created by Maksim Savvin on 16.07.2022.
//

import SwiftUI

class AddMissingViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var secondName = ""
    @Published var sex = ""
    @Published var birthdate = Date()
    @Published var characteristics = ""
    @Published var specCharacteristics = ""
    @Published var lastLocation = ""
    @Published var clothes = ""
    @Published var phoneNumber = "+"
    @Published var showingImagePicker = false
    var image: UIImage? {
        didSet {
            if image != nil {
                DispatchQueue.main.async { [weak self] in
                    self?.objectWillChange.send()
                }
            }
        }
    }
    
    var isAllFilled: Bool {
        phoneNumber.count == 12 && firstName != "" && secondName != "" &&
        clothes != ""  && lastLocation != "" && characteristics != ""  &&
        specCharacteristics != ""  && image != nil && sex != ""
    }
    
    func sendMissing() throws {
        /*let api = SharedViewModel()
        api.sendMissing(firstName: firstName, secondName: secondName, clothes: clothes, sex: sex, characteristics: characteristics, specCharacteristics: specCharacteristics, dateOfBirth: birthdate, image: inputImage!, lastLocation: lastLocation, phoneNumber: phoneNumber)*/
    }
}
