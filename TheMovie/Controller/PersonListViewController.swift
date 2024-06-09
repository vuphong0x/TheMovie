//
//  PersonListViewController.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import UIKit
import SVProgressHUD

class PersonListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var personListCollectionView: UICollectionView!
    
    var personalList: PersonListModel?
    private let personListFetcher = PersonListFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPersonListCollectionView()
        fetchDataFromAPI()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return personalList?.results.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersonCollectionViewCell", for: indexPath) as? PersonCollectionViewCell, let model = personalList?.results[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.configureCell(model: model)
        return cell
    }
    
    private func setupPersonListCollectionView() {
        personListCollectionView.register(UINib(nibName: "PersonCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PersonCollectionViewCell")
        personListCollectionView.delegate = self
        personListCollectionView.dataSource = self
        personListCollectionView.isHidden = false

    }
    
    private func fetchDataFromAPI() {
        SVProgressHUD.show()
        personListFetcher.fetchPersonListFromAPI(page: 1) { [weak self] entity in
            SVProgressHUD.dismiss()
            self?.personListCollectionView.isHidden = false
            self?.personalList = entity
            self?.personListCollectionView.reloadData()
        } failureHandler: { error in
            SVProgressHUD.dismiss()
            self.displayErrorAlert(errorMessage: error.localizedDescription)
        }
    }
}

