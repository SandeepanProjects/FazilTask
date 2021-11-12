//
//  DetailViewController.swift
//  FazilTask
//
//  Created by Apple on 12/11/21.
//

import UIKit

class PetDetails {
    
}

class DetailViewController: UIViewController {

    var petDataFromViewController: Json4Swift_Base?
    
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petBreed: UILabel!
    @IBOutlet weak var petLifeSpan: UILabel!
    @IBOutlet weak var petOrigin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        petName.text = "Name: \(petDataFromViewController?.name ?? "N/A")"
        petBreed.text = "Breed: \(petDataFromViewController?.breed_group ?? "N/A")"
        petLifeSpan.text = "Lifespan : \(petDataFromViewController?.life_span ?? "N/A")"
        petOrigin.text = "Origin: \(petDataFromViewController?.origin ?? "N/A")"
        petImage.loadThumbnail(urlSting: petDataFromViewController?.image?.url ?? "N/A")
    }
    
    func showDetails(pet: Json4Swift_Base?) {
        
        if let petData = pet {
            self.petDataFromViewController = petData
        }
       
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
