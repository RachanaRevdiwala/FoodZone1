//
//  HelperFunctions.swift
//  TestApp-Rachana
//
//  Created by Devkrushna4 on 22/07/22.
//

import Foundation
import UIKit

extension UIView{

    func addShadowWithCorner(shadowColor color:UIColor = UIColor.gray,
                             shadowOffset offset:CGSize = CGSize(width: 3.0, height: 3.0),
                             shadowOpacity opacity : Float = 0.5,
                             shadowRadius radius : CGFloat = 3.0,
                             cornerRadius :CGFloat = 5.0){
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 3.0
        
    }
    
    func gradientWithTwoBackground(from color1: CGColor, to color2: CGColor) { //}, startPosX x1: CGFloat, startPosY y1: CGFloat, endPosX x2: CGFloat, endPosY y2: CGFloat) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        
        gradient.colors = [color1, color2]
        gradient.startPoint = CGPoint(x: 0.5, y: 1.0) //CGPoint(x: x1, y: y1)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.0) //CGPoint(x: x2, y: y2)
        
        self.layer.insertSublayer(gradient, at: 0)
    }
}
