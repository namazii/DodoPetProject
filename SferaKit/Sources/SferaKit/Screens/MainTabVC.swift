//
//  MainTabVC.swift
//  test-sfera
//
//  Created by Назар Ткаченко on 27.11.2022.
//

import UIKit

public final class MainTabVC: UITabBarController {
    public override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
        
        let menuVC = MenuAssembly().configure()
        menuVC.tabBarItem = setupTabBarItem(image: "menu", title: "Меню")
        let cartVC = CartAssembly().configure()
        cartVC.tabBarItem = setupTabBarItem(image: "basket", title: "Корзина")


        let menuNav = UINavigationController(rootViewController: menuVC)

        self.viewControllers = [menuNav, cartVC]
    }

    private func setupTabBarItem(image: String, title: String) -> UITabBarItem {
        let tabBarItem = UITabBarItem()
        tabBarItem.image = UIImage(named: image, in: .module, compatibleWith: nil)
        tabBarItem.title = title
        return tabBarItem
    }
}
