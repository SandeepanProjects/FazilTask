//
//  PetViewModel.swift
//  FazilTask
//
//  Created by Apple on 12/11/21.
//

import Foundation
import Alamofire


public enum Result<T> {
    case success(T)
    case failure(Error)
}


class PetViewModel {
    
    weak var vc: ViewController?
    var arrUsers = [Json4Swift_Base]()
    
    // MARK: - Private functions
    private static func getData(url: URL,
                                completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
        
    func fetchPhotoDetails(completionhandler:(( _ eventsdata:[Json4Swift_Base])->Void)?) {
        let headers: HTTPHeaders = [
            "x-api-key": "d6fd31ff-2b46-4600-b25d-cbcd09f0ac14",
        ]
       
        let parameters: Parameters = [
             "attach_breed":5,
             "page": 2,
             "limit": 5
        ]
        
        AF.request( "https://api.thedogapi.com/v1/breeds?attach_breed=1&limit=5&page=1", headers: headers).response { [weak self] response in
            if let data = response.data {
                do {
                    let userResponse = try JSONDecoder().decode([Json4Swift_Base].self, from: data)
                    self?.arrUsers.append(contentsOf: userResponse)
                    
                    completionhandler?(userResponse)
                    //  self.arrUsers.append(contentsOf: userResponse)
                    //                    DispatchQueue.main.async{
                    //                        self.vc?.tblView.reloadData()
                    //                    }
                } catch let err {
                    print(err.localizedDescription)
                }
            }
        }
    }
    
    public static func downloadImage(url: URL,
                                     completion: @escaping (Result<Data>) -> Void) {
        getData(url: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async() {
                completion(.success(data))
            }
        }
    }
}
