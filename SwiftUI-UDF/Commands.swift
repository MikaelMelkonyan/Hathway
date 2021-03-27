//
//  Command.swift
//  Rocket
//
//  Created by Mikael Melkonyan on 26.02.2021.
//  Copyright © 2021 Rocket. All rights reserved.
//

typealias Command = () -> Void
typealias CommandWith<T> = (T) -> Void
