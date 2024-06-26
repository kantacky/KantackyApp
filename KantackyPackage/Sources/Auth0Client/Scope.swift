//
//  Scope.swift
//
//
//  Created by Kanta Oikawa on 2024/06/05.
//

import Foundation

enum Scope: String, CaseIterable {
    case openid = "openid"
    case profile = "profile"
    case email = "email"
    case offlineAccess = "offline_access"
}

extension Scope {
    static var scopes: String {
        Scope.allCases.map(\.rawValue).joined(separator: " ")
    }
}
