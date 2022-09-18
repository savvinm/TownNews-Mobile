//
//  APIService.swift
//  TownNews
//
//  Created by maksim on 17.01.2022.
//

import SwiftUI

class APIService {
    @Published var status: Bool = false
    private let urlString: String
    private let imageService = ImageService()

    init(urlString: String) {
        self.urlString = urlString
    }
    func getJSON<T: Decodable>(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                               keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                               completion: @escaping(Result<T,APIError>) -> Void) {
        guard
            let url = URL(string: urlString)
        else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                completion(.failure(.invalidResponseStatus))
                return
            }
            guard
                error == nil
            else {
                completion(.failure(.dataTaskError))
                return
            }
            guard
                let data = data
            else {
                completion(.failure(.corruptData))
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }

        }
        .resume()
    }
    
    func fetchTask(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> DeferredTask? {
        guard
            let url = URL(string: urlString)
        else {
            return nil
        }
        let (data, response, error) = URLSession.shared.syncRequest(with: url)
        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            return nil
        }
        guard error == nil, let data = data
        else {
            return nil
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        do {
            let decodedData = try decoder.decode(DeferredTask.self, from: data)
            return decodedData
        } catch {
            return nil
        }
    }

    
    func postMissing(firstName: String, secondName: String, clothes: String, sex: String, characteristics: String, specCharacterisitcs: String, dateOfBirth: Date, image: UIImage, lastLocation: String, phoneNumber: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        request.httpMethod = "POST"
        let img = image.fixedOrientation()!
        let imageBase64 = imageService.compressImage(imageService.resizeImage(img)!)
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
        let task = URLSession.shared.dataTask(with: request) {
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
    }
}

enum APIError: Error {
    case invalidURL
    case invalidResponseStatus
    case dataTaskError
    case corruptData
    case decodingError
}
