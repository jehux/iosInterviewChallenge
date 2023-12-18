//
//  BaseEntities.swift
//  PruebaTecnia
//
//  Created by rnieves on 18/12/23.
//

import Foundation

enum BaseEntityResponse {
    struct Response: Decodable {
        let response: ResponseModel
    }

    struct ResponseModel: Codable {
        let code: String?
        let message: String?

        private enum CodingKeys: String, CodingKey {
            case code = "codigo"
            case message = "mensaje"
        }
    }
}
