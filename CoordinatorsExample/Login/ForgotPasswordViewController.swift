//
//  ForgotPasswordViewController.swift
//  CoordinatorsExample
//
//  Created by David Levi on 5/20/18.
//  Copyright © 2018 CodeTank Labs LLC. All rights reserved.
//

import UIKit

protocol ForgotPasswordViewControllerDelegate: class {
    func didSubmit(forgotPasswordViewController: ForgotPasswordViewController)
}

class ForgotPasswordViewController: UIViewController {

    weak var delegate: ForgotPasswordViewControllerDelegate? = nil

    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func resetPassword(_ sender: Any) {
        let alert = UIAlertController(title: "Submitted",
                                      message: "An email with instructions to reset your password has been sent to the email address associated with your username.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            self.delegate?.didSubmit(forgotPasswordViewController: self)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
