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

  //  var cache:NSCache<AnyObject, AnyObject>!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
