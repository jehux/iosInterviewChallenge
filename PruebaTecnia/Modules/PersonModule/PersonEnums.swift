//
//  PersonEnums.swift
//  PruebaTecnia
//
//  Created by rnieves on 18/12/23.
//

import Foundation

enum UserApiResponse {

    struct Response: Decodable {
        let results: [User]?
        //let info: Info?
    }

    struct User: Codable {
        let gender: String?
        let name: Name?
        let location: Location?
        let email: String?
        let login: Login?
        let dob: DateOfBirth?
        let registered: Registered?
        let phone: String?
        let cell: String?
        let id: ID?
        let picture: Picture?
        let nat: String?
    }

    struct Name: Codable {
        let title: String
        let first: String
        let last: String
    }

    struct Location: Codable {
        let street: Street
        let city: String
        let state: String
        let country: String
        let postcode: Postcode?
        let coordinates: Coordinates
        let timezone: Timezone
    }

    struct Street: Codable {
        let number: Int
        let name: String
    }

    struct Coordinates: Codable {
        let latitude: String
        let longitude: String
    }

    struct Timezone: Codable {
        let offset: String
        let description: String
    }

    struct Login: Codable {
        let uuid: String
        let username: String
        let password: String
        let salt: String
        let md5: String
        let sha1: String
        let sha256: String
    }

    struct DateOfBirth: Codable {
        let date: String
        let age: Int
    }

    struct Registered: Codable {
        let date: String
        let age: Int
    }

    struct ID: Codable {
        let name: String
        let value: String?
    }

    struct Picture: Codable {
        let large: String
        let medium: String
        let thumbnail: String
    }

    struct Info: Codable {
        let seed: String
        let results: Int
        let page: Int
        let version: String
    }

    enum Postcode: Codable {
        case int(Int)
        case string(String)

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let intValue = try? container.decode(Int.self) {
                self = .int(intValue)
            } else if let stringValue = try? container.decode(String.self) {
                self = .string(stringValue)
            } else {
                throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Postcode no es ni Int ni String"))
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .int(let intValue):
                try container.encode(intValue)
            case .string(let stringValue):
                try container.encode(stringValue)
            }
        }
    }

    struct PersonalData {
        let fullName: String
        let email: String
        let birthday: String
        let imageUrl: String
    }

}

