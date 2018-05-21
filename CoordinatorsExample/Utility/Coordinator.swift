//
//  Coordinator.swift
//  swiftTemplate
//
//  Created by David Levi on 1/22/18.
//  Copyright © 2018 CodeTank Labs LLC. All rights reserved.
//

import Foundation
import UIKit

// A coordinator can manage a collection of child coordinators
public protocol Coordinator: class {
	
	// The parent coordinator of this coordinator, nil for the root coordinator
	// Any class that adopts the Coordinator protocol must provide storage for this with the following declaration:
	//		var parentCoordinator: Coordinator? = nil
	var parentCoordinator: Coordinator? { get set }
	
	// The child coordinators of this Coordinator
	// Any class that adopts the Coordinator protocol must provide storage for this with the following declaration:
	//		var coordinators: [Coordinator] = []
	var coordinators: [Coordinator] { get set }
	
	// The navigationController to be used to manage this coordinator's view controller hierarchy
    // Any class that adopts the Coordinator protocol must provide storage for this with the following declaration:
    //        var navigationController: UINavigationController? = nil
	var navigationController: UINavigationController { get set }
	
	// The root UIViewController managed by this Coordinator.  This can be used, for example, to dismiss the entire view controller
	// hierarchy controlled by this coordinator.
	var rootViewController: UIViewController? { get }
	
}

//private var navigationControllerKey: UInt8 = 0
//private var viewControllersKey: UInt8 = 0

//public extension Coordinator {
//
////    // This provides a default implementation and storage for the navigationController.  A coordinator can override this and
////    // managed it's own storage.  For example, it can declare:
////    //        var navigationController: UINavigationController
////    var navigationController: UINavigationController {
////        get {
////            return associatedObject(self, key: &navigationControllerKey, initializer: {
////                let navigationController = UINavigationController()
////                associateObject(self, key: &navigationControllerKey, value: navigationController)
////                return navigationController
////            })
////        }
////        set {
////            associateObject(self, key: &navigationControllerKey, value: newValue)
////        }
////    }
//
//}
