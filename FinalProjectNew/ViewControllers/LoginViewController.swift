//
//  LoginViewController.swift
//  FinalProjectNew
//
//  Created by Joe Tom Job  on 4/6/18.
//  Copyright © 2018 Joe Tom Job . All rights reserved.
//
import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {
var uref : DatabaseReference!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func action(_ sender: UIButton) {
        if emailText.text != "" && passwordText.text != ""{
            if segmentedControl.selectedSegmentIndex == 0{
                Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!, completion: {(user, error) in
                    if user != nil{
                        var ref: DatabaseReference!
                        ref = Database.database().reference()
                        self.performSegue(withIdentifier: "SignIn", sender: nil)
                    }
                    else{
                        if let merror = error?.localizedDescription{
                            let alert = UIAlertController(title: "Invalid User", message: merror, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) in
                                alert.dismiss(animated: true, completion: nil)
                            }))
                            self.present(alert, animated: true, completion: nil)
                            print(merror)
                        }
                        else{
                            print("Error")
                        }
                    }
                })
            }
            else{
                Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
                    if error != nil{
                        print("Cannot Register")
                    }
                    else{
                        self.uref =  Database.database().reference().child("Housing").child("Users")
                        
                        self.uref.observeSingleEvent(of: .value, with: {(snapshot) in
                            let key=String(snapshot.childrenCount)
                            //let key = ref.childByAutoId().key
                            
                            //creating artist with the given values
                            let post = [
                                
                                "user":self.emailText.text,
                                "password" :self.passwordText.text,
                                
                         
                            ]
                            
                        self.uref.child(key).setValue(post)
                        })
                        
                        
                        self.performSegue(withIdentifier: "SignIn", sender: nil)
                    }
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
