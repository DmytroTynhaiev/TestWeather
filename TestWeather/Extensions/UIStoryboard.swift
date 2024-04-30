//
//  UIStoryboard.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 30.04.2024.
//

import UIKit

extension UIStoryboard {
    
    static func instantiate<T: UIViewController>(type: T.Type) -> T {
        let identifier = String(describing: T.self)
        let storyboard = self.init(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(identifier)")
        }
        
        viewController.loadViewIfNeeded()
        return viewController
    }
    
}
