//
//  LogInViewController.swift
//  Book Share
//
//  Created by Mike Gomez on 4/23/24.
//

import UIKit
import FirebaseAuth
class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var UserEmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    
    @IBAction func LogInButton(_ sender: Any) {
        guard let email = UserEmailField.text, !email.isEmpty,
                     let password = PasswordField.text, !password.isEmpty else {
                   // Show an alert indicating that email/password cannot be empty
                   return
               }
               
               // Sign in the user with email and password
               Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                   guard let self = self else { return }
                   if let error = error {
                       // Show an alert indicating the error
                       print("Error signing in: \(error.localizedDescription)")
                   } else {
                       // User signed in successfully
                       print("User signed in successfully")
                       performSegue(withIdentifier: "GoToApp", sender: self)
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
