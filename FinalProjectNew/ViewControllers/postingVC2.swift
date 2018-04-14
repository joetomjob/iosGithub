//
//  postingVC2.swift
//  FinalProjectNew
//
//  Created by Sikha Rani on 4/13/18.
//  Copyright © 2018 Joe Tom Job . All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class postingVC2: UIViewController {
 
    var availDate=String()
    var placet=String()
    var ratet=String()
    var typet=String()
    
    var desct=String()
    var usert=String()
    var bedt=String()
    var batht=String()
    var areat=String()
    var furnishedt = String()
    var wdt=String()
    var dwt=String()
    
    var namet=String()
    var pict=String()
    var zipt=String()
    var mft=String()
    var pft=String()
    var fpt=String()
   
  
    @IBOutlet weak var oven: UITextField!
    
    
    @IBAction func post(_ sender: UIButton) {
        postData()
        
        
    }
    
    var ref : DatabaseReference!
    
    var databaseHandle: DatabaseHandle?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func postData()
    {
        
 
        let ovent=oven.text
        
        
        
        
        ref =  Database.database().reference().child("Housing").child("Postings")
        
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            let key=String(snapshot.childrenCount)
            //let key = ref.childByAutoId().key
            
            //creating artist with the given values
            let post = [
                
                "user":self.usert,
                "description" :self.desct,
                "id" : key,
                "name" : self.namet as String,
                "pic" : self.pict as String,
                "place" : self.placet as String,
                "rate" : self.ratet as String,
                "type" : self.typet as String,
                "zip": self.zipt as String,
                "Bed":self.bedt as String,
                "Bath":self.batht as String,
                "Area":self.areat as String,
                "washerdryer":self.wdt as String,
                "multifamily":self.mft as String,
                "petfriendly":self.pft as String,
                "foodpreference":self.fpt as String,
                "furnished":self.furnishedt as String,
                "dishwasher":self.dwt as String,
                              "oven":ovent! as String
            ]
            
            //adding the artist inside the generated unique key
            self.ref.child(key).setValue(post)
            
            //displaying message
        })
        
        
        
        
        
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
