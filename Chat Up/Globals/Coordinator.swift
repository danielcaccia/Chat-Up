//
//  Coordinator.swift
//  Chat Up
//
//  Created by Daniel Caccia on 23/02/22.
//

import UIKit

class Coordinator: NSObject {
    
    private override init() {}
    
    static let shared = Coordinator()

    func presentNewController(currentViewController: UIViewController, storyboardName: String, viewControllerID: String, isModal: Bool, optionalObject: Any?) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerID)
        
        if let optional = optionalObject {
            viewController.optionalObject = optional
        }
        
        if isModal {
            viewController.modalPresentationStyle = .fullScreen
            currentViewController.present(viewController, animated: true, completion: nil)
        } else {
            currentViewController.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
