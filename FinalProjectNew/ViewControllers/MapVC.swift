//
//  MapVC.swift
//  FinalProjectNew
//
//  Created by Joe Tom Job  on 4/22/18.
//  Copyright © 2018 Joe Tom Job . All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Contacts

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, ZoomingProtocol {
    
    
    var locationManager:CLLocationManager?
    var location : CLLocation?
    var geodocoder = CLGeocoder()
    var placemark:CLLocation?
    let point = MKPointAnnotation()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var mysegmentedControl : UISegmentedControl!
    
    var listingList = Listings()
    var listings : [Listing] { //front end for LandmarkList model object
        get {
            return self.listingList.listings
        }
        set(val) {
            self.listingList.listings = val
        }
    }
    
    var coords: CLLocationCoordinate2D!
    var addressDict : [String:String]!
    
    required init?(coder aDecoder: NSCoder) {
        locationManager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager!.requestWhenInUseAuthorization()
        }
        super.init(coder : aDecoder)
    }
    
    @IBAction func indexChanged(sender : UISegmentedControl) {
        // This all works fine and it prints out the value of 3 on any click
        
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = MKMapType.standard
        case 1:
            mapView.mapType = MKMapType.satellite
        default:
            break;
        }  //Switch
    } // indexChanged for the Segmented Control
    
    func zoomOn(annotation: MKAnnotation) {
        tabBarController?.selectedViewController = self
        let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 250, 250)
        mapView.setRegion(region, animated: true)
        mapView.selectAnnotation(annotation, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        let parkAnnotation = view.annotation as! Listing
        switch control.tag {
            case 0: //left button
                print(1)
            case 1: //right button
                self.coords = parkAnnotation.getLocation()?.coordinate//make sure location manager has updated before trying to use
                
                let geocoder = CLGeocoder()
                geocoder.reverseGeocodeLocation(parkAnnotation.getLocation()!,
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
    
    //MARK:- Location manager delegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        print("\(String(describing:location))")
        
        //add the current location to the mapView
        point.coordinate = (location?.coordinate)!
        
        print("\(String(describing: location))")
        locationManager?.stopUpdatingLocation()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func showMap(){
        let place = MKPlacemark(coordinate: coords, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: place)
        let options = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: options)
        
    }

}
