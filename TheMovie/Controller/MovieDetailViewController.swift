//
//  MovieDetailViewController.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import UIKit
import SVProgressHUD

enum DetailSection: Int {
    case header = 0
    case title
    case overview
    case numberOfSection
}

enum DetailType: Int {
    case movie
    case tvShow
    case none
}

class MovieDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var movieTableView: UITableView!
    
    private var movieDetail: MovieDetailModel?
    private var tvModel: TVModel?
    var idMovie: Int = 0
    var type: DetailType = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchDataForDetail()
    }
    
    private func setupTableView() {
        movieTableView.register(UINib(nibName: "HeaderDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderDetailTableViewCell")
        movieTableView.register(UINib(nibName: "TitleDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleDetailTableViewCell")
        movieTableView.register(UINib(nibName: "OverviewDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "OverviewDetailTableViewCell")
        movieTableView.register(UINib(nibName: "NoRecordTableViewCell", bundle: nil), forCellReuseIdentifier: "NoRecordTableViewCell")
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.rowHeight = UITableView.automaticDimension
        movieTableView.estimatedRowHeight = 44
        movieTableView.isHidden = true
    }
    
    private func fetchDataForDetail() {
        if type == .movie {
            let movieDetailFetcher = MovieDetailFetcher()
            SVProgressHUD.show()
            movieDetailFetcher.fetchAPIMovieWith(id: idMovie) { [weak self] entity in
                SVProgressHUD.dismiss()
                self?.movieTableView.isHidden = false
                self?.movieDetail = entity
                self?.movieTableView.reloadData()
            } failureHandler: { error in
                SVProgressHUD.dismiss()
                self.displayErrorAlert(errorMessage: error.localizedDescription)
            }
        } else if type == .tvShow {
            let tvShowDetailFetcher = TVShowDetailFetcher()
            SVProgressHUD.show()
            tvShowDetailFetcher.fetchAPITVWith(id: idMovie) { [weak self] entity in
                SVProgressHUD.dismiss()
                self?.movieTableView.isHidden = false
                self?.tvModel = entity
                self?.movieTableView.reloadData()
            } failureHandler: { error in
                SVProgressHUD.dismiss()
                self.displayErrorAlert(errorMessage: error.localizedDescription)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if movieDetail == nil && tvModel == nil {
            return 1
        }
        return DetailSection.numberOfSection.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if movieDetail == nil && tvModel == nil {
            return setupNoRecordCell(tableView, cellForRowAt: indexPath)
        } else {
            switch indexPath.section {
                
            case DetailSection.header.rawValue:
                return setupHeaderCell(tableView, cellForRowAt: indexPath)
                
            case DetailSection.title.rawValue:
                return setupTitleCell(tableView, cellForRowAt: indexPath)
                
            case DetailSection.overview.rawValue:
                return setupOverviewCell(tableView, cellForRowAt: indexPath)
                
            default:
                return UITableViewCell()
            }
        }
    }
    
    private func setupNoRecordCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NoRecordTableViewCell", for: indexPath) as? NoRecordTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    private func setupHeaderCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderDetailTableViewCell", for: indexPath) as! HeaderDetailTableViewCell
        
        let backdropPath = (type == .movie) ? movieDetail?.backdropPath : tvModel?.backdropPath
        let posterPath = (type == .movie) ? movieDetail?.posterPath : tvModel?.posterPath
        
        cell.backPosterImage.kf.setImage(with: URL(string: URLConstant.baseImageUrl + backdropPath!))
        cell.posterImage.kf.setImage(with: URL(string: URLConstant.baseImageUrl + posterPath!))
        return cell
    }
    
    private func setupTitleCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleDetailTableViewCell", for: indexPath) as! TitleDetailTableViewCell
        
        let title = (type == .movie) ? movieDetail?.title : tvModel?.name
        let voteAverage = (type == .movie) ? movieDetail?.voteAverage : tvModel?.popularity
        
        cell.titleLabel.text = title
        cell.rateLabel.text = String(format: "%.1f", voteAverage!)
        
        return cell
    }
    
    private func setupOverviewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewDetailTableViewCell", for: indexPath) as! OverviewDetailTableViewCell
        
        let overview = (type == .movie) ? movieDetail?.overview : tvModel?.overview
        cell.overviewTextField.text = overview
        
        return cell
    }
}

