//
//  ListingTableVC.swift
//  FinalProjectNew
//
//  Created by Joe Tom Job  on 4/8/18.
//  Copyright © 2018 Joe Tom Job . All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import CoreLocation
import MapKit

extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIViewContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}

class ListingTableVC: UITableViewController,CLLocationManagerDelegate {
    
    @IBOutlet var tableV: UITableView!
    
    var locationManager:CLLocationManager?
    var location : CLLocation?
    var geodocoder = CLGeocoder()
    var placemark:CLLocation?
    let point = MKPointAnnotation()
    var distaceFromCurrentLocation: Double = 15.0
    
    var listingList = Listings()
    var listings : [Listing] { //front end for LandmarkList model object
        get {
            return self.listingList.listings
        }
        set(val) {
            self.listingList.listings = val
        }
    }
    
    var listingListNear = Listings()
    var listingsNear : [Listing] { //front end for LandmarkList model object
        get {
            return self.listingListNear.listings
        }
        set(val) {
            self.listingListNear.listings = val
        }
    }
    
    var ref : DatabaseReference!
    var databaseHandle: DatabaseHandle?
    var coords: CLLocationCoordinate2D!
    var addressDict : [String:String]!
    var cllocationoflisting: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager?.requestAlwaysAuthorization()
        }
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()
        locationManager?.delegate = self
        
        loadData()
        
//        for listing in listingList.listings {
//            if listing.getDistance() < distaceFromCurrentLocation{
//                self.listingsNear.append(listing)
//            }
//        }
    
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func reloadData(){
        self.tableV.reloadData()
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
        
        return listings.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 88.0;//Choose your custom row height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:ListingCell = tableView.dequeueReusableCell(withIdentifier: "ListingCell", for: indexPath) as! ListingCell

        // Configure the cell...
        let listing = listings[indexPath.row]
        cell.listingName.text = listing.getName()
        cell.listingPlace.text = listing.getPlace()
        cell.listingRate.text = listing.getRate()
        cell.listingImage?.downloadImageFrom(link: listing.getImageName(), contentMode: UIViewContentMode.scaleAspectFill)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listing = listings[indexPath.row]
        let detailVC = ListingDetailVC(style: .grouped)
        detailVC.title = listing.title
        detailVC.listing = listing
//        detailVC.delegate = mapVC
        navigationController?.pushViewController(detailVC, animated: true)
    }*/
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let indexPath = tableView.indexPathForSelectedRow
        let listingDetailVC  = segue.destination as! ListingDetailVC
        let listing = listings[indexPath!.row]
        listingDetailVC.title = listing.getName()
        listingDetailVC.listing = listing
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        locationManager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager!.requestWhenInUseAuthorization()
        }
        super.init(coder : aDecoder)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        print("\(String(describing:location))")
        
        //add the current location to the mapView
        point.coordinate = (location?.coordinate)!
        
        print("\(String(describing: location))")
        locationManager?.stopUpdatingLocation()

    }
    
    func loadData() {
        do{
            ref =  Database.database().reference().child("Housing").child("Postings")
            
            ref.observe(DataEventType.value, with: {(snapshot) in
                if snapshot.childrenCount > 0{
                    for listgns in snapshot.children.allObjects as! [DataSnapshot]{
                        let lstngObject = listgns.value as? [String: AnyObject]
                        
                        let area = lstngObject?["Area"] as! String
                        let bath = lstngObject?["Bath"] as! String
                        let bed = lstngObject?["Bed"] as! String
                        let houseDescription = lstngObject?["description"] as! String
                        let dishwasher = lstngObject?["dishwasher"] as! String
                        let foodpreference = lstngObject?["foodpreference"] as! String
                        let furnished = lstngObject?["furnished"] as! String
                        let houseid = lstngObject?["id"] as! String
                        let multifamily = lstngObject?["multifamily"] as! String
                        let name = lstngObject?["name"] as! String
                        let place = lstngObject?["place"] as! String
                        let zipcode = lstngObject?["zip"] as! String
                        let oven = lstngObject?["oven"] as! String
                        let petfriendly = lstngObject?["petfriendly"] as! String
                        let pic = lstngObject?["pic"] as! String
                        let rate = lstngObject?["rate"] as! String
                        let type = lstngObject?["type"]as! String
                        let user = lstngObject?["user"] as! String
                        let washerdryer = lstngObject?["washerdryer"] as! String
                        let imageName = lstngObject?["imageName"] as! String
                        let contact = lstngObject?["contact"] as! String
                        let email = lstngObject?["email"] as! String
                        
                        let geocoder = CLGeocoder()
                        let fullNameArr = place.components(separatedBy: ",")
                        let addressString = "\(name)\(fullNameArr[0])\(zipcode)"
                        
                        let l = Listing(area: area, bath: bath, bed: bed, houseDescription: houseDescription, dishwasher: dishwasher, foodpreference: foodpreference, furnished: furnished, houseid: houseid, multifamily: multifamily, name: name, place: place, zipcode: zipcode, oven: oven, petfriendly: petfriendly, pic: pic, rate: rate, type: type, user: user, washerdryer: washerdryer, imageName: imageName, contact: contact, email: email)
                        
                        geocoder.geocodeAddressString(addressString) { (placemarks:[CLPlacemark]?, error:Error?) in
                            if let placemark = placemarks?[0]{
                                if let location = placemark.location{
                                    self.coords = location.coordinate //we need to use self because we are in a completion handler
                                    self.cllocationoflisting =  CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//                                    setLocation(location: self.cllocationoflisting)
                                    l.setLocation(location: self.cllocationoflisting)
                                    
                                    let distanceInMeters = self.location?.distance(from: l.getLocation()!)
                                    let distanceInMiles = distanceInMeters! * 0.00062137
                                    l.setDistance(distance: distanceInMiles)
                                    
                                    if(distanceInMiles < self.distaceFromCurrentLocation){
                                        self.listingListNear.listings.append(l)
                                    }
                                    //                    self.showMap()
                                }
                            }
                        }
                        
                        
                        self.listingList.listings.append(l)
                    }
//                    self.tableVC!.listingList.listings = self.listOfListings
//                    self.tableVC!.tableV.reloadData()
                    self.reloadData()
                }
            })
            
        }
        catch{
            print(error)
        }
    }

}
