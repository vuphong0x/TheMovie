//
//  TVTableViewCell.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import UIKit
import Kingfisher

class TVTableViewCell: UITableViewCell {

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var originTitleLabel: UILabel!
    @IBOutlet private weak var popularityLabel: UILabel!
    @IBOutlet private weak var releaseDataLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!

    func configureCell(model: TVModel) {
        let imagePath = URLConstant.baseImageUrl + model.posterPath
        posterImageView.kf.setImage(with: URL(string: imagePath), placeholder: nil, options: [.processor(RoundCornerImageProcessor(cornerRadius: 40))])
        
        originTitleLabel.text = model.originalName
        popularityLabel.text = String(format: "Popularity: %.1f", model.popularity)
        releaseDataLabel.text = model.firstAirDate
        overviewLabel.text = model.overview
    }
}
