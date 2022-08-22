//
//  FavouriteFoodCollectionViewCell.swift
//  FoodZone
//
//  Created by Devkrushna4 on 16/08/22.
//

import UIKit

class FavouriteFoodCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgView.layer.masksToBounds = true
        self.imgView.layer.cornerRadius = self.imgView.frame.height / 2
        // Initialization code
    }

}
