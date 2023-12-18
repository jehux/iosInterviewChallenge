//
//  PersonDataViewController.swift
//  PruebaTecnia
//
//  Created rnieves on 18/12/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit
import Kingfisher

class PersonDataViewController: UIViewController  {

    // MARK: - IBOutlets
    @IBOutlet weak var ivMain: UIImageView!
    @IBOutlet weak var lblCaption: UILabel!
    @IBOutlet weak var lblTitle: UILabel!

    public var type: TypeScreen = .general
    var activityIndicator: UIActivityIndicatorView!

    // MARK: - Presenter
	var presenter: PersonDataPresenterProtocol?

    // MARK: - Lifecycle
	override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        
        if self.type == .general {
            showLoader()
            presenter?.requestPersonData()
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showData()
    }

    // MARK: - Functions
    @IBAction func pressLoadNewUser(_ sender: Any) {
        showLoader()
        presenter?.requestPersonData()
    }

    func showData() {
        presenter?.setLabels(lblTitle, lblCaption, ivMain, typeScreen: type)
    }

    func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "UPS! algo salio mal", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    func showLoader() {
        activityIndicator.startAnimating()
    }

    func hideLoader() {
        activityIndicator.stopAnimating()
    }
}

// MARK: - PersonDataViewProtocol
extension PersonDataViewController: PersonDataViewProtocol {

    func responseError() {
        hideLoader()
        showErrorAlert()
    }

    func responsePersonData(response: UserApiResponse.PersonalData) {
        Singleton.shared.personData = response
        showData()
        hideLoader()
    }

}
