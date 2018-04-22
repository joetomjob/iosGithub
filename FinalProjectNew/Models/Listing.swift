//
//  Listing.swift
//  FinalProjectNew
//
//  Created by Joe Tom Job  on 4/8/18.
//  Copyright © 2018 Joe Tom Job . All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class Listing: NSObject, MKAnnotation {
    
    var location : CLLocation?
    //needed for the MKAnnotation protocol
    var coordinate: CLLocationCoordinate2D {
        get {
            return location!.coordinate
        }
    }
    
    private var area : String = ""
    private var bath : String = ""
    private var bed : String = ""
    private var houseDescription : String = ""
    private var dishwasher : String = ""
    private var foodpreference : String = ""
    private var furnished : String = ""
    private var houseid : String = ""
    private var multifamily : String = ""
    private var name : String = ""
    private var place : String = ""
    private var zipcode : String = ""
    private var oven : String = ""
    private var petfriendly : String = ""
    private var pic : String = ""
    private var rate : String = ""
    private var type : String = ""
    private var user : String = ""
    private var washerdryer : String = ""
    private var imageName : String = ""
    private var contact : String = ""
    private var email : String = ""
    
    //optional - required with set callout true
    var title : String? {
        get {
            return name;
        }
    }
    
    var subtitle : String? {
        get {
            return name;
        }
    }
    
    override var description: String{
        return """
        {
        Area: \(area)
        bath: \(bath)
        bed: \(bed)
        houseDescription: \(houseDescription)
        dishwasher: \(dishwasher)
        foodpreference: \(foodpreference)
        furnished: \(furnished)
        id: \(houseid)
        multifamily: \(multifamily)
        name: \(name)
        place: \(place)
        zipcode: \(zipcode)
        oven: \(oven)
        petfriendly: \(petfriendly)
        pic: \(pic)
        rate: \(rate)
        type: \(type)
        user: \(user)
        washerdryer: \(washerdryer)
        imageName: \(imageName)
        contact: \(contact)
        email: \(email)
        }
        """
    }
    
    init(area: String, bath: String, bed: String, houseDescription: String, dishwasher: String, foodpreference: String, furnished: String, houseid: String, multifamily: String, name: String, place: String, zipcode: String, oven: String, petfriendly: String, pic: String, rate: String, type: String, user: String, washerdryer: String, imageName: String, contact: String, email: String){
        super.init()
        self.set(name: houseid)
        self.setArea(area: area)
        self.setBath(bath: bath)
        self.setBed(bed: bed)
        self.setHouseDescription(houseDescription: houseDescription)
        self.setDishwasher(dishwasher: dishwasher)
        self.setFoodPreference(foodpreference: foodpreference)
        self.setFurnished(furnished: furnished)
        self.setMultifamily(multifamily: multifamily)
        self.setName(name: name)
        self.setPlace(place: place)
        self.setZipCode(zipcode: zipcode)
        self.setOven(oven: oven)
        self.setPetFriendly(petfriendly: petfriendly)
        self.setPic(pic: pic)
        self.setRate(rate: rate)
        self.setType(type: type)
        self.setUser(user: user)
        self.setWasherDryer(washerdryer: washerdryer)
        self.setImageName(imageName: imageName)
        self.setContact(contact: contact)
        self.setEmail(email: email)
        
        
    }
    
    override convenience init () {
        self.init(area: "Unknown", bath: "Unknown", bed: "Unknown", houseDescription: "Unknown", dishwasher: "Unknown", foodpreference: "Unknown", furnished: "Unknown", houseid: "Unknown", multifamily: "Unknown", name: "Unknown", place: "Unknown", zipcode: "Unknown", oven: "Unknown", petfriendly: "Unknown", pic: "Unknown", rate: "Unknown", type: "Unknown", user: "Unknown", washerdryer: "Unknown", imageName: "Unknown", contact: "Unknown", email: "Unknown")
    }
    
    //getter and setter for ParkName
    func getId() -> String {
        return houseid
    }
    func set(name: String) {
        houseid = name
    }
    
    //getter and setter for Area
    func getArea() -> String {
        return area
    }
    func setArea(area: String){
        self.area = area;
    }
    
    //getter and setter for bath
    func getBath() -> String {
        return bath
    }
    func setBath(bath: String){
        self.bath = bath
    }
    
    //getter and setter for bed
    func getBed() -> String {
        return bed
    }
    func setBed(bed: String){
        self.bed = bed
    }

    //getter and setter for HouseDescription
    func getHouseDescription() -> String {
        return houseDescription
    }
    func setHouseDescription(houseDescription: String){
        self.houseDescription = houseDescription
    }
    
    //getter and setter for setDishwasher
    func getDishwasher() -> String? {
        return dishwasher
    }
    func setDishwasher(dishwasher: String){
        self.dishwasher = dishwasher
    }
    
    //getter and setter for FoodPreference
    func getFoodPreference() -> String {
        return foodpreference
    }
    func setFoodPreference(foodpreference: String){
        self.foodpreference = foodpreference
    }
    
    //getter and setter for Furnished
    func getFurnished() -> String {
        return furnished
    }
    func setFurnished(furnished: String){
        self.furnished = furnished
    }
    
    //getter and setter for setMultifamily
    func getMultifamily() -> String {
        return multifamily
    }
    func setMultifamily(multifamily: String){
        self.multifamily = multifamily
    }
    
    //getter and setter for Name
    func getName() -> String {
        return name
    }
    func setName(name: String){
        self.name = name
    }
    
    //getter and setter for Place
    func getPlace() -> String {
        return place
    }
    func setPlace(place: String){
        self.place = place
    }
    
    //getter and setter for ZipCode
    func getZipCode() -> String {
        return zipcode
    }
    func setZipCode(zipcode: String){
        self.zipcode = zipcode
    }
    
    //getter and setter for Oven
    func getOven() -> String {
        return oven
    }
    func setOven(oven: String){
        self.oven = oven
    }
    
    //getter and setter for PetFriendly
    func getPetFriendly() -> String {
        return petfriendly
    }
    func setPetFriendly(petfriendly: String){
        self.petfriendly = petfriendly
    }
    
    //getter and setter for Pic
    func getPic() -> String {
        return pic
    }
    func setPic(pic: String){
        self.pic = pic
    }
    
    //getter and setter for Rate
    func getRate() -> String {
        return rate
    }
    func setRate(rate: String){
        self.rate = rate
    }
    
    //getter and setter for Type
    func getType() -> String {
        return type
    }
    func setType(type: String){
        self.type = type
    }
    
    //getter and setter for User
    func getUser() -> String {
        return user
    }
    func setUser(user: String){
        self.user = user
    }
    
    //getter and setter for WasherDryer
    func getWasherDryer() -> String {
        return washerdryer
    }
    func setWasherDryer(washerdryer: String){
        self.washerdryer = washerdryer
    }
    
    //getter and setter for ImageName
    func getImageName() -> String {
        return imageName
    }
    func setImageName(imageName: String){
        self.imageName = imageName
    }
    
    //getter and setter for contact
    func getContact() -> String {
        return contact
    }
    func setContact(contact: String){
        self.contact = contact
    }
    
    //getter and setter for email
    func getEmail() -> String {
        return email
    }
    func setEmail(email: String){
        self.email = email
    }
    
    //getter and setter for Locations
    func getLocation() -> CLLocation? {
        return location
    }
    func setLocation(location: CLLocation?){
        self.location = location
    }
}

