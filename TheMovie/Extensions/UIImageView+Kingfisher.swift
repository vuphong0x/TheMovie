//
//  UIImageView+Kingfisher.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with url: URL?) {
        kf.indicatorType = .activity
        kf.setImage(with: url)
    }
    
    func cancelImageDownload() {
        kf.cancelDownloadTask()
    }
}
