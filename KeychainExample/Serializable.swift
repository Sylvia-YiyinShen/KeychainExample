//
//  Serializable.swift
//  KeychainExample
//
//  Created by Yiyin Shen on 15/4/19.
//  Copyright © 2019 Sylvia. All rights reserved.
//

import Foundation

//protocol Serializable: Codable {
//    init(data: Data?)
//    func encode() -> Data?
//}
//
//extension Serializable {
//    init(data: Data?) {
//        guard let data = data else {
//            return nil
//        }
//
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        self = try! decoder.decode(Self.self, from: data)
//    }
//
//    func encode() -> Data? {
//        let encoder = JSONEncoder()
//        return try? encoder.encode(self)
//    }
//
//    public static func decode<ResponseModel: Decodable>(fromJSONString jsonString: String) -> ResponseModel? {
//        let jsonData = jsonString.data(using: .utf8)!
//
//        let decoder = JSONDecoder()
//        guard let response = try? decoder.decode(ResponseModel.self, from: jsonData) else {
//            return nil
//        }
//        return response
//    }
//}

