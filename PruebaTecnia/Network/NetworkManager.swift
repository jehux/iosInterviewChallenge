//
//  NetworkManager.swift
//  PruebaTecnia
//
//  Created by rnieves on 18/12/23.
//

import UIKit

protocol NetworkManagerDelegate: AnyObject {
    func requestResponseData(wsResult: WSResult)
}

enum ServerCodeResponse: Int {
    case timeout                = -1001
    case noInternet             = -1009
    case others                 = 0
    case success                = 200
    case noContent              = 204
    case badRequest             = 400
    case maxUserSession         = 401
    case internalErrorServer    = 500
    case invalidToken           = 92
}

class NetworkManager {

    // MARK: - Variables

    private let session: URLSession = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 120.00
        sessionConfig.timeoutIntervalForResource = 120.00
        return URLSession(configuration: sessionConfig)
    }()
    weak var delegate: NetworkManagerDelegate?
    static func getCommonHeaders() -> [String: String] {
        return [:]
    }

    // MARK: - Methods

    func makeRequest(for endPoint: EndPoint,
                     parameters: Data? = nil,
                     headers: [String: String]? = nil,
                     arguments: String = "",
                     queryParams: [String: String] = [:],
                     method: HTTPMethod = .post,
                     isFormUrlEncoded: Bool = false,
                     completionSuccess: @escaping (Data, ServerCodeResponse) -> Void,
                     completionFailure: @escaping (String, ServerCodeResponse) -> Void) {

        /// URL
        guard let urlForRequest = NetworkAPI.getURL(
            for: endPoint,
            arguments: arguments,
            params: queryParams) else {
                debugPrint("<<< NETWORK MANAGER >>> - Can't create the URL!")
                completionFailure("error de coneccion", .others)
                return
        }

        /// Request
        var request = URLRequest(url: urlForRequest)
        debugPrint("Request: \(request)")

        /// Method
        request.httpMethod = method.rawValue

        /// Headers
        request.allHTTPHeaderFields = createHeaders(endPoint: endPoint, headers: headers,
                                                    isFormUrlEncoded: isFormUrlEncoded)

        /// Body
        request.httpBody = parameters

        let infoURL = request.url?.absoluteString ?? ""
        debugPrint("<<< NETWORK MANAGER >>> - URL: \(infoURL)")
        debugPrint("<<< NETWORK MANAGER >>> - Headers: \(request.allHTTPHeaderFields ?? ["": ""])")
        debugPrint("<<< NETWORK MANAGER >>> - Method: \(method.rawValue)")
        if let requestData = request.httpBody {
            let requestStr = String(decoding: requestData, as: UTF8.self)
            if requestStr.count < 10000 {
                debugPrint("<<< NETWORK MANAGER >>> - Body request (Parameters): \(requestStr)")
            } else {
                let message = """
                    <<< NETWORK MANAGER >>> - Body request (Parameters) too long
                    showing the first 10,000 characters: \(requestStr.prefix(10000))
                """
                debugPrint(message)
            }
        }
        sendDataTask(
            request: request,
            endPoint: endPoint,
            completionSuccess: { data, code in
                DispatchQueue.main.async {
                    completionSuccess(data, code)
                }
            }, completionFailure: { errStr, code in
                DispatchQueue.main.async {
                    completionFailure(errStr, code)
                }
            })
    }

    private func sendDataTask(request: URLRequest,
                              endPoint: EndPoint,
                              completionSuccess: @escaping (Data, ServerCodeResponse) -> Void,
                              completionFailure: @escaping (String, ServerCodeResponse) -> Void) {

        let task = session.dataTask(
        with: request) { data, response, error in
            if let errorInfo = error {
                debugPrint("Error info: \(errorInfo)")
                if errorInfo._code == -1009 {
                    completionFailure("error_no_internet", .noInternet)
                } else if errorInfo._code == -999 {
                    completionFailure("certificate error", .others)
                } else {
                    completionFailure("err_connect", .others)
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completionFailure("err_connect", .others)
                return
            }
            debugPrint("<<< NETWORK MANAGER >>> - Status code: \(httpResponse.statusCode)")
            switch httpResponse.statusCode {
            case 200...299:
                guard let dataResponse = data else {
                    completionFailure("err_connect", .noContent)
                    return
                }
                if dataResponse.getStringValue().count < 10000 {
                    debugPrint("<<< NETWORK MANAGER >>> - Response: \(dataResponse.getStringValue())")
                } else {
                    let message = """
                    <<< NETWORK MANAGER >>> - Response is too long, showing
                    first 10,000 characters: \(dataResponse.getStringValue().prefix(10000))
                    """
                    debugPrint(message)
                }
                do {
                    let response = try JSONDecoder().decode(BaseEntityResponse.Response.self,
                                                                from: dataResponse)
                    if Int(response.response.code ?? "0") == 92 {
                        completionFailure("Su sesión ha caducado", .invalidToken)
                    } else {
                        completionSuccess(dataResponse, .success)
                    }
                } catch let error {
                    debugPrint(error)
                    completionSuccess(dataResponse, .success)
                }
            case 500:
                debugPrint("Data: \(String(decoding: data ?? Data(), as: UTF8.self))")
                completionFailure("error_server_error", .internalErrorServer)
            default:
                debugPrint("Data: \(String(decoding: data ?? Data(), as: UTF8.self))")
                completionFailure("err_connect", .others)
            }
        }
        task.resume()
    }

    // MARK: - Private functions

    private func createHeaders(endPoint: EndPoint, headers: [String: String]?,
                               isFormUrlEncoded: Bool) -> [String: String]? {
        var requestHeaders: [String: String] = [:]
        if isFormUrlEncoded {
            requestHeaders = ["Content-Type": "application/x-www-form-urlencoded"]
        } else {
            requestHeaders = ["Content-Type": "application/json"]
        }
        if let headersInfo = headers {
            requestHeaders = requestHeaders.merge(dict: headersInfo)
        }
        return requestHeaders
    }

}
