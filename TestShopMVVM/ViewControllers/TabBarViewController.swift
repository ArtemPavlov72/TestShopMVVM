//
//  TabBarViewController.swift
//  TestShopMVVM
//
//  Created by Артем Павлов on 19.03.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        navigationItem.title = item.title
    }
    
    //MARK: - Private Methods
    private func setupTabBar() {
        let page1VC = Page1ViewController()
        page1VC.tabBarItem = UITabBarItem(
            title: "Page1",
            image: UIImage(systemName: "house"),
            tag: 1
        )
        
        let favoriteVC = FavoriteViewController()
        favoriteVC.tabBarItem = UITabBarItem(
            title: "Favorite",
            image: UIImage(systemName: "heart"),
            tag: 1
        )
        
        let basketVC = BasketViewController()
        basketVC.tabBarItem = UITabBarItem(
            title: "Basket",
            image: UIImage(systemName: "cart"),
            tag: 1
        )
        
        let chatVC = ChatViewController()
        chatVC.tabBarItem = UITabBarItem(
            title: "Chat",
            image: UIImage(systemName: "message"),
            tag: 1
        )
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            tag: 1
        )
        
        viewControllers = [page1VC, favoriteVC, basketVC, chatVC, profileVC]
        tabBar.backgroundColor = .systemBackground
    }
    
    private func setupNavigationBar() {
        title = tabBar.selectedItem?.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }


}
