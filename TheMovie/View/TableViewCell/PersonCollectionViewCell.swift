//
//  PersonCollectionViewCell.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import UIKit
import Kingfisher

class PersonCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    
    func configureCell(model: PersonModel) {
        let imagePath = URLConstant.baseImageUrl + model.profilePath
        posterImageView.kf.setImage(with: URL(string: imagePath), placeholder: nil, options: [.processor(RoundCornerImageProcessor(cornerRadius: 40))])
        
        nameLabel.text = model.name
    }

}
