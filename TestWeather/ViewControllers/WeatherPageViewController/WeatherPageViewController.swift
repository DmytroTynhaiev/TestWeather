//
//  WeatherPageViewController.swift
//  TestWeather
//
//  Created by Dmytro Tynhaiev on 01.05.2024.
//

import UIKit

class WeatherPageViewController: UIPageViewController {
    
    private var cities: [City] = []
    private var currentIndex: Int = 0
    private var pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
    
    private(set) lazy var controllers: [UIViewController] = {
        return [
            WeatherViewController.instantiate(),
            WeatherViewController.instantiate(),
            WeatherViewController.instantiate(),
        ]
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTopbar()
        self.configureBottombar()
        self.configureBackground()
        self.configurePageController()
    }
    
    // MARK: - private
    
    private func configureTopbar() {
        let image = UIImage(systemName: "magnifyingglass")
        let searchButton = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(searchAction))
        searchButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    private func configureBottombar() {
        let list = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .done, target: self, action: nil)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        self.pageControl.currentPage = 0
        self.pageControl.numberOfPages = controllers.count
        let pageItem = UIBarButtonItem(customView: pageControl)
        self.toolbarItems = [spacer, pageItem, spacer, list]
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.navigationController?.toolbar.tintColor = .white
        
    }
    
    private func configurePageController() {
        self.delegate = self
        self.dataSource = self
        if let firstViewController = controllers.first {
            self.setViewControllers([firstViewController],
                                    direction: .forward,
                                    animated: true,
                                    completion: nil)
        }
    }
    
    private func configureBackground() {
        let imageView = UIImageView(image: .imgBackground)
        self.view.insertSubview(imageView, at: 0)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    // MARK: - Actions
    
    @objc func searchAction() {
        let controller = SearchViewController.instantiate()
        self.present(controller, animated: true)
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
         
        return controllers[viewControllerIndex - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = controllers.firstIndex(of: viewController),
              self.controllers.count != viewControllerIndex + 1,
              self.controllers.count  > viewControllerIndex + 1
        else {
            return nil
        }
        
        return controllers[viewControllerIndex + 1]
    }
   
}

