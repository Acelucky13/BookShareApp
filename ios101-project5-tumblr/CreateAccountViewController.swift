//
//  CreateAccountViewController.swift
//  Book Share
//
//  Created by Mike Gomez on 4/23/24.
//

import UIKit
import FirebaseAuth
class CreateAccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var EmailF: UITextField!
   
  
    @IBOutlet weak var PasswordF: UITextField!
    
    @IBAction func CreateButton(_ sender: Any) {
        guard let username = EmailF.text, !username.isEmpty,
                      let password = PasswordF.text, !password.isEmpty else {
                    // Show an alert indicating that username/password cannot be empty
                    return
                }
                
                // Create a new user with email and password
                Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
                    if let error = error {
                        // Show an alert indicating the error
                        print("Error creating user: \(error.localizedDescription)")
                    } else {
                        // User created successfully
                        print("User created successfully")
                        self.performSegue(withIdentifier: "BackToLogin", sender: sender)
                        // You can navigate to another view controller or perform any other action here
                    }
                }
            }
        
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
