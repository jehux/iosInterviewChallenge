//
//  PersonDataPresenter.swift
//  PruebaTecnia
//
//  Created rnieves on 18/12/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class PersonDataPresenter: PersonDataPresenterProtocol {
    
    // MARK: - Variables

    weak var view: PersonDataViewProtocol?
    var interactor: PersonDataInteractorInputProtocol?
    var router: PersonDataRouterProtocol?

    // MARK: - Initializer

    init(view: PersonDataViewController,
         interactor: PersonDataInteractorInputProtocol,
         router: PersonDataRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func requestPersonData() {
        interactor?.requestPersonData()
    }

    func setLabels(_ title: UILabel, _ caption: UILabel, _ image: UIImageView, typeScreen: TypeScreen) {
        guard let response = Singleton.shared.personData else { return }
        switch typeScreen {
        case .general:
            title.text = "mi nombre es"
            caption.text = response.fullName
        case .email:
            title.text = "mi email es"
            caption.text = response.email
        case .birthday:
            title.text = "mi cumpleaños es"
            caption.text = response.birthday
        }
        let url = URL(string: response.imageUrl)
        image.kf.setImage(with: url)
    }
}

// MARK: - PersonDataInteractorOutputProtocol
extension PersonDataPresenter: PersonDataInteractorOutputProtocol {

    func responseError() {
        view?.responseError()
    }

    func responsePersonData(response: UserApiResponse.Response) {

        guard let name = response.results?.first?.name else { return }
        let email = response.results?.first?.email ?? ""
        let dob = response.results?.first?.dob?.date ?? ""
        let imageUrl = response.results?.first?.picture?.large ?? ""

        let fullName = "\(name.first) \(name.last)"
        let birthday = dob
        let personData = UserApiResponse.PersonalData(fullName: fullName,
                                                      email: email,
                                                      birthday: birthday,
                                                      imageUrl: imageUrl)
        view?.responsePersonData(response: personData)
    }
    
}
