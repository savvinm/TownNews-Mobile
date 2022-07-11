//
//  APIService.swift
//  TownNews
//
//  Created by maksim on 17.01.2022.
//

import Combine
import Foundation

final class APIService {
    enum APIError: Error {
        case noInternetConnection
        case invalidURL
        case invalidResponseStatus
        case dataTaskError
        case corruptData
        case decodingError
        case somethingWentWrong
    }
    
    enum Endpoint {
        case articlesList(uuid: String)
        case articlesListWithFilter(uuid: String, filterTag: Int)
        case article(uuid: String, articleId: Int)
        case favorites(uuid: String)
        case addFavorite(uuid: String, id: Int)
        case deleteMissing(uuid: String, id: Int)
        case missingsList
        case userMissingList(uuid: String)
        case promosList
        case tagsList
    }
    
    private let baseURL = "https://townnews.site"

    private func applyEndpoint(_ endpoint: Endpoint) -> String {
        var stringURL = baseURL
        switch endpoint {
        case .articlesList(let uuid):
            stringURL += "/articleslist/\(uuid)"
        case .articlesListWithFilter(let uuid, let filterTag):
            stringURL += "/articleslist/\(filterTag)/\(uuid)"
        case .article(let uuid, let articleId):
            stringURL += "/getarticle/\(articleId)/\(uuid))"
        case .favorites(let uuid):
            stringURL += "/favoriteslist/\(uuid)"
        case .addFavorite(let uuid, let id):
            stringURL += "/addfavorite/\(id)/\(uuid)"
        case .deleteMissing(let uuid, let id):
            stringURL += "/deletemissing/\(id)/\(uuid)"
        case .missingsList:
            stringURL += "/missinglist"
        case .userMissingList(let uuid):
            stringURL += "/usermissinglist/\(uuid)"
        case .promosList:
            stringURL += "/promoslist"
        case .tagsList:
            stringURL += "/tagslist"
        }
        return stringURL
    }
    
    /*
    func sendArticleIdForFavorite(_ id: Int){
        let url = URL(string: "https://townnews.site/addfavorite/" + String(id) + "/" + String(UIDevice.current.identifierForVendor!.uuidString))
        let task = URLSession.shared.dataTask(with: url!)
        task.resume()
    }
    
    func sendDeleteFor(_ missing: Missing){
        let url = URL(string: "https://townnews.site/deletemissing/" + String(missing.id) + "/" + String(UIDevice.current.identifierForVendor!.uuidString))
        let task = URLSession.shared.dataTask(with: url!)
        task.resume()
    }
    */
    /// This needs to be done on server side when returning articles (or etc) list
    static func getFullURLToImage(url: String) -> URL{
        URL(string: "https://townnews.site/getimage/" + url)!
    }
    
    static func initApp() -> DeferredTask?{
        /*let url = "https://townnews.site/appinit/\(String(UIDevice.current.systemVersion))/\(String(UIDevice.current.identifierForVendor!.uuidString))"
        let apiService = APIService(urlString: url)
        return apiService.fetchTask()*/
        return nil
    }
    /*
    func sendMissing(firstName: String, secondName: String, clothes: String, sex: String, characteristics: String, specCharacteristics: String, dateOfBirth: Date, image: UIImage, lastLocation: String, phoneNumber: String){
        /*let url = "https://townnews.site/addmissing"
        let api = APIService(urlString: url)
        api.postMissing(firstName: firstName, secondName: secondName, clothes: clothes, sex: sex, characteristics: characteristics, specCharacterisitcs: specCharacteristics, dateOfBirth: dateOfBirth, image: image, lastLocation: lastLocation, phoneNumber: phoneNumber)*/
    }
    */
    
    
    
    func getJSON<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, APIError> {
        guard let url = URL(string: applyEndpoint(endpoint)) else {
            return Fail(error: APIError.invalidURL)
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> APIError in
                switch error {
                case URLError.notConnectedToInternet:
                    return .noInternetConnection
                case URLError.badServerResponse:
                    return .invalidResponseStatus
                default:
                    return .somethingWentWrong
                }
            }
            .eraseToAnyPublisher()
    }
    
    /*func postMissing(firstName: String, secondName: String, clothes: String, sex: String, characteristics: String, specCharacterisitcs: String, dateOfBirth: Date, image: UIImage, lastLocation: String, phoneNumber: String){
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        request.httpMethod = "POST"
        let img = image.fixedOrientation()!
        let imageBase64 = compressImage(resizeImage(img))
        let body: [String: AnyHashable] = [
            "id": String(UIDevice.current.identifierForVendor!.uuidString),
            "name" : firstName + " " + secondName,
            "clothes": clothes,
            "characteristics": characteristics,
            "specCharacteristics": specCharacterisitcs,
            "lastLocation": lastLocation,
            "sex": sex,
            "dateOfBirth": formater.string(from: dateOfBirth),
            "phoneNumber": phoneNumber,
            "city": "Воронеж",
            "image": imageBase64,
            
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        let task = URLSession.shared.dataTask(with: request){
            data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(response)
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }*/
}
