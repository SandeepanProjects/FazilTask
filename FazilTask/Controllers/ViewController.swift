//
//  ViewController.swift
//  FazilTask
//
//  Created by Apple on 12/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var petsTableView: UITableView!
    
    var viewModelUser = PetViewModel()
    var photos = [Json4Swift_Base]()
   // private let pendingOperations = PendingOperations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpTableView()
        viewModelUser.fetchPhotoDetails() { [weak self] (eventsData) in
            
           // print(eventsData)
           // self?.photos.append(eventsData)
           // self.photos.append(contentsOf: eventsData)
            DispatchQueue.main.async {
             self?.petsTableView.reloadData()
            }
        }
    }
    
    func setUpTableView() {
        petsTableView.register(UINib(nibName: String(describing: PetsViewCell.self),
                                   bundle: Bundle(for: PetsViewCell.self)),
                             forCellReuseIdentifier: PetsViewCell.cellId)
        petsTableView.tableFooterView = UIView(frame: .zero)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelUser.arrUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PetsViewCell.cellId) as? PetsViewCell {
            cell.fillCellBy(petRecord: viewModelUser.arrUsers[indexPath.row], indexPath: indexPath)
            //cell.reloadDelegate = self
            return cell
        }
        else { return UITableViewCell() }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        petsTableView.deselectRow(at: indexPath, animated: true)

        let vc = storyboard?.instantiateViewController(identifier: Strings.DetailViewController.rawValue) as? DetailViewController
        vc?.showDetails(pet: viewModelUser.arrUsers[indexPath.item])
        //vc?.petDataFromViewController = viewModelUser.arrUsers[indexPath.item]
        self.navigationController?.pushViewController (vc!, animated: true)
    }
    
}

extension ViewController: ReloadDelegate {
    func reloadPets(at indexPath: IndexPath) {
        petsTableView.reloadRows(at: [indexPath], with: .none )

    }
    
//    func reloadCollection(at indexPath: IndexPath) {
//       // petsTableView.reloadItems(at: [indexPath])
//        petsTableView.reloadRows(at: [indexPath], with: .none )
//    }
}
