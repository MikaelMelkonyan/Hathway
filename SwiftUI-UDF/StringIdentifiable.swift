//
//  StringIdentifiable.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 28.03.2021.
//

protocol StringIdentifiable: Identifiable {
    static var id: String { get }
}

extension StringIdentifiable {
    static var id: String { String(describing: Self.self) }
}
