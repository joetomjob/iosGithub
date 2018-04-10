//
//  AppDelegate.swift
//  FinalProjectNew
//
//  Created by Joe Tom Job  on 4/4/18.
//  Copyright © 2018 Joe Tom Job . All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabBarController:UITabBarController?
    var listOfListings:[Listing] = []
    
    var ref : DatabaseReference!
    var postData = [String]()
    var databaseHandle: DatabaseHandle?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        loadData()
        
        let listingsList = Listings()
        listingsList.listings = listOfListings
        
//        tabBarController = window?.rootViewController as? UITabBarController
//        let intialVC = tabBarController!.viewControllers![0] as! UIViewController
//        let navVC = intialVC.viewcontrollers[0] as! UINavigationController
//        let tableVC = navVC.viewControllers[0] as! LandmarksTableVC
//        tableVC.listingList = listingsList
//        tableVC.mapVC = mapVC
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
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
                        
                        let l = Listing(area: area, bath: bath, bed: bed, houseDescription: houseDescription, dishwasher: dishwasher, foodpreference: foodpreference, furnished: furnished, houseid: houseid, multifamily: multifamily, name: name, place: place, zipcode: zipcode, oven: oven, petfriendly: petfriendly, pic: pic, rate: rate, type: type, user: user, washerdryer: washerdryer)
                        
                        self.listOfListings.append(l)
                    }
                }
            })

        }
        catch{
            print(error)
        }
        
//        print("There are \(parks.count) parks")
//        print("\(parks)")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

