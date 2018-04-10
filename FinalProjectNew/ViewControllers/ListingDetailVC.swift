  //
//  ListingDetailVC.swift
//  FinalProjectNew
//
//  Created by Joe Tom Job  on 4/9/18.
//  Copyright © 2018 Joe Tom Job . All rights reserved.
//

import UIKit

class ListingDetailVC: UITableViewController {

    var listing:Listing!
    
    let NAME            = 0
    let PLACE           = 1
    let RATE            = 2
    let TYPE            = 3
    let ZIP             = 4
    let DESCRIPTION     = 5
    let USER            = 6
    let BED             = 7
    let BATH            = 8
    let AREA            = 9
    let FURNISHED       = 10
    let WAHSERDRYER     = 11
    let DISHWASHER      = 12
    let FOODPREFERENCE  = 13
    let MULTIFAMILY     = 14
    let OVEN            = 15
    let PETFRIENDLY     = 16
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 17
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
        }
        
        // Configure the cell...
        switch indexPath.section {
            case NAME:
                cell!.textLabel?.text = listing.getName()
            case PLACE:
                cell!.textLabel?.text = listing.getPlace()
            case RATE:
                cell!.textLabel?.text = listing.getRate()
            case TYPE:
                cell!.textLabel?.text = listing.getType()
            case ZIP:
                cell!.textLabel?.text = listing.getZipCode()
            case DESCRIPTION:
                cell!.textLabel?.text = listing.getHouseDescription()
            case USER:
                cell!.textLabel?.text = listing.getUser()
            case BED:
                cell!.textLabel?.text = listing.getBed()
            case BATH:
                cell!.textLabel?.text = listing.getBath()
            case AREA:
                cell!.textLabel?.text = listing.getArea()
            case FURNISHED:
                cell!.textLabel?.text = listing.getFurnished()
            case WAHSERDRYER:
                cell!.textLabel?.text = listing.getWasherDryer()
            case DISHWASHER:
                cell!.textLabel?.text = listing.getDishwasher()
            case FOODPREFERENCE:
                cell!.textLabel?.text = listing.getFoodPreference()
            case MULTIFAMILY:
                cell!.textLabel?.text = listing.getMultifamily()
            case OVEN:
                cell!.textLabel?.text = listing.getOven()
            case PETFRIENDLY:
                cell!.textLabel?.text = listing.getPetFriendly()
            default:
                break
        }
        
        
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        switch section {
            case NAME:
                title = "Name"
            case PLACE:
                title = "Place"
            case RATE:
                title = "Rate"
            case TYPE:
                title = "Type"
            case ZIP:
                title = "ZipCode"
            case DESCRIPTION:
                title = "Description"
            case USER:
                title = "Owner"
            case BED:
                title = "Bed"
            case BATH:
                title = "Bath"
            case AREA:
                title = "Area"
            case FURNISHED:
                title = "Furnished"
            case WAHSERDRYER:
                title = "Washer/Dryer"
            case DISHWASHER:
                title = "Dishwasher"
            case FOODPREFERENCE:
                title = "FoodPreference"
            case MULTIFAMILY:
                title = "Multifamily"
            case OVEN:
                title = "Oven"
            case PETFRIENDLY:
                title = "Petfriendly"
            default:
                break
        }
        return title
    
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

}
