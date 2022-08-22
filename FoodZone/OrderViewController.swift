//
//  ViewController.swift
//  FoodZone
//
//  Created by Devkrushna4 on 16/08/22.
//

import UIKit
import CoreLocation

class OrderViewController: UIViewController {

    @IBOutlet weak var navigationView: UIView!
    
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var foodContainerTableView: UITableView!
    @IBOutlet weak var customeTableContainerView: UIView!
    @IBOutlet weak var optionsCollectionView: UICollectionView!
    @IBOutlet weak var imgCutieryView: UIImageView!
    
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var btnKnowMore: UIButton!
    @IBOutlet weak var imgCard1: UIImageView!
    @IBOutlet weak var imgCard2: UIImageView!
    
    
    @IBOutlet weak var searchResultContainerView: UIView!
    @IBOutlet weak var btnDelivery: UIButton!
    @IBOutlet weak var btnDining: UIButton!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    
    var location = CLLocation()
    var locationManager = CLLocationManager()
    var cellTitle = ["Order again","Eat what makes you happy", "909 restaurants around you"]
    var optionTitle = ["(1)","MAXSafety","PRO","Cusine"]
    var images = ["like","","pro","arrow_down"]
    var foodDetails = [FoodData]()
    var filterData = [FoodData]()
    var isSearch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationPermission()
        self.initializeObject()
        self.setUpUI()
        self.registerTableView()
        self.registerCollectionViewCell()
        // Do any additional setup after loading the view.
    }
    
    func setUpUI(){
        
        self.navigationView.frame.size.height = MYdevice.topAnchor + 95
        self.mainContainerView.frame.origin.y = self.navigationView.frame.maxY + 20
        self.searchResultContainerView.frame.origin.y = self.navigationView.frame.maxY + 20
        self.mySearchBar.addShadowWithCorner()
        self.mySearchBar.tintColor = .red
        
        self.btnProfile.setCornerRadius(value: btnProfile.frame.height / 2)
        self.imgCutieryView.setCornerRadius(value: imgCutieryView.frame.height / 2)
        self.imgCard1.setCornerRadius(value:imgCard1.frame.height / 7)
        self.imgCard2.setCornerRadius(value: imgCard2.frame.height / 7)
        
        self.btnKnowMore.sizeToFit()
        self.mySearchBar.delegate = self
        self.filterData = foodDetails
        
        
        self.searchResultContainerView.isHidden = true
        self.btnDelivery.setCornerRadius(value: imgCard2.frame.height / 7)
        self.btnDelivery.backgroundColor = .black
        self.btnDelivery.tintColor = .white
        self.btnDining.setCornerRadius(value: imgCard2.frame.height / 7)
        self.btnDining.backgroundColor = .white
        self.btnDining.tintColor = .black
        
        self.addDoneButtonOnKeyboard()
        
    }
    
    
    func registerTableView(){
        self.foodContainerTableView.register(UINib(nibName: CellIdentifier.categoryTableViewCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.categoryTableViewCell)
        self.foodContainerTableView.delegate = self
        self.foodContainerTableView.dataSource = self
        
        self.searchResultTableView.register(UINib(nibName: CellIdentifier.searchTableViewCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.searchTableViewCell)
        self.searchResultTableView.delegate = self
        self.searchResultTableView.dataSource = self
    }
    
    func registerCollectionViewCell(){
        self.optionsCollectionView.register(UINib(nibName: CellIdentifier.titleCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.titleCollectionViewCell)
        self.optionsCollectionView.delegate = self
        self.optionsCollectionView.dataSource = self
    }
    
    func initializeObject(){
        foodDetails = [FoodData.init(FoodImage: UIImage(named: "1"), isPromoted: true, isLike: true, offerDetail: "40% off upto \("\u{20B9}")300", DurationOfDelivery: "50 mins or FREE", productName: "Chicken", info: "North Indian, Continental", starRating: "4.5", originalPrice:  "\("\u{20B9}")400 for one", isOrderRatio: true, orderPlacedInfo: "275+ OrderPlaces from here recently", isEcoFriendly: false, isMaxSafety: true, isSafetyMark: false),
                       FoodData.init(FoodImage: UIImage(named: "2"), isPromoted: true, isLike: true, offerDetail: "10% off upto \("\u{20B9}")600", DurationOfDelivery: "30 mins or FREE", productName: "Chicken Masala", info: "North Indian, Continental", starRating: "2.6", originalPrice: "\("\u{20B9}")250 for one", isOrderRatio: true, orderPlacedInfo: "2530+ OrderPlaces from here recently", isEcoFriendly: false, isMaxSafety: true, isSafetyMark: false),
                       FoodData.init(FoodImage: UIImage(named: "3"), isPromoted: true, isLike: true, offerDetail: "5% off upto \("\u{20B9}")60", DurationOfDelivery: "35 mins or FREE", productName: "Gujatrati Thali", info: "Gujarati Cusine, Healthy", starRating: "4.9", originalPrice: "\("\u{20B9}")150 for one", isOrderRatio: true, orderPlacedInfo: "150+ OrderPlaces from here recently", isEcoFriendly: false, isMaxSafety: true, isSafetyMark: false),
                       FoodData.init(FoodImage: UIImage(named: "4"), isPromoted: true, isLike: true, offerDetail: "25% off upto \("\u{20B9}")800", DurationOfDelivery: "15 mins or FREE", productName: "Samosa", info: "Beverages, Cafe", starRating: "3.5", originalPrice: "\("\u{20B9}")50 for one", isOrderRatio: true, orderPlacedInfo: "6523+ OrderPlaces from here recently", isEcoFriendly: false, isMaxSafety: true, isSafetyMark: false),
                       FoodData.init(FoodImage: UIImage(named: "5"), isPromoted: true, isLike: true, offerDetail: "50% off upto \("\u{20B9}")900", DurationOfDelivery: "10 mins or FREE", productName: "Ice-Cream", info: "Beverages, Cafe, Continental", starRating: "4.0", originalPrice: "\("\u{20B9}")100 for one", isOrderRatio: true, orderPlacedInfo: "275+ OrderPlaces from here recently", isEcoFriendly: false, isMaxSafety: true, isSafetyMark: false),
                       FoodData.init(FoodImage: UIImage(named: "6"), isPromoted: true, isLike: true, offerDetail: "9% off upto \("\u{20B9}")360", DurationOfDelivery: "45 mins or FREE", productName: "Masala Dhosa", info: "South Indian", starRating: "5.0", originalPrice: "\("\u{20B9}")210 for one", isOrderRatio: true, orderPlacedInfo: "356+ OrderPlaces from here recently", isEcoFriendly: false, isMaxSafety: true, isSafetyMark: false),
                       FoodData.init(FoodImage: UIImage(named: "7"), isPromoted: true, isLike: true, offerDetail: "30% off upto \("\u{20B9}")599", DurationOfDelivery: "60 mins or FREE", productName: "Paneer Sizzler", info: "Continental", starRating: "2.5", originalPrice: "\("\u{20B9}")800 for one", isOrderRatio: true, orderPlacedInfo: "856+ OrderPlaces from here recently", isEcoFriendly: false, isMaxSafety: true, isSafetyMark: false)]
    }
    
    private func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        doneToolbar.items = [flexSpace, done]
        doneToolbar.sizeToFit()
            
        self.mySearchBar.inputAccessoryView = doneToolbar
    }
       
    @objc func doneButtonAction(){
       self.mySearchBar.resignFirstResponder()
    }
    
    @IBAction func btnDeliverySelected(_ sender: UIButton) {
        btnDining.backgroundColor = .white
        btnDining.tintColor = .black
        btnDelivery.backgroundColor = .black
        btnDelivery.tintColor = .white
    }
    
    @IBAction func btnDiningSelected(_ sender: UIButton) {
        btnDelivery.backgroundColor = .white
        btnDelivery.tintColor = .black
        btnDining.backgroundColor = .black
        btnDining.tintColor = .white
    }
}
extension OrderViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.isSearch = true
        for i in 0...2{
            if searchText.isEmpty{
                self.filterData = self.foodDetails
            }else{
                self.filterData = self.foodDetails.filter { (item: FoodData) -> Bool in
                    // If dataItem matches the searchText, return true to include it
                    return i != 0 ? item.productName!.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil : item.info!.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
                }
            }
        }
        self.searchResultTableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchResultContainerView.isHidden = false
        self.mainContainerView.isHidden = true
        self.mySearchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.filterData = foodDetails
        self.isSearch = false
        self.searchResultContainerView.isHidden = true
        self.mainContainerView.isHidden = false
        
    }
}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  isSearch ? filterData.count : 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isSearch {
            let cell = searchResultTableView.dequeueReusableCell(withIdentifier: CellIdentifier.searchTableViewCell, for: indexPath) as! SearchTableViewCell
            cell.lblTitle.text = filterData[indexPath.row].productName
            cell.lblAddress.text = filterData[indexPath.row].offerDetail
            cell.isAvailable.isHidden = true
            cell.imageView?.image = filterData[indexPath.row].FoodImage
            if indexPath.row == 4{
                cell.isAvailable.isHidden = false
            }
            return cell
        
        }else{
//            if indexPath.row != 2{
                let cell = self.foodContainerTableView.dequeueReusableCell(withIdentifier: CellIdentifier.categoryTableViewCell, for: indexPath) as! CategoryTableViewCell
                cell.title = cellTitle[indexPath.row]
                cell.index = indexPath.row
                var data = [FoodData]()
                switch(indexPath.row){
                case 0:
                    data.append(foodDetails[0])
                    data.append(foodDetails[1])
                    data.append(foodDetails[2])
                case 1:
                    data = foodDetails
                    data.removeLast(2)
                case 2:
                    data = foodDetails
                default: break
                }
                cell.setUpCollectionView(data: data)
                return cell
//            }else{
//                let cell = self.foodContainerTableView.dequeueReusableCell(withIdentifier: CellIdentifier.detailedCategoryTableViewCell, for: indexPath) as! DetailedCategoryTableViewCell
//                cell.title = cellTitle[indexPath.row]
//                cell.index = indexPath.row
//                cell.setUpCollectionView(data: foodDetails)
//                return cell
//            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if isSearch {
            return 70
        } else {
           
            switch indexPath.row{
            case 0: return 250
            case 1: return 250
            case 2: return CGFloat(foodDetails.count * 250)
            default: return 0
            }
        }
    }
    
}

