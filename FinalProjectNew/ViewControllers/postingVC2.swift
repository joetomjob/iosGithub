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
import CoreLocation

class postingVC2: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
 var mylisting = Listing()
    @IBOutlet weak var userimage: UIImageView!
    
    @IBAction func upload(_ sender: UIButton) {
        
        let image=UIImagePickerController()
        image.delegate=self
        image.sourceType=UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing=true
        self.present(image,animated:true)
        {
            
            
            
        }
        
        
    }
  //  var availDate=String()
    var placet=String()
    var ratet=String()
    var typet=String()
    
    var desct=String()
    var usert=String()
    var bedt=String()
    var batht=String()
    var areat=String()
var namet=String()
    var zipt=String()
   var fpt=String()
    var loct=String()
   var contactt=String()
    var imagename=String()
    var lkey=String()
    
    
    var coords: CLLocationCoordinate2D!
    var addressDict : [String:String]!
    var cllocationoflisting: CLLocation!
    
  
    @IBOutlet weak var wd: UILabel!
    
    @IBOutlet weak var dw: UILabel!
    
    
    @IBOutlet weak var oven: UILabel!
    @IBOutlet weak var pf: UILabel!
    @IBOutlet weak var furnished: UILabel!
    @IBOutlet weak var mf: UILabel!
    
    @IBAction func wdswitch(_ sender: UISwitch) {
        
        if sender.isOn==true
        {
            wd.text="Y"
        }
        else
        {
             wd.text="N"
        }
    }
    
    
    
    @IBAction func dwswitch(_ sender: UISwitch) {
        
        if sender.isOn==true
        {
            dw.text="Y"
        }
        else
        {
            dw.text="N"
        }
    }
    
    
    @IBAction func pfswitch(_ sender: UISwitch) {
        
        if sender.isOn==true
        {
            pf.text="Y"
        }
        else
        {
            pf.text="N"
        }
    }
    
    
    @IBAction func ovenswitch(_ sender: UISwitch) {
        
        if sender.isOn==true
        {
            oven.text="Y"
        }
        else
        {
            oven.text="N"
        }
    }
    
    
    @IBAction func furnishedswitch(_ sender: UISwitch) {
        if sender.isOn==true
        {
            furnished.text="Y"
        }
        else
        {
            furnished.text="N"
        }
    }
    
    @IBAction func mfswitch(_ sender: UISwitch) {
        
        if sender.isOn==true
        {
            mf.text="Y"
        }
        else
        {
            mf.text="N"
        }
    }
    
    
    @IBOutlet weak var availdate: UIDatePicker!
    
    
    @IBAction func getAvailDate(_ sender: UIDatePicker) {
         date.text="\(availdate.date)"
    }
    @IBAction func post(_ sender: UIButton) {
        
        postData()
    }
    
    @IBOutlet weak var date: UILabel!
    var ref : DatabaseReference!
    var iref : DatabaseReference!
    
    var user=String()
    var email=String()
    var databaseHandle: DatabaseHandle?
    override func viewDidLoad() {
        super.viewDidLoad()
        let todaysdate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd.yyyy"
        let result = formatter.string(from: todaysdate)
        date.text=result
let database = Database.database().reference()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isEmptyLists(dicts: [String: String]) -> Bool {
        for v in dicts.values {
            if v=="" { return true }
        }
        return false
    }
    
    func postData()
    {
        
 
        let ovent=oven.text
        let wdt=wd.text
        let dwt=dw.text
        let pft=pf.text
        let furnishedt=furnished.text
        let mft=mf.text

        ref =  Database.database().reference().child("Housing").child("Postings")
        if Auth.auth().currentUser != nil {
            // User is signed in.
            // ...
            user = (Auth.auth().currentUser?.email)!
            email=(Auth.auth().currentUser?.email)!
        } else {
            // No user is signed in.
            // ...
        }
        
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            var key:String!
            var y=0
            
            if (self.lkey == ""){
                for snap in snapshot.children {
                    let userSnap = snap as! DataSnapshot
                    let uid = userSnap.key //the uid of each user
                    let userDict = userSnap.value as! [String:String]
                    
                    if (Int(uid)!) > (Int(y))
                    {
                    y=(Int(uid)!)
                       let z=y+1
                        self.lkey=String(z)
                    }
                  //  let id = userDict["id"] as! String?
                }
            }
            
            
            //let key = ref.childByAutoId().key
            let pict="image\(self.lkey).jpg"
            //creating artist with the given values
            var post = [
                
                "user":self.user,
                "description" :self.desct,
                "id" : self.lkey,
                "name" : self.namet as String,
                "imageName" : self.imagename as String,
                "place" : "\(self.loct),\(self.placet)" as String,
                "rate" : "\(self.ratet)$" as String,
                "type" : self.typet as String,
                "zip": self.zipt as String,
                "Bed":self.bedt as String,
                "Bath":self.batht as String,
                "Area":self.areat as String,
                "washerdryer":wdt! as String,
                "multifamily":mft! as String,
                "petfriendly":pft! as String,
                "foodpreference":self.fpt as String,
                "furnished":furnishedt! as String,
                "dishwasher":dwt! as String,
                "contact":self.contactt as String,
                "email":self.email,
                "oven":ovent! as String
            ]
          
            //if(self.user.count == 0)
            
            
            let storage=Storage.storage().reference()
            let tempImgRef=storage.child("dir\(self.lkey)/\"image1.jpg")
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            
                tempImgRef.putData(UIImageJPEGRepresentation(self.userimage.image!,0.8)!, metadata: metaData) { (data,error) in
                    if error == nil
                    {
                        self.imagename=(data?.downloadURL()?.absoluteString)!
                        self.iref = Database.database().reference().child("Housing").child("Postings").child(self.lkey)
                        self.iref.updateChildValues(["imageName":self.imagename])
    //                    iref.updateChildValues("imageName",: self.imagename)
                        
                        print("upload succesful")
                    }
                    else
                    {
                        print(error?.localizedDescription as Any)
                    }
                }
            
            post["imageName"] = "tempImageName.jpg"
            if self.isEmptyLists(dicts: post) == false
            {
                self.ref.child(self.lkey).setValue(post)
                
                let geocoder = CLGeocoder()
                let addressString = "\(self.namet)\(self.loct)\(self.zipt)" as String
                
                geocoder.geocodeAddressString(addressString) { (placemarks:[CLPlacemark]?, error:Error?) in
                    if let placemark = placemarks?[0]{
                        if let location = placemark.location{
                            self.coords = location.coordinate //we need to use self because we are in a completion handler
                            self.cllocationoflisting =  CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                        }
                        let alert = UIAlertController(title: "Posting Done", message: "", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                    else{
                        let dref = Database.database().reference().child("Housing").child("Postings").child("\(self.lkey)")
                        dref.removeValue()
                        let alert = UIAlertController(title: "Address not valid", message: "Please give valid address", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
                
            }
            else{
                let alert = UIAlertController(title: "Empty values", message: "Please enter all the details.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        })
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
    
        //    let image = UIImage(named:"Placeholder.jpg")
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
                userimage.image=image
            
            }
            
            else{
            
            }
            self.dismiss(animated: true, completion: nil)
        
            var data = Data()
           data = UIImageJPEGRepresentation(userimage.image!,0.8)!
        
        
            }
        }

