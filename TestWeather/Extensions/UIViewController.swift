//
//  UIViewController.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 30.04.2024.
//

import UIKit

extension UIViewController {
    
    
    static func instantiate() -> Self {
        let vc = UIStoryboard.instantiate(type: Self.self)
        return vc
    }
    
    
}
