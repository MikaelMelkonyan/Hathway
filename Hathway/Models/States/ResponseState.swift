//
//  ResponseState.swift
//  Hathway
//
//  Created by Mikael Melkonyan on 28.03.2021.
//

enum ResponseState<Success, Error> {
    case none
    case loading
    case loaded(Result<Success, Error>)
}
