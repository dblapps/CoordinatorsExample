//
//  LoginViewController.swift
//  CoordinatorsExample
//
//  Created by David Levi on 5/20/18.
//  Copyright © 2018 CodeTank Labs LLC. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: class {
    func didLogin(loginViewController: LoginViewController)
    func didForgetPassword(loginViewController: LoginViewController)
}

class LoginViewController: UIViewController {

    weak var delegate: LoginViewControllerDelegate? = nil

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }

    @IBAction func login(_ sender: Any) {
        guard self.credentialsValid() else {
            self.invalidCredentials()
            return
        }
        self.delegate?.didLogin(loginViewController: self)
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        self.delegate?.didForgetPassword(loginViewController: self)
    }
    
    func credentialsValid() -> Bool {
        guard self.usernameTextField.text == "joe@foo.com" else { return false }
        guard self.passwordTextField.text == "foo" else { return false }
        return true
    }
    
    func invalidCredentials() {
        let alert = UIAlertController(title: "Cannot Login",
                                      message: "The username or password you entered is not valid.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
