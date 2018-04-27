//
//  myListingsTableVC.swift
//  FinalProjectNew
//
//  Created by Sikha Rani on 4/25/18.
//  Copyright © 2018 Joe Tom Job . All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import FirebaseDatabase
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

class myListingsTableVC: UITableViewController,CLLocationManagerDelegate {
    @IBOutlet var mtableV: UITableView!
   
    
    
    
    var locationManager:CLLocationManager?
    var location : CLLocation?
    var geodocoder = CLGeocoder()
    var placemark:CLLocation?
    let point = MKPointAnnotation()
    var distaceFromCurrentLocation: Double = 15.0
    var currentuser=String()
    var listingList = Listings()
    var listings : [Listing] { //front end for LandmarkList model object
        get {
            return self.listingList.listings
        }
        set(val) {
            self.listingList.listings = val
        }
    }
    
    var currids:[String] = []
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
        self.listingsNear = []
        loadData()
        
        self.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        self.listingsNear = []
//
//        loadData()
//        self.reloadData()
//    }
    
    func reloadData(){
        self.mtableV.reloadData()
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
        return listingsNear.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0;//Choose your custom row height
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:ListingCell = tableView.dequeueReusableCell(withIdentifier: "myListingCell", for: indexPath) as! ListingCell
        
        // Configure the cell...
        let listing = listingsNear[indexPath.row]
        cell.listingName.text = listing.getName()
        cell.listingPlace.text = listing.getPlace()
        cell.listingRate.text = listing.getRate()
        cell.listingImage?.downloadImageFrom(link: listing.getImageName(), contentMode: UIViewContentMode.scaleAspectFill)
        cell.accessoryType = .disclosureIndicator
        
        return cell
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
                        
                        let l = Listing(area: area, bath: bath, bed: bed, houseDescription: houseDescription, dishwasher: dishwasher, foodpreference: foodpreference, furnished: furnished, houseid: houseid, multifamily: multifamily, name: name, place: place, zipcode: zipcode, oven: oven, petfriendly: petfriendly, pic: "unknown", rate: rate, type: type, user: user, washerdryer: washerdryer, imageName: imageName, contact: contact, email: email)
                        
                    
                        if Auth.auth().currentUser != nil {
                            // User is signed in.
                            // ...
                            self.currentuser = (Auth.auth().currentUser?.email)! as String
                            // email.text=(Auth.auth().currentUser?.email)! as String
                        }
                        if(user==self.currentuser && !self.currids.contains(houseid)){
                            self.listingListNear.listings.append(l)
                            self.currids.append(houseid)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let indexPath = tableView.indexPathForSelectedRow
        let mylistingDetailVC  = segue.destination as! PostingVC
        let mylisting = listingsNear[indexPath!.row]
        mylistingDetailVC.title = mylisting.getName()
        mylistingDetailVC.mylisting = mylisting
        
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
   //  Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
         //    Delete the row from the data source
         //   tableView.deleteRows(at: [indexPath], with: .fade)
            let x =  listingsNear[indexPath.row].getId()
            let dref = Database.database().reference().child("Housing").child("Postings").child("\(x)")
//            let did=dref.value(forKey: "id")
            print(1)
            
            dref.removeValue()
            
          
           
            print("Deleted")
            
            self.listingsNear.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
           mtableV.reloadData()
          
            
        } else if editingStyle == .insert {
           //  Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
 

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item=listingsNear[fromIndexPath.row]
        listingsNear.remove(at: fromIndexPath.row)
       listingsNear.insert(item, at: destinationIndexPath.row)

    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
