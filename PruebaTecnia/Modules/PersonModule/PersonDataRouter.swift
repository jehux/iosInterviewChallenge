//
//  PersonDataRouter.swift
//  PruebaTecnia
//
//  Created rnieves on 18/12/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class PersonDataRouter {

    // MARK: - Variables

    weak var view: PersonDataViewController!

    // MARK: - Functions

    static func createModule(typeSceen: TypeScreen) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = PersonDataViewController()
        let interactor = PersonDataInteractor()
        let router = PersonDataRouter()
        let presenter = PersonDataPresenter(view: view,
                                                                interactor: interactor,
                                                                router: router)
        view.type = typeSceen
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        return view
    }

}

// MARK: - PersonDataRouterProtocol

extension PersonDataRouter: PersonDataRouterProtocol {

}
