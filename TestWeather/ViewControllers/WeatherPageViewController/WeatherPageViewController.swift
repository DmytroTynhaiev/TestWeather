//
//  WeatherPageViewController.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 01.05.2024.
//

import UIKit

protocol WeatherPageViewControllerDelegate: AnyObject {
    func configurePageController(with cities: [City])
}

class WeatherPageViewController: UIPageViewController, WeatherPageViewControllerDelegate {
    
    private var viewModel = WeatherPageViewModel()
    private var currentIndex: Int = 0
    private var pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
    private var controllers: [UIViewController] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        self.viewModel.delegate = self
        self.configureBottombar()
        self.configureBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getCities()
    }
    
    // MARK: - private
    
    private func configureBackground() {
        let imageView = UIImageView(image: .imgBackground)
        self.view.insertSubview(imageView, at: 0)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    private func configureBottombar() {
        let list = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .done, target: self, action: #selector(searchAction))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let pageItem = UIBarButtonItem(customView: self.pageControl)
        
        self.pageControl.numberOfPages = self.controllers.count
        
        self.toolbarItems = [spacer, pageItem, spacer, list]
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.toolbar.tintColor = .white
        
    }
    
    func configurePageController(with cities: [City]) {
        
        self.controllers = cities.compactMap {
            let controller = WeatherViewController.instantiate()
            controller.city = $0
            return controller
        }
        
        if !self.controllers.isEmpty {
            self.pageControl.currentPage = 0
            self.pageControl.numberOfPages = cities.count
            self.setViewControllers([self.controllers.first!], direction: .forward, animated: true, completion: nil)
            self.configureBottombar()
        }
    }

    // MARK: - Actions
    
    @objc func searchAction() {
        let controller = SearchViewController.instantiate()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

// MARK: - UIPageViewControllerDataSource, UIPageViewControllerDelegate

extension WeatherPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
        
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = controllers.firstIndex(of: viewController),
              viewControllerIndex - 1 >= 0,
              self.controllers.count > viewControllerIndex - 1
        else {
            return nil
        }
         
        self.pageControl.currentPage -= 1
        return controllers[viewControllerIndex - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = controllers.firstIndex(of: viewController),
              self.controllers.count != viewControllerIndex + 1,
              self.controllers.count  > viewControllerIndex + 1
        else {
            return nil
        }
        
        self.pageControl.currentPage += 1
        return controllers[viewControllerIndex + 1]
    }
   
}

