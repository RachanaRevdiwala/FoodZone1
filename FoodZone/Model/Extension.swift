//
//  Extension.swift
//  FoodZone
//
//  Created by Devkrushna4 on 22/08/22.
//

import Foundation
import UIKit

extension UIView{
    func setCornerRadius(value: CGFloat){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = value
    }
}
