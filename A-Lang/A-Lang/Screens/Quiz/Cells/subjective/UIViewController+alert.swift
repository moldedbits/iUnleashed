//
//  UIViewController+alert.swift
//  A-Lang
//
//  Created by Vishal Singh on 17/09/17.
//  Copyright © 2017 moldedbits. All rights reserved.
//

import UIKit

extension UIViewController {

    func presentAlert(alertTitle: String, alertMessage: String, actionTitle: String = "OK", actionHandler:((UIAlertAction) -> ())? = nil) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: actionTitle, style: .default, handler:actionHandler)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
}
