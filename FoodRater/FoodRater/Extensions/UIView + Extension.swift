//
//  UIView + Extension.swift
//  FoodRater
//
//  Created by Borna Ungar on 20.12.2021..
//

import Foundation
import UIKit

extension UIView {
    
    func addSubviews(views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
}
