//
//  NetworkAPI.swift
//  PruebaTecnia
//
//  Created by rnieves on 18/12/23.
//

import Foundation

class NetworkAPI {

    // MARK: - Public functions
    static func getURL(for endPoint: EndPoint,
                       arguments: String = "",
                       params: [String: String] = [:]) -> URL? {

        let urlObject = URLComponents(string: getBaseURL(for: endPoint) +
            getPath(for: endPoint) + endPoint.rawValue + arguments)
        guard var urlComponents = urlObject else {
            debugPrint("🔴 Can't create the base URL")
            return nil
        }
        for param in params {
            addParam(name: param.key, param.value, to: &urlComponents)
        }
        return urlComponents.url
    }

    // MARK: - Private functions

    /// Add query params to URL
    /// - Parameters:
    ///   - paramName: name of query param
    ///   - value: value to set in param
    ///   - urlComponents: url to add parameters
    private static func addParam(name paramName: String, _ value: String, to urlComponents: inout URLComponents) {
        guard !value.isEmpty else {
            return
        }
        if urlComponents.queryItems == nil {
            urlComponents.queryItems = []
        }
        urlComponents.queryItems?.append(URLQueryItem(name: paramName, value: value))
    }

    static private func getBaseURL(for endPoint: EndPoint) -> String {
        let bundle = Bundle.main
        return bundle.object(forInfoDictionaryKey: "URL_SERVICES") as? String ?? ""
    }

    static private func getPath(for endPoint: EndPoint) -> String {
        let bundle = Bundle.main
        let stgDev = bundle.object(forInfoDictionaryKey: "URL_DEV_REALESE") as? String ?? ""
        switch endPoint {
        case .login, .logout, .randomuser:
            return "/\(stgDev)"
        default:
            return "/\(stgDev)/"
        }
    }

}

enum EndPoint: String {

    case defaultEndpoint    = ""

    // Login
    case login              = "/login"
    case logout             = "/logout"
    case pokemon            = "/pokemon/ditto"
    case randomuser         = "/api"

}

enum HTTPMethod: String {
    case post   = "POST"
    case get    = "GET"
    case put    = "PUT"
    case delete = "DELETE"
    case patch  = "PATCH"
}
