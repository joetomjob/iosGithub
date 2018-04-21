  //
//  ListingDetailVC.swift
//  FinalProjectNew
//
//  Created by Joe Tom Job  on 4/9/18.
//  Copyright © 2018 Joe Tom Job . All rights reserved.
//

import UIKit

class ListingDetailVC: UITableViewController {

    var listing = Listing()
    
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
    @IBOutlet weak var listingImage: UIImageView!
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listingName.textLabel?.text = "Name"
        listingName.detailTextLabel?.text = listing.getName()
        listingPlace.textLabel?.text = "Place"
        listingPlace.detailTextLabel?.text = listing.getPlace()
        listingRate.textLabel?.text = "Rate"
        listingRate.detailTextLabel?.text = listing.getRate()
        listingType.textLabel?.text = "Type"
        listingType.detailTextLabel?.text = listing.getType()
        listingZip.textLabel?.text = "ZipCode"
        listingZip.detailTextLabel?.text = listing.getZipCode()
        listingDescription.textLabel?.text = "Description"
        listingDescription.detailTextLabel?.text = listing.getHouseDescription()
        listingDescription.detailTextLabel?.numberOfLines = 6
        listingUser.textLabel?.text = "User"
        listingUser.detailTextLabel?.text = listing.getUser()
        listingBed.textLabel?.text = "Bed"
        listingBed.detailTextLabel?.text = listing.getBed()
        listingBath.textLabel?.text = "Bath"
        listingBath.detailTextLabel?.text = listing.getBath()
        listingArea.textLabel?.text = "Area"
        listingArea.detailTextLabel?.text = listing.getArea()
        listingFurnished.textLabel?.text = "Furnished"
        listingFurnished.detailTextLabel?.text = listing.getFurnished()
        listingWasherDryer.textLabel?.text = "Washer/Dryer"
        listingWasherDryer.detailTextLabel?.text = listing.getWasherDryer()
        listingDishWasher.textLabel?.text = "Dishwasher"
        listingDishWasher.detailTextLabel?.text = listing.getDishwasher()
        listingFoodPreference.textLabel?.text = "Food Preference"
        listingFoodPreference.detailTextLabel?.text = listing.getFoodPreference()
        listingMultiFamily.textLabel?.text = "MultiFamily"
        listingMultiFamily.detailTextLabel?.text = listing.getMultifamily()
        listingOven.textLabel?.text = "Oven"
        listingOven.detailTextLabel?.text = listing.getOven()
        listingPetFriendly.textLabel?.text = "Pet Friendly"
        listingPetFriendly.detailTextLabel?.text = listing.getPetFriendly()
        
        //Load Image
        let url = URL(string: listing.getImageName())
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                // No errors found.
                // It would be weird if we didn't have a response, so check for that too.
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        self.listingImage.image = UIImage(data: imageData)
                        // Do something with your image.
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        self.tableView.reloadData()
        task.resume()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return 18
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
