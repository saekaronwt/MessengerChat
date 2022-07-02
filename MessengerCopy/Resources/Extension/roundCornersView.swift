//
//  roundCornersView.swift
//  MessengerCopy
//
//  Created by Paul Torres on 1/07/22.
//

import Foundation
import UIKit

extension UIView {
    func roundedCorners(corners : UIRectCorner, radius : CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
