//
//  TVListViewController.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import UIKit
import SVProgressHUD

class TVListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tvListTableView: UITableView!
    
    var tvList: TVListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchTVListFromAPI()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvList?.results.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tvList == nil {
            return setupNoRecordCell(tableView, cellForRowAt: indexPath)
        } else {
            return setupRecordCell(tableView, cellForRowAt: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToTVShowDetail(at: indexPath)
    }
    
    private func setupTableView() {
        tvListTableView.register(UINib(nibName: "TVTableViewCell", bundle: nil), forCellReuseIdentifier: "TVTableViewCell")
        tvListTableView.register(UINib(nibName: "NoRecordTableViewCell", bundle: nil), forCellReuseIdentifier: "NoRecordTableViewCell")
        
        tvListTableView.delegate = self
        tvListTableView.dataSource = self
        tvListTableView.rowHeight = UITableView.automaticDimension
        tvListTableView.estimatedRowHeight = 44
        tvListTableView.isHidden = true
    }
    
    private func fetchTVListFromAPI() {
        let tvListFetcher = TVListFetcher()
        SVProgressHUD.show()
        tvListFetcher.fetchAPITVList(page: 1) { [weak self] entity in
            SVProgressHUD.dismiss()
            self?.tvListTableView.isHidden = false
            self?.tvList = entity
            self?.tvListTableView.reloadData()
        } failureHandler: { error in
            SVProgressHUD.dismiss()
            self.displayErrorAlert(errorMessage: error.localizedDescription)
        }
    }
    
    private func setupNoRecordCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NoRecordTableViewCell", for: indexPath) as? NoRecordTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    private func setupRecordCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TVTableViewCell", for: indexPath) as? TVTableViewCell {
            if let model = tvList?.results[indexPath.row] {
                cell.configureCell(model: model)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    private func navigateToTVShowDetail(at indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let tvShowDetailVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController, let model = tvList?.results[indexPath.row] {
            tvShowDetailVC.idMovie = model.id
            tvShowDetailVC.type = .tvShow
            navigationController?.pushViewController(tvShowDetailVC, animated: true)
        }
    }
}
