//
//  AppCoordinator.swift
//  swiftTemplate
//
//  Created by David Levi on 2/1/18.
//  Copyright © 2018 David Levi. All rights reserved.
//

import UIKit

enum AppState: Int {
	case userUnauthenticated
	case userAuthenticated
}

class AppCoordinator: Coordinator {
	
	let window: UIWindow
	
	var parentCoordinator: Coordinator? = nil
	var coordinators: [Coordinator] = []
	
	var rootViewController: UIViewController? {
		return self.window.rootViewController!
	}

    var appState: AppState {
        get {
            return UserDefaults.standard.bool(forKey: "appState") ? .userAuthenticated : .userUnauthenticated
        }
        set {
            UserDefaults.standard.set(newValue == .userAuthenticated, forKey: "appState")
        }
    }
	
	let storyboard = UIStoryboard(name:"Main", bundle:nil)
	
	// Note that this declaration of navigationController overrides the one in the extension in CTCoordinator.swift
	var navigationController: UINavigationController
	
	init() {
		// Since our Main.storyboard does not contain an initial view controller, we don't get a window created by default, so create it here
		self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window.backgroundColor = UIColor.white

		// Create navigation controller for main app view
        let dummyViewController = UIViewController()
        dummyViewController.title = "Superheroes"
		self.navigationController = UINavigationController(rootViewController: dummyViewController)
		
		self.window.rootViewController = self.navigationController

		// Finally, make the window visible
		self.window.makeKeyAndVisible()
	}
	
	public func start() {
		if self.appState == .userUnauthenticated {
			// User is not signed in, so should start with signin screen
            self.startLoginCoordinator(animated:false)
        } else {
			// User is signed in, start heroes coordinator
            self.startHeroesCoordinator(animated:false)
            self.startAuthExpireTimer()
		}
	}

    public func startAuthExpireTimer() {
//        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { (timer) in
//            self.appState = .userUnauthenticated
//            self.navigationController.popToRootViewController(animated: false)
//            self.coordinators.removeLast()
//            self.startLoginCoordinator(animated: true)
//        }
    }
    
}


// MARK: - LoginCoordinatorDelegate

extension AppCoordinator: LoginCoordinatorDelegate {
	
    func startLoginCoordinator(animated: Bool) {
        let loginCoordinator = LoginCoordinator(parentCoordinator: self, navigationController: self.navigationController)
		loginCoordinator.delegate = self
        loginCoordinator.start(animated: animated)
		self.coordinators.append(loginCoordinator)
	}

    func didLogin(loginCoordinator: LoginCoordinator) {
        self.appState = .userAuthenticated
        loginCoordinator.stop(animated: false)
        self.coordinators.removeLast()
        self.startHeroesCoordinator(animated: true)
        self.startAuthExpireTimer()
    }

}

// MARK: - HeroesCoordinatorDelegate

extension AppCoordinator: HeroesCoordinatorDelegate {
	
	func startHeroesCoordinator(animated: Bool) {
        let heroesCoordinator = HeroesCoordinator(parentCoordinator: self, navigationController: self.navigationController)
        heroesCoordinator.delegate = self
        heroesCoordinator.start(animated: animated)
        self.coordinators.append(heroesCoordinator)
	}
	
    func didLogout(heroesCoordinator: HeroesCoordinator) {
        self.appState = .userUnauthenticated
        heroesCoordinator.stop(animated: false)
        self.coordinators.removeLast()
        self.startLoginCoordinator(animated: true)
    }
    
}
