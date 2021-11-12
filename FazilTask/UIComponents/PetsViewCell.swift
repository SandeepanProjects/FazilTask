//
//  PetsViewCell.swift
//  FazilTask
//
//  Created by Apple on 12/11/21.
//

import UIKit

protocol ReloadDelegate: AnyObject {
    func reloadPets(at indexPath:IndexPath)
}

class PetsViewCell: UITableViewCell {

    @IBOutlet weak var petsImageView: UIImageView!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petBreed: UILabel!
    @IBOutlet weak var petLifeSpan: UILabel!
    @IBOutlet weak var petOrigin: UILabel!
    
    //@IBOutlet weak var indicator: UIActivityIndicatorView!
    
    public static let cellId = "PetListCellId"

    var cache:NSCache<AnyObject, AnyObject>!

    private let pendingOperations = PendingOperations()
    public weak var reloadDelegate: ReloadDelegate?
    
    private func startOperations(for photoRecord: Image, at indexPath: IndexPath) {
           switch (photoRecord.state) {
           case .new:
               startDownload(for: photoRecord, at: indexPath)
           case .downloaded:
                print("downloaded")
               startFiltration(for: photoRecord, at: indexPath)
           default:
               NSLog("do nothing")
           }
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    private func startDownload(for photoRecord: Image, at indexPath: IndexPath) {
           
           guard pendingOperations.downloadsInProgress[indexPath] == nil else {
               return
           }
//           self.cache = NSCache()
//
//        if (self.cache.object(forKey: (indexPath as NSIndexPath).item as AnyObject) != nil){
//
//        }
           let downloader = ImageDownloader(photoRecord)
           
           downloader.completionBlock = {
               if downloader.isCancelled {
                   return
               }
               
               DispatchQueue.main.async {
                   self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                   self.reloadDelegate?.reloadPets(at: indexPath)//(at: indexPath)
               }
           }
           
           pendingOperations.downloadsInProgress[indexPath] = downloader
           pendingOperations.downloadQueue.addOperation(downloader)
       }
       
       private func startFiltration(for photoRecord: Image, at indexPath: IndexPath) {
              guard pendingOperations.filtrationsInProgress[indexPath] == nil else {
                  return
              }

              let filterer = ImageFilteration(photoRecord)
              filterer.completionBlock = {
                  if filterer.isCancelled {
                      return
                  }

                  DispatchQueue.main.async {
                      self.pendingOperations.filtrationsInProgress.removeValue(forKey: indexPath)
                      self.reloadDelegate?.reloadPets(at: indexPath)//(at: indexPath)
                  }
              }

              pendingOperations.filtrationsInProgress[indexPath] = filterer
              pendingOperations.filtrationQueue.addOperation(filterer)

          }
    
    public func fillCellBy(petRecord: Json4Swift_Base, indexPath: IndexPath) {
        
        petName.text = petRecord.name ?? "N/A"
        petBreed.text = petRecord.breed_group ?? "N/A"
        petLifeSpan.text = petRecord.life_span ?? "N/A"
        petOrigin.text = petRecord.origin ?? "N/A"
        if let url = petRecord.image?.url {
            petsImageView.loadThumbnail(urlSting: url)
        }
        
//        switch (petRecord.state) {
//        case .filtered:
//            indicator.stopAnimating()
//            indicator.isHidden = true
//        case .failed:
//            indicator.stopAnimating()
//            petName.text = Strings.failedToLoad.rawValue
//            petBreed.text = Strings.failedToLoad.rawValue
//            petLifeSpan.text = Strings.failedToLoad.rawValue
//            petOrigin.text = Strings.failedToLoad.rawValue
//
//        case .new, .downloaded:
//            indicator.startAnimating()
//            if let image =  petRecord.image {
//                startOperations(for: image , at: indexPath)
//            }
//        }
    }
    
}
