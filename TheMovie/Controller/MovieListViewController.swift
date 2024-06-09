//
//  MovieListViewController.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import UIKit
import RealmSwift
import SVProgressHUD

class MovieListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var movieListTableView: UITableView!
    
    var movieList: MovieListModel?
    var realmService: RealmServiceProtocol?
    var recentList: [MoviesRealmModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMovieListTableView()
        realmService = RealmService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchDataFromAPI()
        fetchDataFromDB()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList?.results.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if movieList == nil {
            return setupNoRecordCell(tableView, cellForRowAt: indexPath)
        } else {
            return setupRecordCell(tableView, cellForRowAt: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToMovieDetail(at: indexPath)
    }
    
    private func saveMovieIdToRealm(movieId: Double) {
        let moviesRealmModel = MoviesRealmModel()
        moviesRealmModel.idMovie = movieId
        realmService?.addData(object: moviesRealmModel, update: .all)
    }
    
    private func setupMovieListTableView() {
        movieListTableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        movieListTableView.register(UINib(nibName: "NoRecordTableViewCell", bundle: nil), forCellReuseIdentifier: "NoRecordTableViewCell")
        
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
        movieListTableView.rowHeight = UITableView.automaticDimension
        movieListTableView.estimatedRowHeight = 44
        movieListTableView.isHidden = true
    }
    
    private func fetchDataFromAPI() {
        let movieListFetcher = MovieListFetcher()
        SVProgressHUD.show()
        movieListFetcher.fetchAPIMovieList(page: 1) { [weak self] entity in
            SVProgressHUD.dismiss()
            self?.movieListTableView.isHidden = false
            self?.movieList = entity
            self?.movieListTableView.reloadData()
        } failureHandler: { error in
            SVProgressHUD.dismiss()
            self.displayErrorAlert(errorMessage: error.localizedDescription)
        }
    }
    
    private func fetchDataFromDB() {
        if let realmService = realmService {
            let ids = Array(realmService.getDataFromDB(MoviesRealmModel.self))
            recentList = ids
        }
    }
    
    private func setupNoRecordCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NoRecordTableViewCell", for: indexPath) as? NoRecordTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    private func setupRecordCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell, let model = movieList?.results[indexPath.row] {
            let isRecent = checkIfRecentMovie(withId: Double(model.id))
            cell.configureCell(model: model, isRecent: isRecent)
            return cell
        }
        return UITableViewCell()
    }
    
    private func navigateToMovieDetail(at indexPath: IndexPath) {
        guard let movie = movieList?.results[indexPath.row] else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let movieDetailVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            return
        }
        
        saveMovieIdToRealm(movieId: Double(movie.id))
        movieDetailVC.idMovie = movie.id
        movieDetailVC.type = .movie
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
    
    private func checkIfRecentMovie(withId id: Double) -> Bool {
        if let recentList = recentList {
            return recentList.contains { $0.idMovie == id }
        }
        return false
    }
}
