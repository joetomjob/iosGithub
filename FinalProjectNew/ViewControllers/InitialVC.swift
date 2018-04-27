//
//  InitialVC.swift
//  FinalProjectNew
//
//  Created by Joe Tom Job  on 4/6/18.
//  Copyright © 2018 Joe Tom Job . All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseDatabase
import Firebase
import MapKit

class InitialVC: UIViewController, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var location : CLLocation?
    
    var geodocoder = CLGeocoder()
    var placemark:CLLocation?
    var coords: CLLocationCoordinate2D!
    var addressDict : [String:String]!
    var cllocationoflisting: CLLocation!
    let point = MKPointAnnotation()
    
    var max = MAXFLOAT
    
    var universityList = Universities()
    var universities : [University] { //front end for LandmarkList model object
        get {
            return self.universityList.universities
        }
        set(val) {
            self.universityList.universities = val
        }
    }
    
    var ref : DatabaseReference!

    var postData = [String]()
    var databaseHandle: DatabaseHandle?
    
    @IBOutlet weak var countrytext: UITextField!
    @IBOutlet weak var universitytext: UITextField!
    
    required init?(coder aDecoder: NSCoder) {
        locationManager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.requestWhenInUseAuthorization()
        }
        super.init(coder : aDecoder)
    }
    
    @IBAction func Search(_ sender: Any) {
        self.tabBarController?.selectedIndex = 2;
//        self.performSegue(withIdentifier: "ListngSugue", sender: nil)
    }
    @IBAction func logout(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ref =  Database.database().reference()
        
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.delegate = self  //send them who the delegate is
        
        loadData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        print("\(String(describing:location))")
        locationManager.stopUpdatingLocation()
        geodocoder.reverseGeocodeLocation(location!, completionHandler: {(placemarks,error)->
            Void in
            print(self.location)
            if error != nil{
                print("Reverse geocoding failed: "+error!.localizedDescription)
                return
            }
            if placemarks!.count > 0 {
                let pm = placemarks!.last
                self.countrytext.text = pm!.country
            }
            else{
                print("Problem with data received from geocoder")
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let errorAlert = UIAlertController(title: "Error", message: "Failed to get your location!", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil )
        errorAlert.addAction(OKAction)
        present(errorAlert, animated: true, completion: nil)
    }

//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        let errorAlert = UIAlertController(title: "Error", message: "Failed to get your location!", preferredStyle: .alert)
//
//        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil )
//        errorAlert.addAction(OKAction)
//        present(errorAlert, animated: true, completion: nil)
//    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) { //methid called when authorization status is changed
        switch(status) {
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        case .authorizedWhenInUse, .restricted, .denied:
            
            let alertController = UIAlertController(title: "Background Location Access Denied", message: "In order to keep updating your location, please open settings and set location access to always.", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let openAction = UIAlertAction(title: "Open Settings", style: .default)
            {(action) in
                if let url = URL(string: UIApplicationOpenSettingsURLString){
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            alertController.addAction(openAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func loadData() {
        do{
            ref =  Database.database().reference().child("Universities")
            
            ref.observe(DataEventType.value, with: {(snapshot) in
                if snapshot.childrenCount > 0{
                    for listgns in snapshot.children.allObjects as! [DataSnapshot]{
                        let lstngObject = listgns.value as? [String: AnyObject]
                        
                        let Id = lstngObject?["id"] as! String
                        let Name = lstngObject?["Name"] as! String
                        let State = lstngObject?["State"] as! String
                        let City = lstngObject?["city"] as! String
                        let Street = lstngObject?["street"] as! String
                        let ZipCode = lstngObject?["zipcode"] as! String

                        
                        let geocoder = CLGeocoder()
//                        let fullNameArr = place.components(separatedBy: ",")
                        let addressString = "\(Name)\(Street)\(ZipCode)"
                        
                        let l = University(Id: Id, Name: Name, State: State, City: City, Street: Street, ZipCode: ZipCode)
                        
                        geocoder.geocodeAddressString(addressString) { (placemarks:[CLPlacemark]?, error:Error?) in
                            if let placemark = placemarks?[0]{
                                if let location = placemark.location{
                                    self.coords = location.coordinate //we need to use self because we are in a completion handler
                                    self.cllocationoflisting =  CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                                    //                                    setLocation(location: self.cllocationoflisting)
                                    l.setLocation(location: self.cllocationoflisting)
                                    
                                    let distanceInMeters = self.location?.distance(from: l.getLocation()!)
                                    let distanceInMiles = distanceInMeters! * 0.00062137
                                    l.setDistance(Distance: distanceInMiles)
                                    
                                    if Float(distanceInMiles) < self.max{
                                        self.universitytext.text = l.getName()
                                        self.max = Float(distanceInMiles)
                                    }
                                    
                                    //                    self.showMap()
                                }
                            }
                        }
                        self.universityList.universities.append(l)
                    }
                    self.reloadData()
                }
            })

        }
        catch{
            print(error)
        }
    }
    
    func reloadData(){
        
    }

}
