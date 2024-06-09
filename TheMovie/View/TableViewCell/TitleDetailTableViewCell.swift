//
//  TitleDetailTableViewCell.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import UIKit

class TitleDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.numberOfLines = 0
    }
    
}
