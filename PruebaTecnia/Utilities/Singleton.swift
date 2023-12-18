//
//  Singleton.swift
//  PruebaTecnia
//
//  Created by rnieves on 18/12/23.
//

import Foundation

class Singleton {

    public static let shared = Singleton()
    private init() { }

    var personData: UserApiResponse.PersonalData?
}
