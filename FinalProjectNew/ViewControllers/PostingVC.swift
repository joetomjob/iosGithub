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
   
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var ad: UITextField!
    
    
    @IBOutlet weak var multifamily: UITextField!
    
    @IBOutlet weak var pic: UITextField!
    
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
    
    
    @IBOutlet weak var loc: UITextField!
 //   @IBOutlet weak var oven: UITextField!
    
   
    @IBAction func cont(_ sender: UIButton) {
        
         performSegue(withIdentifier: "segueonetotwo", sender: self)
    }
    
    
//    var ref : DatabaseReference!
//
//    var databaseHandle: DatabaseHandle?
    override func viewDidLoad() {
        super.viewDidLoad()
       
       

        // Do any additional setup after loading the view.
    }
//    func postData()
//    {
//        
//        var availDate=ad.text
//        var placet=pl.text
//        var ratet=rate.text
//        var typet=type.text
//        var desct=desc.text
//        var usert=user.text
//        var bedt=bed.text
//        var batht=bath.text
//        var areat=area.text
//        var furnishedt = furnished.text
//        var wdt=wd.text
//        var dwt=dw.text
//       var ovent=oven.text
//        var namet=name.text
//        var pict=pic.text
//        var zipt=zip.text
//        var mft=multifamily.text
//        var pft=pf.text
//        var fpt=fp.text
//
//        
//        
//        
//        
//            ref =  Database.database().reference().child("Housing").child("Postings")
//            
//            ref.observeSingleEvent(of: .value, with: {(snapshot) in
//                let key=String(snapshot.childrenCount)
//            //let key = ref.childByAutoId().key
//            
//            //creating artist with the given values
//            let post = [
//                      
//                "user":usert! as String,
//                "description" :desct! as String,
//                "id" : key,
//                "name" : namet! as String,
//                "pic" : pict! as String,
//                "place" : placet! as String,
//                "rate" : ratet! as String,
//                "type" : typet! as String,
//                "zip": zipt! as String,
//                "Bed":bedt! as String,
//                "Bath":batht! as String,
//                "Area":areat! as String,
//                "washerdryer":wdt! as String,
//                "multifamily":mft! as String,
//                "petfriendly":pft! as String,
//                "foodpreference":fpt! as String,
//                "furnished":furnishedt! as String,
//                "dishwasher":dwt! as String,
////                "oven":ovent! as String
//            ]
//            
//            //adding the artist inside the generated unique key
//                self.ref.child(key).setValue(post)
//            
//            //displaying message
//            })
//        
//            
//        
//        
//        
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let secondController = segue.destination as! postingVC2
        
        secondController.availDate=ad.text!
        secondController.placet=pl.text!
        secondController.ratet=rate.text!
        secondController.typet=type.text!
        secondController.desct=desc.text!
        secondController.usert=user.text!
        secondController.bedt=bed.text!
        secondController.batht=bath.text!
        secondController.areat=area.text!
        secondController.furnishedt = furnished.text!
        secondController.wdt=wd.text!
        secondController.dwt=dw.text!
        //        var ovent=oven.text
        secondController.namet=name.text!
        secondController.pict=pic.text!
        secondController.zipt=zip.text!
        secondController.mft=multifamily.text!
        secondController.pft=pf.text!
        secondController.fpt=fp.text!

        
        
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
