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
    
    //private var dataService: DataService?

    //static let sharedInstance = UserViewModel()
   // weak var vc: ViewController?
    
//    func fetchPhotoDetails(completionhandler:(( _ eventsdata:Json4Swift_Base)->Void)?){
//                let request = URLRequest(url: DataSource.url)
//      //  UIApplication.shared.isNetworkActivityIndicatorVisible = true
//
//        let task = URLSession(configuration: .default).dataTask(with: request) { data, response, error in
//
////            let alertController = UIAlertController(title: Strings.oops.rawValue,
////                                                    message: Strings.fetchError.rawValue,
////                                                    preferredStyle: .alert)
////            let okAction = UIAlertAction(title: Strings.ok.rawValue, style: .default)
////            alertController.addAction(okAction)
//
//            if let data = data {
//
//                do {
//
//                    let userResponse = try JSONDecoder().decode(Json4Swift_Base.self, from: data)
//                   // var     percentageList = userResponse.map { item.percentage }
//
//                    completionhandler?(userResponse)
//
////                    self.photos.append(userResponse)
////                    DispatchQueue.main.async{
////                        self.vc?.lunchCollectionView.reloadData()
////                    }
////                    let datasourceDictionary =
////                        try PropertyListSerialization.propertyList(from: data,
////                                                                   options: [],
////                                                                   format: nil) as! [String: String]
////
////                    for (name, value) in datasourceDictionary {
////                        let url = URL(string: value)
////                        if let url = url {
////                            let photoRecord = PhotoRecord(name: name, url: url)
////                            self.photos.append(photoRecord)
////                        }
////                    }
//
//                   // DispatchQueue.main.async {
//
////                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
////                        self.vc?.lunchCollectionView.reloadData()                    }
//                } catch {
//
//                    print("error")
////                    DispatchQueue.main.async {
////                        self.present(alertController, animated: true, completion: nil)
////                    }
//                }
//            }
//
//            if error != nil {
////                DispatchQueue.main.async {
////                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
////                    self.present(alertController, animated: true, completion: nil)
////                }
//            }
//        }
//        task.resume()
//    }

    
    
    func fetchPhotoDetails(completionhandler:(( _ eventsdata:[Json4Swift_Base])->Void)?) {
        let headers: HTTPHeaders = [
            "x-api-key": "d6fd31ff-2b46-4600-b25d-cbcd09f0ac14",
        ]
        AF.request(DataSource.url, headers: headers).response { [weak self] response in
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
