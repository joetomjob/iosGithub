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


class PostingVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate{
    var mylisting = Listing()
    var kbHeight: CGFloat!
    @IBOutlet weak var bathlabel: UILabel!

    @IBOutlet weak var bedlabel: UILabel!
    @IBOutlet weak var arealabel: UILabel!
    @IBOutlet weak var ratelabel: UILabel!
   @IBOutlet weak var pl: UITextField!
    @IBOutlet weak var type: UITextField!
    @IBOutlet weak var typedropdown: UIPickerView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var bed: UISlider!
    @IBOutlet weak var contact: UITextField!
    @IBOutlet weak var fp: UITextField!
    @IBOutlet weak var bath: UISlider!
    @IBOutlet weak var area: UISlider!
    @IBAction func bathslider(_ sender: UISlider) {
        bathlabel.text=String(Int(sender.value))
    }
    
    @IBAction func bedslider(_ sender: UISlider) {
        bedlabel.text=String(Int(sender.value))
    }
    @IBAction func areaslider(_ sender: UISlider) {
         arealabel.text=String(Int(sender.value))
    }
    
    @IBAction func rateslider(_ sender: UISlider) {
        
        ratelabel.text=String(Int(sender.value))
    }
    
    @IBOutlet weak var loc: UITextField!
    @IBAction func cont(_ sender: UIButton) {
        performSegue(withIdentifier: "segueonetotwo", sender: self)
    }
    var mkey=String()
    var typelist=["RENT","SUBLEASE","BUY"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loc.delegate = self
        self.loc.resignFirstResponder()
        textFieldShouldReturn(self.loc)
        if Auth.auth().currentUser != nil {
            // User is signed in.
            // ...
            user.text = (Auth.auth().currentUser?.email)! as String
           // email.text=(Auth.auth().currentUser?.email)! as String
        } else {
            // No user is signed in.
            // ...
        }
        if mylisting.getId() != "Unknown"
        {
        mkey=mylisting.getId()
        pl.text=mylisting.getPlace()
        zip.text=mylisting.getZipCode()
        type.text=mylisting.getType()
        name.text=mylisting.getName()
        desc.text=mylisting.getHouseDescription()
        contact.text=mylisting.getContact()
        fp.text=mylisting.getFoodPreference()
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView:UIPickerView,numberOfRowsInComponent component: Int) -> Int
    {
        
       return typelist.count
        
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return typelist[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.type.text=self.typelist[row]
        self.typedropdown.isHidden=true
    }
    
    func textFieldDidBeginEditing(textField:UITextField){
        if textField==self.type
        {
            self.typedropdown.isHidden=true
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let secondController = segue.destination as! postingVC2
        
     
        secondController.placet=pl.text!
        secondController.ratet=ratelabel.text!
        secondController.typet=self.type.text!
        
        secondController.contactt=self.contact.text!
        
        secondController.desct=desc.text!
        secondController.usert=user.text!
        secondController.bedt=bedlabel.text!
        secondController.batht=bathlabel.text!
        secondController.areat=arealabel.text!
     //   secondController.furnishedt = furnished.text!
     //   secondController.wdt=wd.text!
     //   secondController.dwt=dw.text!
        //        var ovent=oven.text
        secondController.namet=name.text!
        secondController.loct=loc.text!
        secondController.zipt=zip.text!
      //  secondController.mft=multifamily.text!
       // secondController.pft=pf.text!
        secondController.fpt=fp.text!
        secondController.lkey=mkey

        
        
    }
    
    /**
     * All the below methods have been used to hide and show keyboard without overlaping or hiding the view behind
     **/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                kbHeight = keyboardSize.height
                self.animateTextField(up: true)
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        self.animateTextField(up: false)
    }
    
    func animateTextField(up: Bool) {
        let movement = (up ? -kbHeight : kbHeight)
        UIView.animate(withDuration: 0.3, animations: {
            if (movement != nil){
                self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement!)
            }
        })
    }
    
}
