//
//  StoryboardIdentifiable.swift
//  swiftTemplate
//
//  Created by David Levi on 1/24/18.
//  Copyright © 2018 CodeTank Labs LLC. All rights reserved.
//

// Reference: https://medium.com/swift-programming/uistoryboard-safer-with-enums-protocol-extensions-and-generics-7aad3883b44d

import UIKit

protocol StoryboardIdentifiable {
	static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
	static var storyboardIdentifier: String {
		return String(describing: self)
	}
}

extension UIViewController : StoryboardIdentifiable { }

extension UIStoryboard {
	func instantiateViewController<T: UIViewController>() -> T {
		guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
			fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
		}
		return viewController
	}
}
