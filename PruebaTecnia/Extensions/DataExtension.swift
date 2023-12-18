//
//  DataExtension.swift
//  PruebaTecnia
//
//  Created by rnieves on 18/12/23.
//

import Foundation

extension Data {

    func getStringValue() -> String {
        return String(decoding: self, as: UTF8.self)
    }

}
