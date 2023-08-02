//
//  Extensions+Encodable.swift
//  Instagram
//
//  Created by Jung Choi on 7/29/23.
//

import Foundation

extension Encodable {
    func asJsonObject() -> [String:Any]? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            let json = try JSONSerialization.jsonObject(with: data) as? [String:Any]
            return json
        } catch {
            return nil
        }
    }
    
    func asData() -> Data? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            return data
        } catch {
            return nil
        }
    }
}

extension Decodable {
    init?(dictionary: [String:Any]) {
        guard let data = try? JSONSerialization.data(withJSONObject: dictionary),
              let model = try? JSONDecoder().decode(Self.self, from: data) else {
            return nil
        }
        
        self = model
    }
}
