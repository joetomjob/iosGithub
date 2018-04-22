  //
//  ListingDetailVC.swift
//  FinalProjectNew
//
//  Created by Joe Tom Job  on 4/9/18.
//  Copyright © 2018 Joe Tom Job . All rights reserved.
//

import UIKit
import ImageSlideshow
import CoreLocation
import MapKit
import Contacts

protocol ZoomingProtocol {
    func zoomOn(annotation:MKAnnotation)
}
class ListingDetailVC: UITableViewController, MKMapViewDelegate, CLLocationManagerDelegate, ZoomingProtocol {
    
    var locationManager:CLLocationManager?
    var location : CLLocation?
    var geodocoder = CLGeocoder()
    var placemark:CLLocation?
    let point = MKPointAnnotation()
    var listing = Listing()
    var coords: CLLocationCoordinate2D!
    var addressDict : [String:String]!
    
    let IMAGE           = 0
    let NAME            = 1
    let PLACE           = 2
    let RATE            = 3
    let TYPE            = 4
    let ZIP             = 5
    let DESCRIPTION     = 6
    let USER            = 7
    let BED             = 8
    let BATH            = 9
    let AREA            = 10
    let FURNISHED       = 11
    let WAHSERDRYER     = 12
    let DISHWASHER      = 13
    let FOODPREFERENCE  = 14
    let MULTIFAMILY     = 15
    let OVEN            = 16
    let PETFRIENDLY     = 17
    
//    @IBOutlet weak var listingImage: UIView!
    
    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var listingName: UITableViewCell!
    @IBOutlet weak var listingPlace: UITableViewCell!
    @IBOutlet weak var listingRate: UITableViewCell!
    @IBOutlet weak var listingType: UITableViewCell!
    @IBOutlet weak var listingZip: UITableViewCell!
    @IBOutlet weak var listingDescription: UITableViewCell!
    @IBOutlet weak var listingUser: UITableViewCell!
    @IBOutlet weak var listingBed: UITableViewCell!
    @IBOutlet weak var listingBath: UITableViewCell!
    @IBOutlet weak var listingArea: UITableViewCell!
    @IBOutlet weak var listingFurnished: UITableViewCell!
    @IBOutlet weak var listingWasherDryer: UITableViewCell!
    @IBOutlet weak var listingDishWasher: UITableViewCell!
    @IBOutlet weak var listingFoodPreference: UITableViewCell!
    @IBOutlet weak var listingMultiFamily: UITableViewCell!
    @IBOutlet weak var listingOven: UITableViewCell!
    @IBOutlet weak var listingPetFriendly: UITableViewCell!
    @IBOutlet weak var mapView: MKMapView!
    //    @IBOutlet weak var slideShow: ImageSlideshow!
    
    func zoomOn(annotation: MKAnnotation){
        tabBarController?.selectedViewController = self
        let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 250, 250)
        mapView.setRegion(region, animated: true)
        mapView.selectAnnotation(annotation, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        locationManager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager!.requestWhenInUseAuthorization()
        }
        super.init(coder : aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideShow.setImageInputs([
            AlamofireSource(urlString: listing.getImageName())!,
            AlamofireSource(urlString: "https://images.unsplash.com/photo-1432679963831-2dab49187847?w=1080")!,
            AlamofireSource(urlString: listing.getImageName())!
            ])
        
        listingName.textLabel?.text = "Name"
        listingName.textLabel?.font = UIFont(name: "Arial", size: 1)
        listingName.detailTextLabel?.text = listing.getName()
        listingName.detailTextLabel?.font = UIFont(name: "Arial", size: 17)
        listingPlace.textLabel?.text = "Place"
        listingPlace.textLabel?.font = UIFont(name: "Arial", size: 11)
        listingPlace.detailTextLabel?.text = listing.getPlace()
        listingPlace.detailTextLabel?.font = UIFont(name: "Arial", size: 17)
        listingRate.textLabel?.text = "Rate"
        listingRate.textLabel?.font = UIFont(name: "Arial", size: 11)
        listingRate.detailTextLabel?.text = listing.getRate()
        listingRate.detailTextLabel?.font = UIFont(name: "Arial", size: 17)
        listingType.textLabel?.text = "Type"
        listingType.textLabel?.font = UIFont(name: "Arial", size: 11)
        listingType.detailTextLabel?.text = listing.getType()
        listingType.detailTextLabel?.font = UIFont(name: "Arial", size: 17)
        listingZip.textLabel?.text = "ZipCode"
        listingZip.textLabel?.font = UIFont(name: "Arial", size: 11)
        listingZip.detailTextLabel?.text = listing.getZipCode()
        listingZip.detailTextLabel?.font = UIFont(name: "Arial", size: 17)
        listingDescription.textLabel?.text = "Description"
        listingDescription.textLabel?.font = UIFont(name: "Arial", size: 11)
        listingDescription.detailTextLabel?.text = listing.getHouseDescription()
        listingDescription.detailTextLabel?.font = UIFont(name: "Arial", size: 17)
        listingDescription.detailTextLabel?.numberOfLines = 6
        listingUser.textLabel?.text = "User"
        listingUser.textLabel?.font = UIFont(name: "Arial", size: 11)
        listingUser.detailTextLabel?.text = listing.getUser()
        listingUser.detailTextLabel?.font = UIFont(name: "Arial", size: 17)
        listingBed.textLabel?.text = "Bed"
        listingBed.textLabel?.font = UIFont(name: "Arial", size: 11)
        listingBed.detailTextLabel?.text = listing.getBed()
        listingBed.detailTextLabel?.font = UIFont(name: "Arial", size: 17)
        listingBath.textLabel?.text = "Bath"
        listingBath.textLabel?.font = UIFont(name: "Arial", size: 11)
        listingBath.detailTextLabel?.text = listing.getBath()
        listingBath.detailTextLabel?.font = UIFont(name: "Arial", size: 17)
        listingArea.textLabel?.text = "Area"
        listingArea.textLabel?.font = UIFont(name: "Arial", size: 11)
        listingArea.detailTextLabel?.text = listing.getArea()
        listingArea.detailTextLabel?.font = UIFont(name: "Arial", size: 17)
        listingFurnished.textLabel?.text = "Furnished"
        listingFurnished.textLabel?.font = UIFont(name: "Arial", size: 11)
        listingFurnished.detailTextLabel?.text = listing.getFurnished()
        listingFurnished.detailTextLabel?.font = UIFont(name: "Arial", size: 17)
        listingWasherDryer.textLabel?.text = "Washer/Dryer"
        listingWasherDryer.textLabel?.font = UIFont(name: "Arial", size: 11)
        listingWasherDryer.detailTextLabel?.text = listing.getWasherDryer()
        listingWasherDryer.detailTextLabel?.font = UIFont(name: "Arial", size: 17)
        listingDishWasher.textLabel?.text = "Dishwasher"
        listingDishWasher.textLabel?.font = UIFont(name: "Arial", size: 11)
        listingDishWasher.detailTextLabel?.text = listing.getDishwasher()
        listingDishWasher.detailTextLabel?.font = UIFont(name: "Arial", size: 17)
        listingFoodPreference.textLabel?.text = "Food Preference"
        listingFoodPreference.textLabel?.font = UIFont(name: "Arial", size: 11)
        listingFoodPreference.detailTextLabel?.text = listing.getFoodPreference()
        listingFoodPreference.detailTextLabel?.font = UIFont(name: "Arial", size: 17)
        listingMultiFamily.textLabel?.text = "MultiFamily"
        listingMultiFamily.textLabel?.font = UIFont(name: "Arial", size: 11)
        listingMultiFamily.detailTextLabel?.text = listing.getMultifamily()
        listingMultiFamily.detailTextLabel?.font = UIFont(name: "Arial", size: 17)
        listingOven.textLabel?.text = "Oven"
        listingOven.textLabel?.font = UIFont(name: "Arial", size: 11)
        listingOven.detailTextLabel?.text = listing.getOven()
        listingOven.detailTextLabel?.font = UIFont(name: "Arial", size: 17)
        listingPetFriendly.textLabel?.text = "Pet Friendly"
        listingPetFriendly.textLabel?.font = UIFont(name: "Arial", size: 11)
        listingPetFriendly.detailTextLabel?.text = listing.getPetFriendly()
        listingPetFriendly.detailTextLabel?.font = UIFont(name: "Arial", size: 17)
        
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager?.requestAlwaysAuthorization()
        }
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()
        locationManager?.delegate = self
        
