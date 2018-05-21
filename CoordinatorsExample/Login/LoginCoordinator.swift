//
//  LoginCoordinator.swift
//  CoordinatorsExample
//
//  Created by David Levi on 5/20/18.
//  Copyright © 2018 CodeTank Labs LLC. All rights reserved.
//

import UIKit

protocol LoginCoordinatorDelegate: class {
    func didLogin(loginCoordinator: LoginCoordinator)
}

class LoginCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    
    var coordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var rootViewController: UIViewController? = nil
    
    weak var delegate: LoginCoordinatorDelegate?

    let storyboard = UIStoryboard(name:"Login", bundle:nil)

    init(parentCoordinator: Coordinator, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    func start(animated: Bool) {
        self.rootViewController = self.loginViewController()
        self.navigationController.pushViewController(self.rootViewController!, animated: animated)
    }
    
    func stop(animated: Bool) {
        guard let rootViewController = self.rootViewController else { return }
        self.navigationController.popToViewController(rootViewController, animated: false)
        self.navigationController.popViewController(animated: animated)
    }
    
}

extension LoginCoordinator: LoginViewControllerDelegate {

    func loginViewController() -> LoginViewController {
        let loginViewController: LoginViewController = self.storyboard.instantiateViewController()
        loginViewController.delegate = self
        return loginViewController
    }
    
    func didLogin(loginViewController: LoginViewController) {
        self.delegate?.didLogin(loginCoordinator: self)
    }

    func didForgetPassword(loginViewController: LoginViewController) {
        self.navigationController.pushViewController(self.forgotPasswordViewController(), animated: true)
    }
    
}

extension LoginCoordinator: ForgotPasswordViewControllerDelegate {

    func forgotPasswordViewController() -> ForgotPasswordViewController {
        let forgotPasswordViewController: ForgotPasswordViewController = self.storyboard.instantiateViewController()
        forgotPasswordViewController.delegate = self
        return forgotPasswordViewController
    }

    func didSubmit(forgotPasswordViewController: ForgotPasswordViewController) {
        self.navigationController.popViewController(animated: true)
    }
    
}
