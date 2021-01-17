//
//  RoundTopView.swift
//  MenuItemsViperRx
//
//  Created by Kareem Ahmed on 13/01/2021.
//

import UIKit

protocol cornerRoundable {}

extension cornerRoundable where Self: UIView {
    func addRoundCorners(corners:UIRectCorner, radius:CGFloat) {
        let bounds = self.bounds

        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))

        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath

        self.layer.mask = maskLayer

        let frameLayer = CAShapeLayer()
        frameLayer.frame = bounds
        frameLayer.path = maskPath.cgPath
        frameLayer.strokeColor = nil//UIColor.red.cgColor
        frameLayer.fillColor = UIColor.red.cgColor

        self.layer.addSublayer(frameLayer)
    }
    
    func maskByRoundingCorners(_ masks:UIRectCorner, withRadii radii:CGSize = CGSize(width: 10, height: 10)) {
        let rounded = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: masks, cornerRadii: radii)

        let shape = CAShapeLayer()
        shape.path = rounded.cgPath

        self.layer.mask = shape
    }
    
    
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {

            DispatchQueue.main.async {
                let path = UIBezierPath(roundedRect: self.bounds,
                                        byRoundingCorners: corners,
                                        cornerRadii: CGSize(width: radius, height: radius))
                let maskLayer = CAShapeLayer()
                maskLayer.frame = self.bounds
                maskLayer.path = path.cgPath
                self.layer.mask = maskLayer
            }
        }
}


class RoundTopView: UIView, cornerRoundable {
    
}
