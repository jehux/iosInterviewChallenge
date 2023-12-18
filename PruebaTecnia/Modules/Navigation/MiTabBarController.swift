//
//  NavigationBarController.swift
//  PruebaTecnia
//
//  Created by rnieves on 18/12/23.
//

import UIKit

class MiTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        let generalViewController = PersonDataRouter.createModule(typeSceen: .general)
        generalViewController.tabBarItem = UITabBarItem(title: "general", image: UIImage(named: "ic_name"), selectedImage: UIImage(named: "ic_name"))
        generalViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)

        let emailViewController = PersonDataRouter.createModule(typeSceen: .email)
        emailViewController.tabBarItem = UITabBarItem(title: "email", image: UIImage(named: "ic_email"), selectedImage: UIImage(named: "ic_email"))

        let birthdayViewController = PersonDataRouter.createModule(typeSceen: .birthday)
        birthdayViewController.tabBarItem = UITabBarItem(title: "cumple", image: UIImage(named: "ic_birthday"), selectedImage: UIImage(named: "ic_birthday"))

        viewControllers = [generalViewController, emailViewController, birthdayViewController]

    }
}
