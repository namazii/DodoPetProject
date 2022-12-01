//
//  MainTabVC.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit

class MainTabVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
        
        let menuVC = MenuViewController()
        menuVC.tabBarItem = setupTabBarItem(image: "menu", title: "Меню")
        let cartVC = CartViewController()
        cartVC.tabBarItem = setupTabBarItem(image: "basket", title: "Корзина")


        let menuNav = UINavigationController(rootViewController: menuVC)
//        let basketNav = UINavigationController(rootViewController: basketVC)


        self.viewControllers = [menuNav, cartVC]
    }

    private func setupTabBarItem(image: String, title: String) -> UITabBarItem {
        let tabBarItem = UITabBarItem()
        tabBarItem.image = UIImage(named: image)
        tabBarItem.title = title
        return tabBarItem
    }
}
