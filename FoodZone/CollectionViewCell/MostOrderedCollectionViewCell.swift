//
//  MostOrderedCollectionViewCell.swift
//  FoodZone
//
//  Created by Devkrushna4 on 17/08/22.
//

import UIKit

class MostOrderedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblAdditionalInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgView.layer.masksToBounds = true
        self.imgView.layer.cornerRadius = self.imgView.frame.height / 7
        // Initialization code
    }

}
