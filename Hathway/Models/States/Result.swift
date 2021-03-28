//
//  Result.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 27.03.2021.
//

enum Result<Success, Error> {
    case success(Success)
    case failure(Error)
}
