//
//  Observer.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 26.02.2021.
//  Copyright © 2021 Hathway. All rights reserved.
//

protocol Reducible {
    mutating func reduce(_ action: Actionable)
}
