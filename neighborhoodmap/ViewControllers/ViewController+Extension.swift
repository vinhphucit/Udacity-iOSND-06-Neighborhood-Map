//
//  ViewController+Extension.swift
//  neighborhoodmap
//
//  Created by Phuc Tran on 4/11/18.
//  Copyright © 2018 Phuc Tran. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlert(title: String = "Error", message: String, dismiss: ((UIAlertAction) -> (Void))?) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: dismiss)
        controller.addAction(dismissAction)
        present(controller, animated: true, completion: nil)
    }
}

