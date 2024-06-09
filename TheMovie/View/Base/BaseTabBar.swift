//
//  BaseTabBar.swift
//  TheMovie
//
//  Created by Vu Phong on 24/05/2024.
//

import UIKit

enum TabBarType: Int {
    case movies = 0
    case tv
    case person

    var iconImages: UIImage? {
        switch self {
        case .movies:
            return UIImage(systemName: "film")
        case .tv:
            return UIImage(systemName: "tv")
        case .person:
            return UIImage(systemName: "person")
        }
    }

    var selectedIconImage: UIImage? {
        switch self {
        case .movies:
            return UIImage(systemName: "film.fill")
        case .tv:
            return UIImage(systemName: "tv.fill")
        case .person:
            return UIImage(systemName: "person.fill")
        }
    }

    var title: String? {
        switch self {
        case .movies:
            return "Movies"
        case .tv:
            return "TV Show"
        case .person:
            return "Person"
        }
    }
}

class BaseTabBar: UITabBar {

    private let tabBarTypes: [TabBarType] = [.movies, .tv, .person]
    @IBInspectable var color: UIColor?
    @IBInspectable var radii: CGFloat = 15.0
    private var shapeLayer: CALayer?

    override func draw(_ rect: CGRect) {
        // add TabBar style
        setTabBarSyle(defaultImages: tabBarTypes.compactMap(\.iconImages),
                      selectedImages: tabBarTypes.compactMap(\.selectedIconImage))
        // add Shape
        addShapeForTabBarItem()
    }

    private func setTabBarSyle(defaultImages: [UIImage], selectedImages: [UIImage]) {
        guard let items = self.items else { return }
        for index in 0..<items.count {
            let item = items[index]
            item.image = defaultImages[index]
            item.selectedImage = selectedImages[index]
        }
    }

    private func addShapeForTabBarItem() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.shadowColor = UIColor(red: 0.067, green: 0.063, blue: 0.718, alpha: 0.08).cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: 0)
        shapeLayer.shadowRadius = 12
        shapeLayer.shadowOpacity = 1.0
        shapeLayer.shadowPath = UIBezierPath(roundedRect: bounds,
                                             byRoundingCorners: [.topLeft, .topRight],
                                             cornerRadii: CGSize(width: 12, height: 12)).cgPath

        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }

    private func createPath() -> CGPath {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radii, height: 0.0))
        return path.cgPath
    }

}
