//
//  API.swift
//  RandomUserApp
//
//  Created by sakiyamaK on 2024/07/17.
//

import Foundation

final class API {
    static let shared: API = .init()
    private init() {}
    
    private let host = "https://randomuser.me/api/"
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        // jsonがuser_nameだったとしてもuserNameで受け取れるようになる
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    func getUsers(count: Int = 0) async throws -> [User] {
        let (data, _) = try await URLSession.shared.data(from: URL(string: host + "?results=\(count)")!)
        let jsonStr = String(data: data, encoding: .utf8)
        let responseModel = try decoder.decode(RandomUsersResponse.self, from: data)
        return responseModel.results
    }
}

extension API {
    // APIのレスポンスの型
    struct RandomUsersResponse: Codable {
        let results: [User]
    }
}
