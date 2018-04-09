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
    var listOfListings:[Listing] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        loadData()
        
        let listings = Listings()
        listings.listings = listOfListings
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func loadData() {
        do{
//            let plistPath = Bundle.main.path(forResource: "data", ofType: "plist")!
//            let data = try Data(contentsOf: URL(fileURLWithPath: plistPath))
//            let tempDict = try PropertyListSerialization.propertyList(from: data, format: nil) as! [String:Any]
//            print("\(tempDict)")
//            let tempArray = tempDict["parks"]! as! Array<[String:Any]>
            
//            for dict in tempArray {
//                let parkName = dict["parkName"]! as! String
//                let parkLocation = dict["parkLocation"]! as! String
//                let latitude = Double(dict["latitude"]! as! String)!
//                let longitude = Double(dict["longitude"]! as! String)!
//                let location = CLLocation(latitude: latitude, longitude: longitude)
//                let link = dict["link"]! as! String
//                let imageType = dict["imageType"]! as! String
//                let imageSize = dict["imageSize"]! as! String
//                let imageName = dict["imageName"]! as! String
//                let imageLink = dict["imageLink"]! as! String
//
//                let description = dict["description"]! as! String
//                let dateFormed = dict["dateFormed"]! as! String
//                let area = dict["area"]! as! String
//
//                let p = Park(parkName: parkName, parkLocation: parkLocation, dateFormed: dateFormed, area: area, link: link, location: location, imageLink: imageLink, parkDescription: description, imageName: imageName, imageSize: imageSize, imageType: imageType)
//
//                parks.append(p)
//
//            }
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

