//
//  APIService.swift
//  TownNews
//
//  Created by maksim on 17.01.2022.
//

import Foundation
import UIKit

class APIService{
    @Published var status: Bool = false
    let urlString: String

    init(urlString: String){
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
    func postMissing(firstName: String, secondName: String, clothes: String, sex: String, characteristics: String, specCharacterisitcs: String, dateOfBirth: Date, image: UIImage, lastLocation: String, phoneNumber: String){
        guard let url = URL(string: urlString) else {return}
        var request = URLRequest(url: url)
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd"
        request.httpMethod = "POST"
        let img = image.fixedOrientation()!
        let imageBase64 = compressImage(image: resizeImage(image: img))
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
    }
    
    func resizeImage(image:UIImage) -> UIImage
        {
            var actualHeight:Float = Float(image.size.height)
            var actualWidth:Float = Float(image.size.width)

            let maxHeight:Float = 720.0
            let maxWidth:Float = 720.0

            var imgRatio:Float = actualWidth/actualHeight
            let maxRatio:Float = maxWidth/maxHeight

            if (actualHeight > maxHeight) || (actualWidth > maxWidth)
            {
                if(imgRatio < maxRatio)
                {
                    imgRatio = maxHeight / actualHeight;
                    actualWidth = imgRatio * actualWidth;
                    actualHeight = maxHeight;
                }
                else if(imgRatio > maxRatio)
                {
                    imgRatio = maxWidth / actualWidth;
                    actualHeight = imgRatio * actualHeight;
                    actualWidth = maxWidth;
                }
                else
                {
                    actualHeight = maxHeight;
                    actualWidth = maxWidth;
                }
            }

            let rect:CGRect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth) , height: CGFloat(actualHeight) )
            UIGraphicsBeginImageContext(rect.size)
            image.draw(in: rect)

            let img:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            let imageData = img.jpegData(compressionQuality: 1.0)!
            UIGraphicsEndImageContext()

            return UIImage(data: imageData)!
        }
    private func compressImage(image: UIImage)-> String?{
        let compression = 0.4
        let imageData = image.jpegData(compressionQuality: compression)
        let imageBase64 = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
        return imageBase64
    }
}

enum APIError: Error {
    case invalidURL
    case invalidResponseStatus
    case dataTaskError
    case corruptData
    case decodingError
}
extension UIImage {
    /// Fix image orientaton to protrait up
    func fixedOrientation() -> UIImage? {
        guard imageOrientation != UIImage.Orientation.up else {
            // This is default orientation, don't need to do anything
            return self.copy() as? UIImage
        }

        guard let cgImage = self.cgImage else {
            // CGImage is not available
            return nil
        }

        guard let colorSpace = cgImage.colorSpace, let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            return nil // Not able to create CGContext
        }

        var transform: CGAffineTransform = CGAffineTransform.identity

        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat.pi / -2.0)
        case .up, .upMirrored:
            break
        @unknown default:
            fatalError("Missing...")
            break
        }

        // Flip image one more time if needed to, this is to prevent flipped image
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        @unknown default:
            fatalError("Missing...")
            break
        }

        ctx.concatenate(transform)

        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }

        guard let newCGImage = ctx.makeImage() else { return nil }
        return UIImage.init(cgImage: newCGImage, scale: 1, orientation: .up)
    }
}
