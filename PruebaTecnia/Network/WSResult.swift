//
//  WSResult.swift
//  PruebaTecnia
//
//  Created by rnieves on 18/12/23.
//

import Foundation

class WSResult: NSObject {

    // MARK: - Variables
    var httpCode: Int
    var message: String
    var data: Data?
    var queryType: QueryType

    // MARK: - Methods
    override init() {
        self.httpCode = 400
        self.message = "No hay respuesta del servidor"
        self.queryType = .none

        super.init()
    }

    /**
     Constructor with http code and message.
     - parameter httpCode: Http code for the result.
     - parameter message: Message for the result.
     */
    init(httpCode: Int? = 400, message: String = "") {
        if let code = httpCode {
            self.httpCode = code
        } else {
            self.httpCode = 400
        }

        self.message = message
        self.queryType = .none

        super.init()
    }

}
