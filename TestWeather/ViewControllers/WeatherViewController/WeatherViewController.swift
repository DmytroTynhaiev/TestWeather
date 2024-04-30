//
//  WeatherViewController.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 29.04.2024.
//

import UIKit

protocol WeatherViewControllerDelegate: AnyObject {
    func setWeather(_ weather: Weather)
}
 
class WeatherViewController: UIViewController {

    var model = WeatherViewModel()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.model.delegate = self
        
//        let info = WeatherinfoView.loadView()
//        let loader = LoaderView()
        
        let info = WeatherinfoView.loadView()
        self.setViewToContainer(info)
        self.model.fetchWeather()
                
    }
    
    private func setViewToContainer(_ view: UIView) {
        self.containerView.subviews.last?.removeFromSuperview()
        self.containerView.addSubview(view)
        view.center = self.containerView.center
    }
    
    //MARK: - Actions
    
    @IBAction func searchAction(_ sender: Any) {
        let controller = SearchViewController.instantiate()
        self.present(controller, animated: true)
    }
    
}

extension WeatherViewController: WeatherViewControllerDelegate {
    
    func setWeather(_ weather: Weather) {
        let infoView = WeatherinfoView.loadView()
        infoView.setInfo(weather)
        self.setViewToContainer(infoView)
    
    }
    
}
