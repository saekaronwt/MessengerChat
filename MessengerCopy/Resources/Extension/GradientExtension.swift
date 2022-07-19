//
//  GradientExtension.swift
//  MessengerCopy
//
//  Created by Paul Torres on 14/07/22.
//

import UIKit

extension UIView {

    func applyGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.init(rgb: 0xEFF1F7, alpha: 0.0),
                           UIColor.init(rgb: 0xEEF1F6, alpha: 0.3),
                           UIColor.init(rgb: 0xEEF1F6, alpha: 1.0),
                           UIColor.init(rgb: 0xEEF1F6, alpha: 1.0)
                               ]
        gradient.locations = [0.0, 0.07, 0.18, 0.94]
        gradient.frame = self.bounds
        self.layer.addSublayer(gradient)
    }
}