extension OrderViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.titleCollectionViewCell, for: indexPath) as! TitleCollectionViewCell
      
        cell.lblTitle.text = optionTitle[indexPath.row]
        if images[indexPath.row] == ""{
            cell.imgView.isHidden = true
            cell.lblTitle.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width - cell.imgView.frame.width, height: cell.frame.size.height)
        }else{
            cell.imgView.isHidden = false
            cell.imgView.image = UIImage(named: images[indexPath.row])
            cell.lblTitle.frame = CGRect(x: cell.imgView.frame.maxX + 5, y: 0, width: cell.frame.size.width - cell.imgView.frame.width, height: cell.frame.size.height)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 4 - 20, height: 30)
    }
    
}
extension OrderViewController: CLLocationManagerDelegate{
    
    private func locationPermission(){
         if CLLocationManager.locationServicesEnabled() {
             let locationManager = CLLocationManager()
             locationManager.delegate = self

             // Request a user’s location once
             locationManager.requestLocation()
             locationManager.distanceFilter = kCLDistanceFilterNone
             locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
         }else{
             let alert = UIAlertController(title: "Please Enable Location", message: "", preferredStyle: .alert)
             
             alert.addAction(UIAlertAction(title: "Setting", style: .cancel, handler: { UIAlertAction in
                
                 UIApplication.shared.open(URL(string: "App-Prefs:Privacy")!)

             }))
             
             alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { UIAlertAction in
                 
             }))
             
             DispatchQueue.main.async {
                 self.present(alert, animated: true, completion: nil)
             }
         }
        
        

     }
    func locationManager( _ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        // Handle failure to get a user’s location
    }
    
    func locationManager( _ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.lblLocation.text = location.accessibilityValue
            // Handle location update
        }
    }
}
