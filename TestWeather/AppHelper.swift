//
//  AppHelper.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 01.05.2024.
//

import UIKit

class AppHelper {
    
    
    static func showError(_ error: Error) {
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        let roorController = sceneDelegate.window?.rootViewController
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        roorController?.present(alert, animated: true)
    }
    
    
    
}
