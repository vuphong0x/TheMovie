//
//  MovieTableViewCell.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var originTitleLabel: UILabel!
    @IBOutlet private weak var voteAverageLabel: UILabel!
    @IBOutlet private weak var releaseDataLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var contentMovieView: UIView!
    
    func configureCell(model: MovieModel, isRecent: Bool) {
        let textColor = isRecent ? UIColor.gray : UIColor.black
        voteAverageLabel.textColor = textColor
        originTitleLabel.textColor = textColor
        releaseDataLabel.textColor = textColor
        overviewLabel.textColor = textColor
        
        if let posterPath = model.posterPath {
            let imagePath = URLConstant.baseImageUrl + posterPath
            posterImageView.kf.setImage(with: URL(string: imagePath), placeholder: nil, options: [.processor(RoundCornerImageProcessor(cornerRadius: 40))])
        }
        
        originTitleLabel.text = model.originalTitle
        voteAverageLabel.text = String(format: "Vote: %.1f", model.voteAverage)
        releaseDataLabel.text = model.releaseDate
        overviewLabel.text = model.overview
    }
}
