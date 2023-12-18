//
//  ViewController.swift
//  PruebaTecnia
//
//  Created by rnieves on 18/12/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let vc = MiTabBarController()
        navigationController?.pushViewController(vc, animated: false)
    }
}
