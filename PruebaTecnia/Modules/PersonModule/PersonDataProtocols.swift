//
//  PersonDataProtocols.swift
//  PruebaTecnia
//
//  Created rnieves on 18/12/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import Foundation
import UIKit


//MARK: View -
protocol PersonDataViewProtocol: AnyObject {

    var presenter: PersonDataPresenterProtocol?  { get set }
    /**
     * Add here your methods for communication __Presenter -> ViewController__
     */
    func responsePersonData(response: UserApiResponse.PersonalData)
    func responseError()
}


//MARK: Interactor -
protocol PersonDataInteractorInputProtocol: AnyObject {
    
    var presenter: PersonDataPresenterProtocol?  { get set }
    
    /**
     * Add here your methods for communication __Presenter -> Interactor__
     */
    func requestPersonData()
    
}

protocol PersonDataInteractorOutputProtocol: AnyObject {
    
    /**
     * Add here your methods for communication __Interactor -> Presenter__
     */
    func responsePersonData(response: UserApiResponse.Response)
    func responseError()
}

//MARK: Presenter -
protocol PersonDataPresenterProtocol: AnyObject {

    var view: PersonDataViewProtocol? { get set }
    var interactor: PersonDataInteractorInputProtocol? { get set }
    var router: PersonDataRouterProtocol? { get set }

    /**
     * Add here your methods for communication __ViewController -> Presenter__
     */
    func requestPersonData()
    func responsePersonData(response: UserApiResponse.Response)
    func responseError()
    func setLabels(_ title: UILabel, _ caption: UILabel, _ image: UIImageView, typeScreen: TypeScreen)
}

//MARK: Router -
protocol PersonDataRouterProtocol: AnyObject {

    /**
     * Add here your methods for communication __Presenter -> Router__
     */
    
}
