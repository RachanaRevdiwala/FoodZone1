//
//  TitleCollectionViewCell.swift
//  FoodZone
//
//  Created by Devkrushna4 on 17/08/22.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = self.contentView.frame.height / 7
        // Initialization code
    }

}
