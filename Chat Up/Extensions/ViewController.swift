//
//  ViewController.swift
//  Chat Up
//
//  Created by Daniel Caccia on 23/02/22.
//

import UIKit

extension UIViewController {
    
    private static var _optionalObject: Any? = nil
    
    var optionalObject: Any {
        get {
            return UIViewController._optionalObject ?? false
        }
        set(newValue) {
            UIViewController._optionalObject = newValue
        }
    }
    
}
