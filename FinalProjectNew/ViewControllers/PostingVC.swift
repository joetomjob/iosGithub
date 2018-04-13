//
//  PostingVC.swift
//  FinalProjectNew
//
//  Created by Sikha Rani on 4/10/18.
//  Copyright © 2018 Joe Tom Job . All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class PostingVC: UIViewController {
   
   @IBOutlet weak var ad: UITextField!
    
    
  
    
    @IBOutlet weak var pl: UITextField!
    
    @IBOutlet weak var rate: UITextField!
    
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var zip: UITextField!
    
    @IBOutlet weak var desc: UITextField!
    
    
    @IBOutlet weak var user: UITextField!
    
    
    @IBOutlet weak var bed: UITextField!
    
    
    
    @IBOutlet weak var pf: UITextField!
    
    
    
    @IBOutlet weak var fp: UITextField!
    
    @IBOutlet weak var bath: UITextField!
    
    @IBOutlet weak var area: UITextField!
    
    @IBOutlet weak var furnished: UITextField!
    
  
    
    
    @IBOutlet weak var wd: UITextField!
    
    
    
    
    @IBOutlet weak var dw: UITextField!
    
    
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
    func postData()
    {
        
        var availDate=ad.text
        var placet=pl.text
        var ratet=rate.text
        var typet=type.text
        var desct=desc.text
        var usert=user.text
        var bedt=bed.text
        var batht=bath.text
        var areat=area.text
        var furnishedt = furnished.text
        var wdt=wd.text
        var dwt=dw.text
        var ovent=oven.text
        
        
        
        
        do{
            ref =  Database.database().reference().child("Housing").child("Postings")
            let key = ref.childByAutoId().key
            
            //creating artist with the given values
            let post = ["id":key,
                          "Area": area.text! as String,
                          "Rate": rate.text! as String
            ]
            
            //adding the artist inside the generated unique key
            ref.child(key).setValue(post)
            
            //displaying message
        }
        
        
        
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

}
