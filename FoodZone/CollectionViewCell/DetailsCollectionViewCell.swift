//
//  DetailsCollectionViewCell.swift
//  TestApp-Rachana
//
//  Created by Devkrushna4 on 22/07/22.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblpromoted: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var lblOfferDetail: UILabel!
    @IBOutlet weak var lblDurationOfDelivery: UILabel!
   
   
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblStarRating: UILabel!
    @IBOutlet weak var lblOriginalPrice: UILabel!
    
    @IBOutlet weak var imgOrderRatioView: UIImageView!
    @IBOutlet weak var lblOrderPlacedInfo: UILabel!
    @IBOutlet weak var imgEcoFriendlyView: UIImageView!
    @IBOutlet weak var imgMaxSafetyView: UIImageView!
    @IBOutlet weak var imgSafetyMark: UIImageView!
    
    
    var actionBlock: (() -> Void)? = nil
    
    @IBAction func didTapButton(sender: UIButton) {
        actionBlock?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpUI()
        // Initialization code
    }
    func setUpUI(){
        self.imgView.setCornerRadius(value: self.imgView.frame.height / 7)
        self.lblStarRating.setCornerRadius(value: 4)
        self.lblpromoted.setCornerRadius(value: self.lblpromoted.frame.height / 2)
        self.lblpromoted.backgroundColor = .black.withAlphaComponent(0.5)
        
        self.lblOfferDetail.setCornerRadius(value: 4)
        self.lblOfferDetail.backgroundColor = .blue.withAlphaComponent(0.5)
        
        self.lblDurationOfDelivery.setCornerRadius(value: 4)
        self.lblDurationOfDelivery.backgroundColor = .white.withAlphaComponent(0.5)
        
        
    }
  
}
