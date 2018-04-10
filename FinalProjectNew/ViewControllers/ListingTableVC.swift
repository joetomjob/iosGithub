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

class ListingTableVC: UITableViewController {

    @IBOutlet var tableV: UITableView!
    
    var listingList = Listings()
    var listings : [Listing] { //front end for LandmarkList model object
        get {
            return self.listingList.listings
        }
        set(val) {
            self.listingList.listings = val
        }
    }
    
    var ref : DatabaseReference!
    var databaseHandle: DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
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
        let cell:ListingCell = tableView.dequeueReusableCell(withIdentifier: "ListingCell", for: indexPath) as! ListingCell

        // Configure the cell...
        let listing = listings[indexPath.row]
        cell.listingName.text = listing.getName()
        cell.listingPlace.text = listing.getPlace()
        cell.listingRate.text = listing.getRate()
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listing = listings[indexPath.row]
        let detailVC = ListingDetailVC(style: .grouped)
        detailVC.title = listing.title
        detailVC.listing = listing
//        detailVC.delegate = mapVC
        navigationController?.pushViewController(detailVC, animated: true)
    }
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
