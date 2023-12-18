//
//  PersonDataInteractor.swift
//  PruebaTecnia
//
//  Created rnieves on 18/12/23.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//

import UIKit

class PersonDataInteractor: PersonDataInteractorInputProtocol {
    

    // MARK: - Variables

    var presenter: PersonDataPresenterProtocol?
    
    
    func requestPersonData() {
        let networkManager = NetworkManager()

        networkManager.makeRequest(for: .randomuser, method: .get, completionSuccess: { data, code in
            print(data)
            if code == .success {
                do {
                    let response = try
                        JSONDecoder().decode(UserApiResponse.Response.self,
                                             from: data)
                    debugPrint(response.results?.first?.name?.first ?? "no name")
                    self.presenter?.responsePersonData(response: response)
                } catch let error {
                    debugPrint("Can't decode error: \(error)")
                    self.presenter?.responseError()
                }
            }
        }, completionFailure: { error, serverResponse in
            self.presenter?.responseError()
        })

    }

}
