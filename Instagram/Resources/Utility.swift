//
//  Utility.swift
//  Instagram
//
//  Created by Jung Choi on 7/30/23.
//

import Foundation

class Utility {
    
    static func decode<T: Decodable>(_ type: T.Type, data: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            return nil
        }
    }
}
