//
//  ViewController.swift
//  Nutlix
//
//  Created by Евгений Башун on 08.04.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVCs()
        tabBar.tintColor = .label
        //tabBar.isTranslucent = false
    }
    
    
    private func setupVCs() {
        viewControllers = [
            createNavController(for: HomeViewController(), title: "Home", image: UIImage(systemName: "house")!),
            createNavController(for: UpcomingViewController(), title: "Upcoming", image: UIImage(systemName: "play.circle")!),
            createNavController(for: SearchViewController(), title: "Top Search", image: UIImage(systemName: "magnifyingglass")!),
            createNavController(for: DownloadsViewController(), title: "Downloads", image: UIImage(systemName: "arrow.down.to.line")!)
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
     //   navController.navigationItem.largeTitleDisplayMode = .automatic
        navController.navigationBar.tintColor = .label

        //rootViewController.navigationItem.title = title
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
           // navController.navigationBar.standardAppearance = navBarAppearance
            navController.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        return navController
    }
    
    
}