        mapView.delegate = self
        
        let mkCoordinateRegion =
            MKCoordinateRegionMakeWithDistance((listing.getLocation()?.coordinate)!,500,500)
        mapView.setRegion(mkCoordinateRegion, animated: true)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mapView.addAnnotation(listing)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 19
    }
    
    func showMap(){

        let place = MKPlacemark(coordinate: coords, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: place)
        let options = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: options)
        
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let point = MKPointAnnotation()
        point.coordinate = userLocation.coordinate
        mapView.addAnnotation(point)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view: MKPinAnnotationView
        let identifier = "Pin"
        
        if annotation is MKUserLocation {
            //if annotation is not an MKPointAnnotation (eg. MKUserLocation),
            //return nil so map draws default view for it (eg. blue dot)...
            return nil
        }
        if annotation !== mapView.userLocation   {
            //look for an existing view to reuse
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                //  view.pinColor = MKPinAnnotationColor.Purple
                view.pinTintColor = MKPinAnnotationView.purplePinColor()
                view.animatesDrop = true
                view.canShowCallout = true
                //view.calloutOffset = CGPoint(x: -5, y: 5)
                let leftButton = UIButton(type: .infoLight)
                let rightButton = UIButton(type: .detailDisclosure)
                leftButton.tag = 0
                rightButton.tag = 1
                view.leftCalloutAccessoryView = leftButton
                view.rightCalloutAccessoryView = rightButton
            }
            return view
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let listAnnotation = view.annotation as! Listing
        switch control.tag {
        case 0: //left button
//            if let url = URL(string: parkAnnotation.getLink()){
//                UIApplication.shared.open(url, options: [:], completionHandler: nil)                }
            print(1)
        case 1: //right button
            self.coords = listing.getLocation()?.coordinate//make sure location manager has updated before trying to use

            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(listing.getLocation()!,
                completionHandler: { (placemarks, error) in
                    if error == nil {
                        let firstLocation = placemarks?[0]
                        self.addressDict = [String(CNPostalAddressStreetKey):(firstLocation?.name)!, String(CNPostalAddressCityKey): (firstLocation?.postalAddress?.city)!, String(CNPostalAddressStateKey): (firstLocation?.postalAddress?.state)!, String(CNPostalAddressPostalCodeKey): (firstLocation?.postalAddress?.postalCode)!]
                        self.showMap()
                    }
            })

        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        print("\(String(describing:location))")
        
        //add the current location to the mapView
        point.coordinate = (location?.coordinate)!
        
        print("\(String(describing: location))")
        locationManager?.stopUpdatingLocation()
    }

    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 44.0
//    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: "ListingImageCell")
//        if(indexPath.row == 0){
//            cell!.isSelected = true
//        }
//        return cell!
//    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        var title = ""
//        return title
//
//    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
