//
//  University.swift
//  FinalProjectNew
//
//  Created by Joe Tom Job  on 4/23/18.
//  Copyright © 2018 Joe Tom Job . All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class University: NSObject, MKAnnotation {
    
    var location : CLLocation?
    //needed for the MKAnnotation protocol
    var coordinate: CLLocationCoordinate2D {
        get {
            return location!.coordinate
        }
    }
    
    private var Id : String = ""
    private var Name : String = ""
    private var State : String = ""
    private var City : String = ""
    private var Street : String = ""
    private var ZipCode : String = ""
    private var Distance : Double = 0.0
    
    var title : String? {
        get {
            return Name;
        }
    }
    
    var subtitle : String? {
        get {
            return Name;
        }
    }
    
    override var description: String{
        return """
        {
        Id: \(Id)
        Name: \(Name)
        State: \(State)
        City: \(City)
        Street: \(Street)
        ZipCode: \(ZipCode)
        }
        """
    }
    
    init(Id: String, Name: String, State: String, City: String, Street: String, ZipCode: String){
        super.init()
        self.set(id: Id)
        self.setName(Name: Name)
        self.setState(State: State)
        self.setCity(City: City)
        self.setStreet(Street: Street)
        self.setZipCode(ZipCode: ZipCode)
        
        
    }
    
    override convenience init () {
        self.init(Id: "Unknown", Name: "Unknown", State: "Unknown", City: "Unknown", Street: "Unknown", ZipCode: "Unknown")
    }
    
    //getter and setter for ParkName
    func getId() -> String {
        return Id
    }
    func set(id: String) {
        Id = id
    }
    
    //getter and setter for Name
    func getName() -> String {
        return Name
    }
    func setName(Name: String){
        self.Name = Name;
    }
    
    //getter and setter for State
    func getState() -> String {
        return State
    }
    func setState(State: String){
        self.State = State
    }
    
    //getter and setter for City
    func getCity() -> String {
        return City
    }
    func setCity(City: String){
        self.City = City
    }
    
    //getter and setter for Street
    func getStreet() -> String {
        return Street
    }
    func setStreet(Street: String){
        self.Street = Street
    }
    
    //getter and setter for ZipCode
    func getZipCode() -> String {
        return Street
    }
    func setZipCode(ZipCode: String){
        self.ZipCode = ZipCode
    }
    
    //getter and setter for Distance
    func getDistance() -> Double {
        return Distance
    }
    func setDistance(Distance: Double){
        self.Distance = Distance
    }
    
    //getter and setter for Locations
    func getLocation() -> CLLocation? {
        return location
    }
    func setLocation(location: CLLocation?){
        self.location = location
    }

}
