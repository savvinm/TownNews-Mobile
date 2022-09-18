//
//  SharedViewModel.swift
//  TownNews
//
//  Created by Maksim Savvin on 05.03.2022.
//

import SwiftUI

class SharedViewModel{
    
    func sendArticleIdForFavorite(_ id: Int) {
        let url = URL(string: "https://townnews.site/addfavorite/" + String(id) + "/" + String(UIDevice.current.identifierForVendor!.uuidString))
        let task = URLSession.shared.dataTask(with: url!)
        task.resume()
    }
    
    func sendDeleteFor(_ missing: Missing) {
        let url = URL(string: "https://townnews.site/deletemissing/" + String(missing.id) + "/" + String(UIDevice.current.identifierForVendor!.uuidString))
        let task = URLSession.shared.dataTask(with: url!)
        task.resume()
    }
    
    static func initApp() -> DeferredTask? {
        let url = "https://townnews.site/appinit/\(String(UIDevice.current.systemVersion))/\(String(UIDevice.current.identifierForVendor!.uuidString))"
        let apiService = APIService(urlString: url)
        return apiService.fetchTask()
    }
    
    func sendMissing(firstName: String, secondName: String, clothes: String, sex: String, characteristics: String, specCharacteristics: String, dateOfBirth: Date, image: UIImage, lastLocation: String, phoneNumber: String) {
        let url = "https://townnews.site/addmissing"
        let api = APIService(urlString: url)
        api.postMissing(firstName: firstName, secondName: secondName, clothes: clothes, sex: sex, characteristics: characteristics, specCharacterisitcs: specCharacteristics, dateOfBirth: dateOfBirth, image: image, lastLocation: lastLocation, phoneNumber: phoneNumber)
    }
}

struct DeferredTask: Codable{
    let task: String
}
