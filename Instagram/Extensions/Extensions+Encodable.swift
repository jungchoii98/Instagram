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
}
