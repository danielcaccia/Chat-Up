//
//  SignInViewController.swift
//  Chat Up
//
//  Created by Daniel Caccia on 02/02/21.
//

import UIKit
import Firebase

class SignInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBOutlet weak var warningView: UIView!
    @IBOutlet weak var warningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        warningView.isHidden = true
        
        setButtonLayout(signInButton)
    }
    
    // To be uncommented after tests
//    override func viewWillAppear(_ animated: Bool) {
//        emailTextField.text = ""
//        passwordTextField.text = ""
//    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        warningView.isHidden = true
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let err = error {
                    self.warningLabel.text = err.localizedDescription
                    self.warningView.isHidden = false
                    self.passwordTextField.text = ""
                } else {
                    UserSession.shared.fetchUserSession()
                    Coordinator.shared.presentNewController(currentViewController: self, storyboardName: K.StoryboardIDs.mainStoryboard, viewControllerID: K.StoryboardIDs.contactsView, isModal: false, optionalObject: nil)
                }
            }
        }
    }
    
    func setButtonLayout(_ button: UIButton) {
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
    }

}
