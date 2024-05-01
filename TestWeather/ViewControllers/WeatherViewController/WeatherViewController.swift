//
//  WeatherViewController.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 29.04.2024.
//

import UIKit
import CoreLocation

protocol WeatherViewControllerDelegate: AnyObject {
    func setWeather(_ city: City, _ weather: Weather)
}
 
class WeatherViewController: UIViewController {

    var model = WeatherViewModel()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        self.model.fetchWeather()
        self.setViewToContainer(LoaderView())
    }
    
    private func setViewToContainer(_ view: UIView) {
        self.containerView.subviews.last?.removeFromSuperview()
        self.containerView.addSubview(view)
        view.center = self.containerView.center
    }
    
}

// MARK: - WeatherViewControllerDelegate

extension WeatherViewController: WeatherViewControllerDelegate {
    
    func setWeather(_ city: City, _ weather: Weather) {
        let infoView = WeatherinfoView.loadView()
        infoView.setInfo(city, weather)
        self.setViewToContainer(infoView)
    }
    
}

