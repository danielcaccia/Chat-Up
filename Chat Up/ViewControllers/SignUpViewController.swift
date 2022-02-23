//
//  RegisterViewController.swift
//  Chat Up
//
//  Created by Daniel Caccia on 02/02/21.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var warningView: UIView!
    @IBOutlet weak var warningLabel: UILabel!
    
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonLayout(signUpButton)
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let err = error {
                    self.showAlert(with: err.localizedDescription)
                    self.passwordTextField.text = ""
                } else {
                    let user = Auth.auth().currentUser
                    
                    if let firstName = self.firstNameTextField.text, let lastName = self.lastNameTextField.text, let email = user?.email, let uid = user?.uid {
                        self.db.collection(K.Fstore.usersCollectionName).document(uid).setData([
                            K.Fstore.firstNameField: firstName,
                            K.Fstore.lastNameField: lastName,
                            K.Fstore.emailField: email
                        ]) { error in
                            if let err = error {
                                print("Error saving data to Firestore: \(err)")
                            } else {
                                print("Data saved to Firestore.")
                            }
                        }
                        
                        self.performSegue(withIdentifier: K.signUpSegue, sender: self)
                    }
                }
            }
        }
    }
    
    func showAlert(with error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func setButtonLayout(_ button: UIButton) {
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
    }

}
