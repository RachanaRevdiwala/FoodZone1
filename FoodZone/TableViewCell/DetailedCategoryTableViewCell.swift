//
//  CategoryTableViewCell.swift
//  TestApp-Rachana
//
//  Created by Devkrushna4 on 22/07/22.
//

import UIKit

class DetailedCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var category = [FoodData]()
    var title = ""
    var index = Int()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.registerCollectionViewCell()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func registerCollectionViewCell(){
        self.categoryCollectionView.register(UINib(nibName: CellIdentifier.favouriteFoodCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.favouriteFoodCollectionViewCell)
        self.categoryCollectionView.register(UINib(nibName: CellIdentifier.detailsCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.detailsCollectionViewCell)
        self.categoryCollectionView.register(UINib(nibName: CellIdentifier.mostOrderedCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.mostOrderedCollectionViewCell)
        
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.dataSource = self
        
        
        
    }
    func setUpCollectionView(data: [FoodData]){
        self.category = data
        if index == 2{
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            categoryCollectionView.collectionViewLayout = layout
        }else{
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            categoryCollectionView.collectionViewLayout = layout
        }
        self.categoryCollectionView.reloadData()
    }
}


extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch index{
        case 0:
            return self.getMostOrderedCollectionViewCell(indexPath: indexPath)
        case 1:
           return self.getFavouriteFoodCollectionViewCell(indexPath: indexPath)
        case 2:
            return self.getDetailCollectionViewCell(indexPath: indexPath)
        default:
            break
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch index{
        case 0:
            return CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.height/2) //self.getMostOrderedCollectionViewCell(indexPath: indexPath).frame.size
        case 1:
            return CGSize(width: collectionView.frame.size.width/4, height: collectionView.frame.size.height/2)//self.getFavouriteFoodCollectionViewCell(indexPath: indexPath).frame.size
        case 2:
            return CGSize(width: collectionView.frame.size.width, height: 250) //self.getDetailCollectionViewCell(indexPath: indexPath).frame.size
        default:
            break
        }
        return CGSize()
    }

    
    func getMostOrderedCollectionViewCell(indexPath: IndexPath)-> UICollectionViewCell{
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.mostOrderedCollectionViewCell, for: indexPath) as! MostOrderedCollectionViewCell
        
        cell.imgView.image = category[indexPath.row].FoodImage
        cell.lblTitle.text = category[indexPath.row].productName
        cell.lblInfo.text = category[indexPath.row].info
        cell.lblAdditionalInfo.text = category[indexPath.row].offerDetail
        return cell
    }
    func getFavouriteFoodCollectionViewCell(indexPath: IndexPath)-> UICollectionViewCell{
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.favouriteFoodCollectionViewCell, for: indexPath) as! FavouriteFoodCollectionViewCell
        cell.imgView.image = category[indexPath.row].FoodImage
        cell.lblName.text = category[indexPath.row].productName
        return cell
    }
    func getDetailCollectionViewCell(indexPath: IndexPath)-> UICollectionViewCell{
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.detailsCollectionViewCell, for: indexPath) as! DetailsCollectionViewCell
        self.lblTitle.text = title
        
        cell.imgView.image = category[indexPath.row].FoodImage
        cell.lblProductName.text = category[indexPath.row].productName
        cell.lblOriginalPrice.text = String(describing: "\u{20B9}" + category[indexPath.row].originalPrice!)
        cell.btnLike.tintColor = .systemRed
        cell.btnLike.setImage(category[indexPath.row].isLike == true ? UIImage(named: "like") : UIImage(named: "unlike") , for: .normal)
        cell.actionBlock = { [self] in
            self.category[indexPath.row].isLike = !self.category[indexPath.row].isLike!
            self.categoryCollectionView.reloadData()
        }
        cell.lblpromoted.isHidden = !category[indexPath.row].isPromoted!
    
    
    
        cell.lblOfferDetail.text = category[indexPath.row].offerDetail
        cell.lblDurationOfDelivery.text = category[indexPath.row].DurationOfDelivery
        
        cell.lblInfo.text = category[indexPath.row].info
        cell.imgOrderRatioView.isHidden = !category[indexPath.row].isOrderRatio!
        cell.lblOrderPlacedInfo.text = category[indexPath.row].orderPlacedInfo
        cell.imgEcoFriendlyView.isHidden = !category[indexPath.row].isEcoFriendly!
        cell.imgMaxSafetyView.isHidden = !category[indexPath.row].isMaxSafety!
        cell.imgSafetyMark.isHidden = !category[indexPath.row].isSafetyMark!
        
        let regularAttribute = [
              NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 18.0)!
           ]
        let regularText = NSAttributedString(string: category[indexPath.row].starRating!, attributes: regularAttribute)
        let starAttachment = NSTextAttachment()
        starAttachment.image = UIImage(named: "starrate")?.withTintColor(.black)
        starAttachment.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        let newString = NSMutableAttributedString()
        newString.append(NSAttributedString(attachment: starAttachment))
        newString.append(regularText)
        cell.lblStarRating.attributedText = newString
        return cell
    }
}
