//
//  HeaderDetailTableViewCell.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import UIKit

class HeaderDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backPosterImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCornerRadius(view: backPosterImage)
        setupCornerRadius(view: posterImage)
    }
    
    private func setupCornerRadius(view: UIView) {
        view.layoutIfNeeded()
        view.layer.cornerRadius = 4
        view.layer.masksToBounds = true
    }
    
}
