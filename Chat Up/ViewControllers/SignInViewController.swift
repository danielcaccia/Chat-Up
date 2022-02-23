//
//  SignInViewController.swift
//  Chat Up
//
//  Created by Daniel Caccia on 02/02/21.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var userSession: UserSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setButtonLayout(signInButton)
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let err = error {
                    self.showAlert(with: err.localizedDescription)
                    self.passwordTextField.text = ""
                } else {
                    self.userSession.fetchUserSession()
                    
                    self.performSegue(withIdentifier: K.signInSegue, sender: self)
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
