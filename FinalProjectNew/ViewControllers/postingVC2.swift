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
class postingVC2: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
 
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
        // Do any additional setup after loading the view.
//        let storage=Storage.storage().reference()
//        //let image=UIImage(named: "globe.png")
//
//        let tempImgRef=storage.child("dir/tmpImg.png")
//        let metadata=StorageMetadata()
//        metadata.contentType="image/png"
//
//        tempImgRef.putData(UIImagePNGRepresentation(image!)!, metadata: metadata) { (data,error) in
//            if error == nil
//            {
//               print("upload succesful")
//            }
//            else
//            {
//                print(error?.localizedDescription)
//            }
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            let key=String(snapshot.childrenCount)
            //let key = ref.childByAutoId().key
            let pict="image\(key).png"
            //creating artist with the given values
            let post = [
                
                "user":self.user,
                "description" :self.desct,
                "id" : key,
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
            self.ref.child(key).setValue(post)
            
            let storage=Storage.storage().reference()
            let tempImgRef=storage.child("dir\(key)/\"image1.jpg")
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            
            tempImgRef.putData(UIImageJPEGRepresentation(self.userimage.image!,0.8)!, metadata: metaData) { (data,error) in
                if error == nil
                {
                    self.imagename=(data?.downloadURL()?.absoluteString)!
                    self.iref = Database.database().reference().child("Housing").child("Postings").child(key)
                    self.iref.updateChildValues(["imageName":self.imagename])
//                    iref.updateChildValues("imageName",: self.imagename)
                    
                    print("upload succesful")
                }
                else
                {
                    print(error?.localizedDescription as Any)
                }
            }
            
            //adding the artist inside the generated unique key
            
            
            //displaying message
        })
        
    }
    
//        
//        lazy var profileImageView:UIImageView = {
//            let userimage=UIImageView()
//            userimage.image=UIImage(named:"placeholder")
//            userimage.contentMode = .scaleAspectFill
//            userimage.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView))
//            
//            
//            
//            
//            
//            )
//            userimage.isUserInteractionEnabled=true
//            return userimage
//        }()
//  //  extention
//    @objc func handleSelectProfileImageView()
//        {
//            
//            
//            
//            
//        }
    
    
    
    
    
    
    
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
        
            // set upload path
          //  let filePath = "\(Auth.auth()!.currentUser!.uid)/\("userimage")"
        
        
        
        
        
//            self.storageRef.child(filePath).putData(data, metadata: metaData){(metaData,error) in
//                if let error = error {
//                    print(error.localizedDescription)
//                    return
//                }else{
//                    //store downloadURL
//                    let downloadURL = metaData!.downloadURL()!.absoluteString
//                    //store downloadURL at database
//                    self.ref.child("users").child(FIRAuth.auth()!.currentUser!.uid).updateChildValues(["userimage": downloadURL])
//                }
        
        
        
        
            }
        }
        
        
        
        
        

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


